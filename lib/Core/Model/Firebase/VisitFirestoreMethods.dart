import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Classes/Visit.dart';
import 'FirebaseSingelton.dart';

class VisitFirestoreMethods {
  Future<String> createVisit(Visit visit) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('Visits')
          .add(visit.toMap());
      await docRef.update({'visitId': docRef.id});
      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint('Firebase error creating visit: ${e.message}');
      return '';
    } catch (e) {
      debugPrint('Error creating visit: $e');
      return '';
    }
  }

  Future<List<Visit>?> fetchVisitsByClientId(String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Visits')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : querySnapshot.docs
            .map((doc) => Visit.fromFirestore(doc.data()))
            .toList();
  }

  Future<Visit?> fetchVisitById(String visitId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Visits')
        .where('visitId', isEqualTo: visitId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : Visit.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<void> updateVisit(Visit visit) async {
    try {
      final visitRef = FirebaseSingleton.instance.firestore
          .collection('Visits')
          .doc(visit.mVisitId);

      final docSnapshot = await visitRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching visit found with visitId: ${visit.mVisitId}');
      }

      await visitRef.update(visit.toMap());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating visit: ${e.message}');
    } catch (e) {
      throw Exception('Error updating visit: $e');
    }
  }

  Future<void> deleteVisit(String visitId) async {
    try {
      final visitRef = FirebaseSingleton.instance.firestore
          .collection('Visits')
          .doc(visitId);

      final docSnapshot = await visitRef.get();

      if (!docSnapshot.exists) {
        throw Exception('No matching visit found with visitId: $visitId');
      }

      await visitRef.delete();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting visit: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error deleting visit: $e');
    }
  }

  Future<void> deleteAllClientVisits(String clientId) async {
    try {
      final querySnapshot = await FirebaseSingleton.instance.firestore
          .collection('Visits')
          .where('clientId', isEqualTo: clientId)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.delete();
      }
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting all visits: ${e.message}');
    } catch (e) {
      debugPrint('Error deleting all visits: $e');
    }
  }
}
