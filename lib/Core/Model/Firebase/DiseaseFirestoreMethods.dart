import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/Disease.dart';
import 'FirebaseSingelton.dart';

import '../../../Core/Services/DebugLoggerService.dart';
class DiseaseFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createDisease(Disease disease) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Diseases')
            .add(disease.toMap()),
        retryIf: (e) => true,
      );
      await docRef.update({'diseaseId': docRef.id});

      return docRef.id;
    } on FirebaseException catch (e) {
      mDebug('Firebase error creating disease: ${e.message}');
      return '';
    } catch (e) {
      mDebug('Unknown error creating disease: $e');
      return '';
    }
  }

  Future<Disease?> fetchDiseaseByClientId(String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Diseases')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : Disease.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      mDebug('Firebase error fetching disease by client ID: ${e.message}');
      return null;
    } catch (e) {
      mDebug('Unknown error fetching disease by client ID: $e');
      return null;
    }
  }

  Future<Disease?> fetchDiseaseById(String diseaseId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Diseases')
            .where('diseaseId', isEqualTo: diseaseId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : Disease.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      mDebug('Firebase error fetching disease by ID: ${e.message}');
      return null;
    } catch (e) {
      mDebug('Unknown error fetching disease by ID: $e');
      return null;
    }
  }

  Future<void> updateDisease(Disease disease) async {
    try {
      final diseaseRef = FirebaseSingleton.instance.firestore
          .collection('Diseases')
          .doc(disease.mDiseaseId);

      final docSnapshot = await r.retry(
        () => diseaseRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching disease found with diseaseId: ${disease.mDiseaseId}');
      }

      await r.retry(
        () => diseaseRef.update(disease.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error updating disease: ${e.message}');
    } catch (e) {
      mDebug('Unknown error updating disease: $e');
    }
  }

  Future<void> deleteDisease(String diseaseId) async {
    try {
      final diseaseRef = FirebaseSingleton.instance.firestore
          .collection('Diseases')
          .doc(diseaseId);

      final docSnapshot = await r.retry(
        () => diseaseRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching disease found with diseaseId: $diseaseId');
      }

      await r.retry(
        () => diseaseRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error deleting disease: ${e.message}');
    } catch (e) {
      mDebug('Unknown error deleting disease: $e');
    }
  }
}
