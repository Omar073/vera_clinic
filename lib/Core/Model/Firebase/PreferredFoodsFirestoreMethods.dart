import 'package:flutter/cupertino.dart';

import '../Classes/PreferredFoods.dart';
import 'FirebaseSingelton.dart';

class PreferredFoodsFirestoreMethods {
  Future<String> createPreferredFoods(PreferredFoods preferredFoods) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('PreferredFoods')
          .add(preferredFoods.toMap());
      await docRef.update({'preferredFoodsId': docRef.id});

      return docRef.id;
    } catch (e) {
      debugPrint('Error creating preferred foods: $e');
      return '';
    }
  }

  Future<void> updatePreferredFoods(PreferredFoods preferredFoods) async {
    try {
      final preferredFoodsRef = FirebaseSingleton.instance.firestore
          .collection('PreferredFoods')
          .doc(preferredFoods.mPreferredFoodsId);

      final docSnapshot = await preferredFoodsRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching preferred foods found with preferredFoodsId: ${preferredFoods.mPreferredFoodsId}');
      }

      await preferredFoodsRef.update(preferredFoods.toMap());
    } catch (e) {
      throw Exception('Error updating preferred foods: $e');
    }
  }

  Future<PreferredFoods?> fetchPreferredFoodsByClientId(
      String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('PreferredFoods')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : PreferredFoods.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<PreferredFoods?> fetchPreferredFoodsById(
      String preferredFoodsId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('PreferredFoods')
        .where('preferredFoodsId', isEqualTo: preferredFoodsId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : PreferredFoods.fromFirestore(querySnapshot.docs.first.data());
  }
}
