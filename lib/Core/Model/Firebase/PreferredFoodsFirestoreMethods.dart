import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/PreferredFoods.dart';
import 'FirebaseSingelton.dart';

class PreferredFoodsFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createPreferredFoods(PreferredFoods preferredFoods) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('PreferredFoods')
            .add(preferredFoods.toMap()),
        retryIf: (e) => true,
      );
      await docRef.update({'preferredFoodsId': docRef.id});

      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint('Firebase error creating preferred foods: ${e.message}');
      return '';
    } catch (e) {
      debugPrint('Unknown error creating preferred foods: $e');
      return '';
    }
  }

  Future<PreferredFoods?> fetchPreferredFoodsByClientId(String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('PreferredFoods')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : PreferredFoods.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error fetching preferred foods by client ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unknown error fetching preferred foods by client ID: $e');
      return null;
    }
  }

  Future<PreferredFoods?> fetchPreferredFoodsById(
      String preferredFoodsId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('PreferredFoods')
            .where('preferredFoodsId', isEqualTo: preferredFoodsId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : PreferredFoods.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching preferred foods by ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unknown error fetching preferred foods by ID: $e');
      return null;
    }
  }

  Future<void> updatePreferredFoods(PreferredFoods preferredFoods) async {
    try {
      final preferredFoodsRef = FirebaseSingleton.instance.firestore
          .collection('PreferredFoods')
          .doc(preferredFoods.mPreferredFoodsId);

      final docSnapshot = await r.retry(
        () => preferredFoodsRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching preferred foods found with '
            'preferredFoodsId: ${preferredFoods.mPreferredFoodsId}');
      }

      await r.retry(
        () => preferredFoodsRef.update(preferredFoods.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating preferred foods: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error updating preferred foods: $e');
    }
  }

  Future<void> deletePreferredFoods(String preferredFoodsId) async {
    try {
      final preferredFoodsRef = FirebaseSingleton.instance.firestore
          .collection('PreferredFoods')
          .doc(preferredFoodsId);

      final docSnapshot = await r.retry(
        () => preferredFoodsRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching preferred foods found with '
            'preferredFoodsId: $preferredFoodsId');
      }

      await r.retry(
        () => preferredFoodsRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting preferred foods: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error deleting preferred foods: $e');
    }
  }
}
