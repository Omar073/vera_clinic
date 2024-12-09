import 'package:flutter/cupertino.dart';

import '../Classes/Visit.dart';
import 'FirebaseSingelton.dart';

class VisitFirestoreMethods{
  createVisit(Visit visit) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore.collection('Visits').add(visit.toMap());
      visit.visitId = docRef.id;
    } catch (e) {
      debugPrint('Error creating visit: $e');
    }
    return visit.visitId ?? '';
  }
  
  Future<List<Visit>> fetchVisits(String phoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Visits')
        .where('clientPhoneNum', isEqualTo: phoneNum)
        .get();
    return querySnapshot.docs.map((doc) => Visit.fromFirestore(doc.data())).toList();
  }
}