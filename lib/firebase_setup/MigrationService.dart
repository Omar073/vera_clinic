import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/foundation.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';

class MigrationService {
  final FirebaseFirestore _firestore = FirebaseSingleton.instance.firestore;

  Future<void> migrateWaterFieldToString() async {
    try {
      debugPrint('Starting water field migration...');
      final QuerySnapshot snapshot =
          await _firestore.collection('ClientMonthlyFollowUp').get();

      if (snapshot.docs.isEmpty) {
        debugPrint('No documents found in ClientMonthlyFollowUp. Migration not needed.');
        return;
      }

      final WriteBatch batch = _firestore.batch();
      int migratedDocsCount = 0;

      for (final doc in snapshot.docs) {
        final data = doc.data() as Map<String, dynamic>?;
        if (data != null &&
            data.containsKey('water') &&
            data['water'] is num) {
          final double waterValue = (data['water'] as num).toDouble();
          batch.update(doc.reference, {'water': waterValue.toString()});
          migratedDocsCount++;
        }
      }

      if (migratedDocsCount > 0) {
        await batch.commit();
        debugPrint(
            'Successfully migrated water field for $migratedDocsCount documents.');
      } else {
        debugPrint('All water fields are already strings. No migration needed.');
      }
    } catch (e) {
      debugPrint('An error occurred during water field migration: $e');
    }
  }
} 