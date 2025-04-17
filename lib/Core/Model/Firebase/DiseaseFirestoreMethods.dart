import 'package:cloud_firestore/cloud_firestore.dart';
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

  Future<void> updateDisease(Disease disease) async {
    try {
      final diseaseRef = FirebaseSingleton.instance.firestore
          .collection('Diseases')
          .doc(disease.mDiseaseId);

      final docSnapshot = await diseaseRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching disease found with diseaseId: ${disease.mDiseaseId}');
      }

      await diseaseRef.update(disease.toMap());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating disease: ${e.message}');
    } catch (e) {
      throw Exception('Error updating disease: $e');
    }
  }

  Future<void> deleteDisease(String diseaseId) async {
    try {
      final diseaseRef = FirebaseSingleton.instance.firestore
          .collection('Diseases')
          .doc(diseaseId);

      // Check if the document exists before deleting
      final docSnapshot = await diseaseRef.get();

      if (!docSnapshot.exists) {
        throw Exception('No matching disease found with diseaseId: $diseaseId');
      }

      await diseaseRef.delete();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting disease: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting disease: $e');
    }
  }
}
