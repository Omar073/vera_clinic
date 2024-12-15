import 'package:flutter/cupertino.dart';

import '../Classes/Disease.dart';
import 'FirebaseSingelton.dart';

class DiseaseFirestoreMethods {
  Future<String> createDisease(Disease disease) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('Diseases')
          .add(disease.toMap());
      await docRef.update({'diseaseId': docRef.id});

      return docRef.id;
    } catch (e) {
      debugPrint('Error creating disease: $e');
      return '';
    }
  }

  Future<void> updateDisease(Disease disease) async {
    try {
      final diseaseRef = FirebaseSingleton.instance.firestore
          .collection('Diseases')
          .doc(disease.diseaseId);

      final docSnapshot = await diseaseRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching disease found with diseaseId: ${disease.diseaseId}');
      }

      await diseaseRef.update(disease.toMap());
    } catch (e) {
      throw Exception('Error updating disease: $e');
    }
  }

  Future<Disease?> fetchDiseaseByClientId(String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Diseases')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : Disease.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<Disease?> fetchDiseaseById(String diseaseId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Diseases')
        .where('diseaseId', isEqualTo: diseaseId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : Disease.fromFirestore(querySnapshot.docs.first.data());
  }
}
