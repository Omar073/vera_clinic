import 'package:flutter/cupertino.dart';

import '../Classes/WeightAreas.dart';
import 'FirebaseSingelton.dart';

class WeightAreasFirestoreMethods {
  Future<String> createWeightAreas(WeightAreas weightAreas) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('WeightAreas')
          .add(weightAreas.toMap());
      await docRef.update({'weightAreasId': docRef.id});
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating weight areas: $e');
      return '';
    }
  }

  Future<void> updateWeightAreas(WeightAreas weightAreas) async {
    try {
      final weightAreasRef = FirebaseSingleton.instance.firestore
          .collection('WeightAreas')
          .doc(weightAreas.weightAreasId);

      final docSnapshot = await weightAreasRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching weight areas found with weightAreasId: ${weightAreas.weightAreasId}');
      }

      await weightAreasRef.update(weightAreas.toMap());
    } catch (e) {
      throw Exception('Error updating weight areas: $e');
    }
  }

  Future<WeightAreas?> fetchWeightAreasByNum(String clientPhoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('WeightAreas')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : WeightAreas.fromFirestore(querySnapshot.docs.first.data());
  }
}
