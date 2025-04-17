import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Classes/ClientMonthlyFollowUp.dart';
import 'FirebaseSingelton.dart';

class ClientMonthlyFollowUpFirestoreMethods {
  Future<String> createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUp')
          .add(clientMonthlyFollowUp.toMap());

      await docRef.update({'clientMonthlyFollowUpId': docRef.id});
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating client monthly follow up: $e');
      return '';
    }
  }

  Future<ClientMonthlyFollowUp?> fetchClientMonthlyFollowUpByClientId(
      String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientMonthlyFollowUp')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : ClientMonthlyFollowUp.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<ClientMonthlyFollowUp?> fetchClientMonthlyFollowUpById(
      String clientMonthlyFollowUpId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientMonthlyFollowUp')
        .where('clientMonthlyFollowUpId', isEqualTo: clientMonthlyFollowUpId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : ClientMonthlyFollowUp.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<void> updateClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final clientMonthlyFollowUpRef = FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUp')
          .doc(clientMonthlyFollowUp.mClientMonthlyFollowUpId);

      final docSnapshot = await clientMonthlyFollowUpRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client monthly follow up found with '
                'clientMonthlyFollowUpId: ${clientMonthlyFollowUp.mClientMonthlyFollowUpId}');
      }

      await clientMonthlyFollowUpRef.update(clientMonthlyFollowUp.toMap());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating client monthly followup: ${e.message}');
    } catch (e) {
      throw Exception('Error updating client monthly follow up: $e');
    }
  }

  Future<void> deleteClientMonthlyFollowUp(
      String clientMonthlyFollowUpId) async {
    try {
      final clientMonthlyFollowUpRef = FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUp')
          .doc(clientMonthlyFollowUpId);

      await clientMonthlyFollowUpRef.delete();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating client monthly followup: ${e.message}');
    } catch (e) {
      debugPrint('Error deleting client monthly follow up: $e');
    }
  }
}
