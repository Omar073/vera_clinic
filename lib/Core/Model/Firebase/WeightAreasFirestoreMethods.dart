import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/WeightAreas.dart';
import 'FirebaseSingelton.dart';

import '../../../Core/Services/DebugLoggerService.dart';
class WeightAreasFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createWeightAreas(WeightAreas weightAreas) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('WeightAreas')
            .add(weightAreas.toMap()),
        retryIf: (e) => true,
      );
      await docRef.update({'weightAreasId': docRef.id});
      return docRef.id;
    } on FirebaseException catch (e) {
      mDebug('Firebase error creating weight areas: ${e.message}');
      return '';
    } catch (e) {
      mDebug('Unknown error creating weight areas: $e');
      return '';
    }
  }

  Future<WeightAreas?> fetchWeightAreasByClientId(String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('WeightAreas')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : WeightAreas.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      mDebug(
          'Firebase error fetching weight areas by client ID: ${e.message}');
      return null;
    } catch (e) {
      mDebug('Unknown error fetching weight areas by client ID: $e');
      return null;
    }
  }

  Future<WeightAreas?> fetchWeightAreasById(String weightAreasId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('WeightAreas')
            .where('weightAreasId', isEqualTo: weightAreasId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : WeightAreas.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      mDebug('Firebase error fetching weight areas by ID: ${e.message}');
      return null;
    } catch (e) {
      mDebug('Unknown error fetching weight areas by ID: $e');
      return null;
    }
  }

  Future<void> updateWeightAreas(WeightAreas weightAreas) async {
    try {
      final weightAreasRef = FirebaseSingleton.instance.firestore
          .collection('WeightAreas')
          .doc(weightAreas.mWeightAreasId);

      final docSnapshot = await r.retry(
        () => weightAreasRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching weight areas found with weightAreasId: ${weightAreas.mWeightAreasId}');
      }

      await r.retry(
        () => weightAreasRef.update(weightAreas.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error updating weight areas: ${e.message}');
    } catch (e) {
      mDebug('Unknown error updating weight areas: $e');
    }
  }

  Future<void> deleteWeightAreas(String weightAreasId) async {
    try {
      final weightAreasRef = FirebaseSingleton.instance.firestore
          .collection('WeightAreas')
          .doc(weightAreasId);

      final docSnapshot = await r.retry(
        () => weightAreasRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching weight areas found with weightAreasId: $weightAreasId');
      }

      await r.retry(
        () => weightAreasRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error deleting weight areas: ${e.message}');
    } catch (e) {
      mDebug('Unknown error deleting weight areas: $e');
    }
  }
}
