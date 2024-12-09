import 'package:flutter/cupertino.dart';

import '../Classes/Disease.dart';
import 'FirebaseSingelton.dart';

class DiseaseFirestoreMethods{
  createDisease(Disease disease) async {
    try {
      final docRef =
      await FirebaseSingleton.instance.firestore.collection('Diseases').add(disease.toMap());
      disease.diseaseId = docRef.id;
    } catch (e) {
      debugPrint('Error creating disease: $e');
    }
    return disease.diseaseId ?? '';
  }

  fetchDiseaseByNum(String clientPhoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Diseases')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return Disease.fromFirestore(querySnapshot.docs.first.data());
  }
}