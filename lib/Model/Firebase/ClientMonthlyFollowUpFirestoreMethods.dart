import 'package:flutter/cupertino.dart';

import '../Classes/ClientMonthlyFollowUp.dart';
import 'FirebaseSingelton.dart';

class ClientMonthlyFollowUpFirestoreMethods {
  createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUps')
          .add(clientMonthlyFollowUp.toMap());
      clientMonthlyFollowUp.clientMonthlyFollowUpId = docRef.id;
    } catch (e) {
      debugPrint('Error creating client monthly follow up: $e');
    }
    return clientMonthlyFollowUp.clientMonthlyFollowUpId ?? '';
  }

  fetchClientMonthlyFollowUpByNum(String clientPhoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientMonthlyFollowUps')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return ClientMonthlyFollowUp.fromFirestore(querySnapshot.docs.first.data());
  }
}
