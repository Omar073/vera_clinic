import 'package:flutter/cupertino.dart';

import '../Classes/WeightAreas.dart';
import 'FirebaseSingelton.dart';

class WeightAreasFirestoreMethods{
  createWeightAreas(WeightAreas weightAreas) async {
    try {
      final docRef =
      await FirebaseSingleton.instance.firestore.collection('WeightAreas').add(weightAreas.toMap());
      weightAreas.weightAreasId = docRef.id;
    } catch (e) {
      debugPrint('Error creating weight areas: $e');
    }
    return weightAreas.weightAreasId ?? '';
  }
  
  fetchWeightAreasByNum(String clientPhoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('WeightAreas')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return WeightAreas.fromFirestore(querySnapshot.docs.first.data());
  }
}