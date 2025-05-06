import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/Clinic.dart';
import 'FirebaseSingelton.dart';

class ClinicFirestoreMethods {
  static const String clinicDocumentId = '52g2WUMJjoTwbu6ioE96';
  final r = RetryOptions(maxAttempts: 3);

  Future<Clinic?> fetchClinic() async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      final docSnapshot = await r.retry(
        () => clinicRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching clinic found');
      }

      return Clinic.fromFirestore(docSnapshot.data()!);
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching clinic: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unknown error fetching clinic: $e');
      return null;
    }
  }

  Future<void> updateClinic(Clinic clinic) async {
    try {
      final clinicRef = FirebaseSingleton.instance.firestore
          .collection('Clinic')
          .doc(clinicDocumentId);

      final docSnapshot = await r.retry(
        () => clinicRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching clinic found');
      }

      await r.retry(
        () => clinicRef.update(clinic.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating clinic: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error updating clinic: $e');
    }
  }
}
