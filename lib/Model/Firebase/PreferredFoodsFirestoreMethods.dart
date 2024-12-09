import 'package:flutter/cupertino.dart';

import '../Classes/PreferredFoods.dart';
import 'FirebaseSingelton.dart';

class PreferredFoodsFirestoreMethods {
  createPreferredFoods(PreferredFoods preferredFoods) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('PreferredFoods')
          .add(preferredFoods.toMap());
      preferredFoods.preferredFoodsId = docRef.id;
    } catch (e) {
      debugPrint('Error creating preferred foods: $e');
    }
    return preferredFoods.preferredFoodsId ?? '';
  }

  fetchPreferredFoodsByNum(String clientPhoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('PreferredFoods')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return PreferredFoods.fromFirestore(querySnapshot.docs.first.data());
  }
}
