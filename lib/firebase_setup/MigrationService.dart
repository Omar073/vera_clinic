import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';
import 'package:vera_clinic/Core/Model/Firebase/ClientMonthlyFollowUpFirestoreMethods.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';

class MigrationService {
  final FirebaseFirestore _firestore = FirebaseSingleton.instance.firestore;
  final ClientMonthlyFollowUpFirestoreMethods _cmfuMethods =
      ClientMonthlyFollowUpFirestoreMethods();
  final ClientProvider _clientProvider = ClientProvider();
  final VisitProvider _visitProvider = VisitProvider();

// operation done on the clientMonthlyFollowUp collection
// what this method does is that it backfills the date field in the
// clientMonthlyFollowUp collection with the date of the last visit
  Future<void> backfillMonthlyFollowUpDateFromLastVisit() async {
    try {
      debugPrint('Starting CMFU date backfill...');
      final QuerySnapshot snapshot =
          await _firestore.collection('ClientMonthlyFollowUp').get();

      if (snapshot.docs.isEmpty) {
        debugPrint('No documents found in ClientMonthlyFollowUp.');
        return;
      }

      debugPrint(
          'Found ${snapshot.docs.length} ClientMonthlyFollowUp documents to process');
      int updated = 0;
      int skipped = 0;
      int errors = 0;
      final WriteBatch batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          debugPrint('Skipping document with null data');
          continue;
        }

        final String cmfuId = doc.id;
        final String clientId = (data['clientId'] ?? '').toString();
        debugPrint('Processing CMFU ID: $cmfuId for Client ID: $clientId');

        // Skip if date already exists
        if (data.containsKey('date') && data['date'] != null) {
          debugPrint('  -> CMFU $cmfuId already has date, skipping');
          skipped++;
          continue;
        }

        if (clientId.isEmpty) {
          debugPrint('  -> CMFU $cmfuId has empty clientId, skipping');
          errors++;
          continue;
        }

        // Fetch client to get lastVisitId, then fetch that visit
        debugPrint('  -> Fetching client $clientId to get lastVisitId');
        final client = await _clientProvider.getClientById(clientId);
        if (client == null) {
          debugPrint('  -> Client $clientId not found, skipping CMFU $cmfuId');
          errors++;
          continue;
        }

        final String lastVisitId = client.mLastVisitId ?? '';
        if (lastVisitId.isEmpty) {
          debugPrint(
              '  -> Client $clientId has no lastVisitId, skipping CMFU $cmfuId');
          errors++;
          continue;
        }

        debugPrint('  -> Fetching visit $lastVisitId for client $clientId');
        final lastVisit = await _visitProvider.getVisit(lastVisitId);
        if (lastVisit == null) {
          debugPrint(
              '  -> Visit $lastVisitId not found, skipping CMFU $cmfuId');
          errors++;
          continue;
        }

        final DateTime latest = lastVisit.mDate;
        debugPrint('  -> Setting date ${latest.toString()} for CMFU $cmfuId');
        batch.update(doc.reference, {'date': latest});
        updated++;
      }

      if (updated > 0) {
        debugPrint('Committing batch update for $updated CMFU documents...');
        await batch.commit();
        debugPrint(
            'Successfully backfilled date for $updated ClientMonthlyFollowUp docs.');
      } else {
        debugPrint('No CMFU documents needed date backfill.');
      }

      debugPrint(
          'Migration summary: $updated updated, $skipped skipped, $errors errors');
    } catch (e) {
      debugPrint('Error backfilling CMFU date: $e');
    }
  }

  //operation done on the clients collection
  //what this method does is that it backfills the lastMonthlyFollowUpId
  // field in the clients collection with the id of the latest
  // clientMonthlyFollowUp document for the client
  Future<void> backfillClientLastMonthlyFollowUpId() async {
    try {
      debugPrint('Starting backfill of lastMonthlyFollowUpId on clients...');
      final QuerySnapshot<Map<String, dynamic>> clientsSnapshot =
          await _firestore.collection('Clients').get();

      if (clientsSnapshot.docs.isEmpty) {
        debugPrint('No clients found.');
        return;
      }

      debugPrint('Found ${clientsSnapshot.docs.length} clients to process');
      int updated = 0;
      int skipped = 0;
      int errors = 0;
      final WriteBatch batch = _firestore.batch();

      // this map is key:clientId, value:clientData
      for (final QueryDocumentSnapshot<Map<String, dynamic>> clientDoc
          in clientsSnapshot.docs) {
        final Map<String, dynamic> clientData = clientDoc.data();

        final String clientId = (clientData['clientId'] ?? '').toString();
        if (clientId.isEmpty) {
          debugPrint('Skipping client with empty clientId');
          errors++;
          continue;
        }

        debugPrint('Processing Client ID: $clientId');
        final String singleId =
            (clientData['clientMonthlyFollowUpId'] ?? '').toString();
        final String lastId =
            (clientData['lastMonthlyFollowUpId'] ?? '').toString();
        debugPrint('  -> Old field (clientMonthlyFollowUpId): $singleId');
        debugPrint('  -> New field (lastMonthlyFollowUpId): $lastId');

        // Prefer replacing old single field with the new field
        if (singleId.isNotEmpty) {
          debugPrint('  -> Client has old field, migrating to new field');
          // Ensure the referenced CMFU has a date; if missing, try to set from last visit
          final cmfuRef =
              _firestore.collection('ClientMonthlyFollowUp').doc(singleId);
          final cmfu =
              await _cmfuMethods.fetchClientMonthlyFollowUpById(singleId);
          if (cmfu != null && cmfu.mDate == null) {
            debugPrint(
                '  -> CMFU $singleId missing date, attempting to backfill from last visit');
            // Try to use client's lastVisitId
            final String lastVisitId =
                (clientData['lastVisitId'] ?? '').toString();
            if (lastVisitId.isNotEmpty) {
              debugPrint(
                  '  -> Using lastVisitId $lastVisitId to set CMFU date');
              final visit = await _visitProvider.getVisit(lastVisitId);
              if (visit != null) {
                debugPrint(
                    '  -> Setting CMFU $singleId date to ${visit.mDate}');
                batch.update(cmfuRef, {'date': visit.mDate});
              } else {
                debugPrint(
                    '  -> Visit $lastVisitId not found, skipping date backfill');
              }
            } else {
              debugPrint(
                  '  -> Client has no lastVisitId, skipping date backfill');
            }
          } else if (cmfu != null) {
            debugPrint(
                '  -> CMFU $singleId already has date, no backfill needed');
          } else {
            debugPrint('  -> CMFU $singleId not found, skipping date backfill');
          }

          // Set new field and remove old
          debugPrint(
              '  -> Setting lastMonthlyFollowUpId to $singleId and removing old field');
          batch.update(clientDoc.reference, {
            'lastMonthlyFollowUpId': singleId,
            'clientMonthlyFollowUpId': FieldValue.delete(),
          });
          updated++;
          continue; //* done with this client
        }

        // If no single old field, and new field is missing, attempt to infer from latest CMFU by date
        if (lastId.isEmpty) {
          debugPrint(
              '  -> Client has no lastMonthlyFollowUpId, attempting to infer from latest CMFU');
          final QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await _firestore
                  .collection('ClientMonthlyFollowUp')
                  .where('clientId', isEqualTo: clientId)
                  .orderBy('date', descending: true)
                  .limit(1)
                  .get();

          if (querySnapshot.docs.isEmpty) {
            debugPrint(
                '  -> No CMFU found for client $clientId, setting empty lastMonthlyFollowUpId');
            batch.update(clientDoc.reference, {
              'lastMonthlyFollowUpId': '',
            });
            updated++;
            continue;
          }

          final String inferredId = querySnapshot.docs.first
              .data()['clientMonthlyFollowUpId']
              .toString();
          if (inferredId.isEmpty) {
            debugPrint('  -> Latest CMFU has empty ID, skipping');
            errors++;
            continue;
          }

          debugPrint(
              '  -> Setting lastMonthlyFollowUpId to inferred ID: $inferredId');
          batch.update(clientDoc.reference, {
            'lastMonthlyFollowUpId': inferredId,
          });
          updated++;
        } else {
          debugPrint('  -> Client already has lastMonthlyFollowUpId: $lastId');
          // New field already present; clean up old field if it exists
          if (clientData.containsKey('clientMonthlyFollowUpId')) {
            debugPrint('  -> Cleaning up old field clientMonthlyFollowUpId');
            batch.update(clientDoc.reference, {
              'clientMonthlyFollowUpId': FieldValue.delete(),
            });
          }
          skipped++;
        }
      }

      if (updated > 0) {
        debugPrint('Committing batch update for $updated client documents...');
        // This line commits all the update operations in the Firestore batch, applying them to the database atomically.
        await batch.commit();
        debugPrint(
            'Successfully backfilled lastMonthlyFollowUpId for $updated clients.');
      } else {
        debugPrint('No clients needed lastMonthlyFollowUpId backfill.');
      }

      debugPrint(
          'Migration summary: $updated updated, $skipped skipped, $errors errors');
    } catch (e) {
      debugPrint('Error backfilling lastMonthlyFollowUpId: $e');
    }
  }

  //operation done on the clientMonthlyFollowUp collection
  //what this method does is that it backfills the notes field in the
  //clientMonthlyFollowUp collection with an empty string for documents that don't have it
  Future<void> backfillClientMonthlyFollowUpNotes() async {
    try {
      debugPrint('Starting CMFU notes backfill...');
      final QuerySnapshot snapshot =
          await _firestore.collection('ClientMonthlyFollowUp').get();

      if (snapshot.docs.isEmpty) {
        debugPrint('No documents found in ClientMonthlyFollowUp.');
        return;
      }

      debugPrint(
          'Found ${snapshot.docs.length} ClientMonthlyFollowUp documents to process');
      int updated = 0;
      int skipped = 0;
      int errors = 0;
      final WriteBatch batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          debugPrint('Skipping document with null data');
          continue;
        }

        final String cmfuId = doc.id;
        debugPrint('Processing CMFU ID: $cmfuId');

        // Skip if notes field already exists
        if (data.containsKey('notes') && data['notes'] != null) {
          debugPrint('  -> CMFU $cmfuId already has notes field, skipping');
          skipped++;
          continue;
        }

        debugPrint('  -> Setting empty notes field for CMFU $cmfuId');
        batch.update(doc.reference, {'notes': ''});
        updated++;
      }

      if (updated > 0) {
        debugPrint('Committing batch update for $updated CMFU documents...');
        await batch.commit();
        debugPrint(
            'Successfully backfilled notes field for $updated ClientMonthlyFollowUp docs.');
      } else {
        debugPrint('No CMFU documents needed notes field backfill.');
      }

      debugPrint(
          'Migration summary: $updated updated, $skipped skipped, $errors errors');
    } catch (e) {
      debugPrint('Error backfilling CMFU notes: $e');
    }
  }
}
