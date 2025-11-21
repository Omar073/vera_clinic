import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';
import 'package:vera_clinic/Core/Model/Firebase/ClientMonthlyFollowUpFirestoreMethods.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import '../Core/Services/DebugLoggerService.dart';

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
      mDebug('Starting CMFU date backfill...');
      final QuerySnapshot snapshot =
          await _firestore.collection('ClientMonthlyFollowUp').get();

      if (snapshot.docs.isEmpty) {
        mDebug('No documents found in ClientMonthlyFollowUp.');
        return;
      }

      mDebug(
          'Found ${snapshot.docs.length} ClientMonthlyFollowUp documents to process');
      int updated = 0;
      int skipped = 0;
      int errors = 0;
      final WriteBatch batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          mDebug('Skipping document with null data');
          continue;
        }

        final String cmfuId = doc.id;
        final String clientId = (data['clientId'] ?? '').toString();
        mDebug('Processing CMFU ID: $cmfuId for Client ID: $clientId');

        // Skip if date already exists
        if (data.containsKey('date') && data['date'] != null) {
          mDebug('  -> CMFU $cmfuId already has date, skipping');
          skipped++;
          continue;
        }

        if (clientId.isEmpty) {
          mDebug('  -> CMFU $cmfuId has empty clientId, skipping');
          errors++;
          continue;
        }

        // Fetch client to get lastVisitId, then fetch that visit
        // mDebug('  -> Fetching client $clientId to get lastVisitId');
        final client = await _clientProvider.getClientById(clientId);
        if (client == null) {
          mDebug('  -> Client $clientId not found, skipping CMFU $cmfuId');
          errors++;
          continue;
        }

        final String lastVisitId = client.mLastVisitId ?? '';
        if (lastVisitId.isEmpty) {
          mDebug(
              '  -> Client $clientId has no lastVisitId, skipping CMFU $cmfuId');
          errors++;
          continue;
        }

        // mDebug('  -> Fetching visit $lastVisitId for client $clientId');
        final lastVisit = await _visitProvider.getVisit(lastVisitId);
        if (lastVisit == null) {
          mDebug(
              '  -> Visit $lastVisitId not found, skipping CMFU $cmfuId');
          errors++;
          continue;
        }

        final DateTime latest = lastVisit.mDate;
        mDebug('  -> Setting date ${latest.toString()} for CMFU $cmfuId');
        batch.update(doc.reference, {'date': latest});
        updated++;
      }

      if (updated > 0) {
        mDebug('Committing batch update for $updated CMFU documents...');
        await batch.commit();
        mDebug(
            'Successfully backfilled date for $updated ClientMonthlyFollowUp docs.');
      } else {
        mDebug('No CMFU documents needed date backfill.');
      }

      mDebug(
          'Migration summary: $updated updated, $skipped skipped, $errors errors');
    } catch (e) {
      mDebug('Error backfilling CMFU date: $e');
    }
  }

  //operation done on the clients collection
  //what this method does is that it backfills the lastMonthlyFollowUpId
  // field in the clients collection with the id of the latest
  // clientMonthlyFollowUp document for the client
  Future<void> backfillClientLastMonthlyFollowUpId() async {
    try {
      mDebug('Starting backfill of lastMonthlyFollowUpId on clients...');
      final QuerySnapshot<Map<String, dynamic>> clientsSnapshot =
          await _firestore.collection('Clients').get();

      if (clientsSnapshot.docs.isEmpty) {
        mDebug('No clients found.');
        return;
      }

      mDebug('Found ${clientsSnapshot.docs.length} clients to process');
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
          mDebug('Skipping client with empty clientId');
          errors++;
          continue;
        }

        mDebug('Processing Client ID: $clientId');
        final String singleId =
            (clientData['clientMonthlyFollowUpId'] ?? '').toString();
        final String lastId =
            (clientData['lastMonthlyFollowUpId'] ?? '').toString();
        mDebug('  -> Old field (clientMonthlyFollowUpId): $singleId');
        mDebug('  -> New field (lastMonthlyFollowUpId): $lastId');

        // Prefer replacing old single field with the new field
        if (singleId.isNotEmpty) {
          mDebug('  -> Client has old field, migrating to new field');
          // Ensure the referenced CMFU has a date; if missing, try to set from last visit
          final cmfuRef =
              _firestore.collection('ClientMonthlyFollowUp').doc(singleId);
          final cmfu =
              await _cmfuMethods.fetchClientMonthlyFollowUpById(singleId);
          if (cmfu != null && cmfu.mDate == null) {
            mDebug(
                '  -> CMFU $singleId missing date, attempting to backfill from last visit');
            // Try to use client's lastVisitId
            final String lastVisitId =
                (clientData['lastVisitId'] ?? '').toString();
            if (lastVisitId.isNotEmpty) {
              mDebug(
                  '  -> Using lastVisitId $lastVisitId to set CMFU date');
              final visit = await _visitProvider.getVisit(lastVisitId);
              if (visit != null) {
                mDebug(
                    '  -> Setting CMFU $singleId date to ${visit.mDate}');
                batch.update(cmfuRef, {'date': visit.mDate});
              } else {
                mDebug(
                    '  -> Visit $lastVisitId not found, skipping date backfill');
              }
            } else {
              mDebug(
                  '  -> Client has no lastVisitId, skipping date backfill');
            }
          } else if (cmfu != null) {
            mDebug(
                '  -> CMFU $singleId already has date, no backfill needed');
          } else {
            mDebug('  -> CMFU $singleId not found, skipping date backfill');
          }

          // Set new field and remove old
          mDebug(
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
          mDebug(
              '  -> Client has no lastMonthlyFollowUpId, attempting to infer from latest CMFU');
          final QuerySnapshot<Map<String, dynamic>> querySnapshot =
              await _firestore
                  .collection('ClientMonthlyFollowUp')
                  .where('clientId', isEqualTo: clientId)
                  .orderBy('date', descending: true)
                  .limit(1)
                  .get();

          if (querySnapshot.docs.isEmpty) {
            mDebug(
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
            mDebug('  -> Latest CMFU has empty ID, skipping');
            errors++;
            continue;
          }

          mDebug(
              '  -> Setting lastMonthlyFollowUpId to inferred ID: $inferredId');
          batch.update(clientDoc.reference, {
            'lastMonthlyFollowUpId': inferredId,
          });
          updated++;
        } else {
          mDebug('  -> Client already has lastMonthlyFollowUpId: $lastId');
          // New field already present; clean up old field if it exists
          if (clientData.containsKey('clientMonthlyFollowUpId')) {
            mDebug('  -> Cleaning up old field clientMonthlyFollowUpId');
            batch.update(clientDoc.reference, {
              'clientMonthlyFollowUpId': FieldValue.delete(),
            });
          }
          skipped++;
        }
      }

      if (updated > 0) {
        mDebug('Committing batch update for $updated client documents...');
        // This line commits all the update operations in the Firestore batch, applying them to the database atomically.
        await batch.commit();
        mDebug(
            'Successfully backfilled lastMonthlyFollowUpId for $updated clients.');
      } else {
        mDebug('No clients needed lastMonthlyFollowUpId backfill.');
      }

      mDebug(
          'Migration summary: $updated updated, $skipped skipped, $errors errors');
    } catch (e) {
      mDebug('Error backfilling lastMonthlyFollowUpId: $e');
    }
  }

  //operation done on the clientMonthlyFollowUp collection
  //what this method does is that it backfills the notes field in the
  //clientMonthlyFollowUp collection with an empty string for documents that don't have it
  Future<void> backfillClientMonthlyFollowUpNotes() async {
    try {
      mDebug('Starting CMFU notes backfill...');
      final QuerySnapshot snapshot =
          await _firestore.collection('ClientMonthlyFollowUp').get();

      if (snapshot.docs.isEmpty) {
        mDebug('No documents found in ClientMonthlyFollowUp.');
        return;
      }

      mDebug(
          'Found ${snapshot.docs.length} ClientMonthlyFollowUp documents to process');
      int updated = 0;
      int skipped = 0;
      int errors = 0;
      final WriteBatch batch = _firestore.batch();

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data == null) {
          mDebug('Skipping document with null data');
          continue;
        }

        final String cmfuId = doc.id;
        mDebug('Processing CMFU ID: $cmfuId');

        // Skip if notes field already exists
        if (data.containsKey('notes') && data['notes'] != null) {
          mDebug('  -> CMFU $cmfuId already has notes field, skipping');
          skipped++;
          continue;
        }

        mDebug('  -> Setting empty notes field for CMFU $cmfuId');
        batch.update(doc.reference, {'notes': ''});
        updated++;
      }

      if (updated > 0) {
        mDebug('Committing batch update for $updated CMFU documents...');
        await batch.commit();
        mDebug(
            'Successfully backfilled notes field for $updated ClientMonthlyFollowUp docs.');
      } else {
        mDebug('No CMFU documents needed notes field backfill.');
      }

      mDebug(
          'Migration summary: $updated updated, $skipped skipped, $errors errors');
    } catch (e) {
      mDebug('Error backfilling CMFU notes: $e');
    }
  }

  /// operation done on the Clients collection
  /// deletes any client document that does not have a non-empty clientId field
  Future<void> deleteClientsWithEmptyId() async {
    try {
      mDebug('Starting cleanup: deleting clients without valid clientId...');

      final QuerySnapshot<Map<String, dynamic>> clientsSnapshot =
          await _firestore.collection('Clients').get();

      if (clientsSnapshot.docs.isEmpty) {
        mDebug('No clients found.');
        return;
      }

      int deleted = 0;
      int skipped = 0;

      for (final doc in clientsSnapshot.docs) {
        final data = doc.data();
        final String clientId = (data['clientId'] ?? '').toString().trim();

        if (clientId.isEmpty) {
          mDebug(
              'Deleting client document ${doc.id} with empty/invalid clientId...');
          await doc.reference.delete();
          deleted++;
        } else {
          skipped++;
        }
      }

      mDebug(
          'Client cleanup done. Deleted: $deleted, Kept (valid ID): $skipped');
    } catch (e) {
      mDebug('Error deleting clients without ID: $e');
    }
  }

  Future<void> syncClientWeightAndDietFromLatestRecords() async {
    try {
      mDebug('Starting client weight/diet sync migration...');
      final clientsSnapshot = await _firestore.collection('Clients').get();
      if (clientsSnapshot.docs.isEmpty) {
        mDebug('No clients found for migration.');
        return;
      }

      int updated = 0;
      int skipped = 0;
      int errors = 0;

      for (final clientDoc in clientsSnapshot.docs) {
        try {
          final data = clientDoc.data() as Map<String, dynamic>? ?? {};
          final clientId = (data['clientId'] ?? '').toString().trim();
          mDebug('--- Processing client docId=${clientDoc.id}, clientId="$clientId" ---');

          if (clientId.isEmpty) {
            errors++;
            mDebug('  -> Skipping: empty clientId.');
            continue;
          }

          final double? currentWeight =
              (data['weight'] as num?)?.toDouble();
          final String currentDiet =
              (data['diet'] ?? '').toString().trim();

          Visit? latestVisit;
          final client = await _clientProvider.getClientById(clientId);
          if (client?.mLastVisitId != null &&
              client!.mLastVisitId!.trim().isNotEmpty) {
            // mDebug(
                // '  -> Fetching latest visit by lastVisitId=${client.mLastVisitId}');
            latestVisit = await _visitProvider.getVisit(client.mLastVisitId!);
          }

          // mDebug('  -> Fetching latest CMFU for clientId=$clientId');
          final latestCmfu =
              await _cmfuMethods.fetchLastClientMonthlyFollowUp(clientId);

          double? latestWeight;
          DateTime? latestWeightDate;
          String? latestDiet;

          if (latestVisit != null) {
            latestDiet = latestVisit.mDiet.trim();
            final visitWeight = latestVisit.mWeight;
            final visitDate = latestVisit.mDate;
            if (visitWeight > 0) {
              latestWeight = visitWeight;
              latestWeightDate = visitDate;
            }
          }

          if (latestCmfu != null) {
            final cmfuWeight = latestCmfu.mMaxWeight;
            final DateTime? cmfuDate = latestCmfu.mDate;
            final bool isMoreRecent = cmfuDate != null &&
                (latestWeightDate == null ||
                    cmfuDate.isAfter(latestWeightDate));
            if (cmfuWeight != null && cmfuWeight > 0 && isMoreRecent) {
              latestWeight = cmfuWeight;
              latestWeightDate = cmfuDate;
            }
          }

          final Map<String, dynamic> updates = {};

          if (latestWeight != null &&
              latestWeight > 0 &&
              (currentWeight == null ||
                  (currentWeight - latestWeight).abs() > 0.01)) {
            updates['weight'] = latestWeight;
          }

          if (latestDiet != null &&
              latestDiet.isNotEmpty &&
              latestDiet != currentDiet) {
            updates['diet'] = latestDiet;
          }

          if (updates.isNotEmpty) {
            await clientDoc.reference.update(updates);
            mDebug(
                '  -> Updated clientId=$clientId | '
                'weight: ${currentWeight ?? 'null'} -> ${updates['weight'] ?? currentWeight}, '
                'diet: "${currentDiet.isEmpty ? 'null' : currentDiet}" -> "${updates['diet'] ?? currentDiet}"');
            updated++;
          } else {
            mDebug(
                '  -> Skipped (no changes needed). '
                'currentWeight=${currentWeight ?? 'null'}, latestWeight=${latestWeight ?? 'null'}, '
                'currentDiet="${currentDiet.isEmpty ? 'null' : currentDiet}", '
                'latestDiet="${latestDiet ?? 'null'}"');
            skipped++;
          }
        } catch (e) {
          errors++;
          mDebug('  -> Error processing client migration: $e');
        }
      }

      mDebug(
          'Client weight/diet sync migration done. Updated: $updated, Skipped: $skipped, Errors: $errors');
    } catch (e) {
      mDebug('Error running weight/diet migration: $e');
    }
  }

}
