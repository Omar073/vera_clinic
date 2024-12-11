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
    } catch (e) {
      debugPrint('Error creating visit: $e');
      return '';
    }
  }

  Future<void> updateVisit(Visit visit) async {
    try {
      final visitRef = FirebaseSingleton.instance.firestore
          .collection('Visits')
          .doc(visit.visitId);

      final docSnapshot = await visitRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching visit found with visitId: ${visit.visitId}');
      }

      await visitRef.update(visit.toMap());
    } catch (e) {
      throw Exception('Error updating visit: $e');
    }
  }

  Future<List<Visit>?> fetchVisits(String clientId) async {
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
}
