import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/Visit.dart';
import 'FirebaseSingelton.dart';

import '../../../Core/Services/DebugLoggerService.dart';
class VisitFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createVisit(Visit visit) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Visits')
            .add(visit.toMap()),
        retryIf: (e) => true,
      );
      await docRef.update({'visitId': docRef.id});
      return docRef.id;
    } on FirebaseException catch (e) {
      mDebug('Firebase error creating visit: ${e.message}');
      return '';
    } catch (e) {
      mDebug('Error creating visit: $e');
      return '';
    }
  }

  Future<List<Visit>?> fetchVisitsByClientId(String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Visits')
            .where('clientId', isEqualTo: clientId)
            .orderBy('date', descending: true)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : querySnapshot.docs
              .map((doc) => Visit.fromFirestore(doc.data()))
              .toList();
    } catch (e) {
      mDebug('Error fetching visits by client ID: $e');
      return null;
    }
  }

  Future<Visit?> fetchVisitById(String visitId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Visits')
            .where('visitId', isEqualTo: visitId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : Visit.fromFirestore(querySnapshot.docs.first.data());
    } catch (e) {
      mDebug('Error fetching visit by ID: $e');
      return null;
    }
  }

  Future<void> updateVisit(Visit visit) async {
    try {
      final visitRef = FirebaseSingleton.instance.firestore
          .collection('Visits')
          .doc(visit.mVisitId);

      final docSnapshot = await r.retry(
        () => visitRef.get(),
        retryIf: (e) => true,
      );
      if (!docSnapshot.exists) {
        throw Exception(
            'No matching visit found with visitId: ${visit.mVisitId}');
      }
      await visitRef.update(visit.toMap());
    } on FirebaseException catch (e) {
      mDebug('Firebase error updating visit: ${e.message}');
    } catch (e) {
      throw Exception('Error updating visit: $e');
    }
  }

  Future<void> deleteVisit(String visitId) async {
    try {
      final visitRef = FirebaseSingleton.instance.firestore
          .collection('Visits')
          .doc(visitId);

      final docSnapshot = await r.retry(
        () => visitRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching visit found with visitId: $visitId');
      }

      await visitRef.delete();
    } on FirebaseException catch (e) {
      mDebug('Firebase error deleting visit: ${e.message}');
    } catch (e) {
      mDebug('Unknown error deleting visit: $e');
    }
  }

  Future<void> deleteAllClientVisits(String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Visits')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

      for (var doc in querySnapshot.docs) {
        await r.retry(
          () => doc.reference.delete(),
          retryIf: (e) => true,
        );
      }
    } on FirebaseException catch (e) {
      mDebug('Firebase error deleting all visits: ${e.message}');
    } catch (e) {
      mDebug('Error deleting all visits: $e');
    }
  }
}
