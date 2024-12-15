import 'package:flutter/cupertino.dart';

import '../Classes/ClientMonthlyFollowUp.dart';
import 'FirebaseSingelton.dart';

class ClientMonthlyFollowUpFirestoreMethods {
  Future<String> createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUps')
          .add(clientMonthlyFollowUp.toMap());
      await docRef.update({'clientMonthlyFollowUpId': docRef.id});
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating client monthly follow up: $e');
      return '';
    }
  }

  Future<void> updateClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final clientMonthlyFollowUpRef = FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUps')
          .doc(clientMonthlyFollowUp.clientMonthlyFollowUpId);

      final docSnapshot = await clientMonthlyFollowUpRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client monthly follow up found with clientMonthlyFollowUpId: ${clientMonthlyFollowUp.clientMonthlyFollowUpId}');
      }

      await clientMonthlyFollowUpRef.update(clientMonthlyFollowUp.toMap());
    } catch (e) {
      throw Exception('Error updating client monthly follow up: $e');
    }
  }

  Future<ClientMonthlyFollowUp?> fetchClientMonthlyFollowUpByClientId(
      String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientMonthlyFollowUps')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : ClientMonthlyFollowUp.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<ClientMonthlyFollowUp?> fetchClientMonthlyFollowUpById(
      String clientMonthlyFollowUpId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientMonthlyFollowUps')
        .where('clientMonthlyFollowUpId', isEqualTo: clientMonthlyFollowUpId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : ClientMonthlyFollowUp.fromFirestore(querySnapshot.docs.first.data());
  }
}
