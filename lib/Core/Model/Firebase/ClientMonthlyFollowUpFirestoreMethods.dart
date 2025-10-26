import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/ClientMonthlyFollowUp.dart';
import 'FirebaseSingelton.dart';

class ClientMonthlyFollowUpFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientMonthlyFollowUp')
            .add(clientMonthlyFollowUp.toMap()),
        retryIf: (e) => true,
      );

      await docRef.update({'clientMonthlyFollowUpId': docRef.id});
      return docRef.id;
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error creating client monthly follow up: ${e.message}');
      return '';
    } catch (e) {
      debugPrint('Unknown error creating client monthly follow up: $e');
      return '';
    }
  }

  Future<ClientMonthlyFollowUp?> fetchLastClientMonthlyFollowUp(
      String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientMonthlyFollowUp')
            .where('clientId', isEqualTo: clientId)
            .orderBy('date', descending: true)
            .limit(1)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : ClientMonthlyFollowUp.fromFirestore(
              querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error fetching client monthly follow up by client ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint(
          'Unknown error fetching client monthly follow up by client ID: $e');
      return null;
    }
  }

  Future<List<ClientMonthlyFollowUp>?> fetchClientMonthlyFollowUps(
      String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientMonthlyFollowUp')
            .where('clientId', isEqualTo: clientId)
            .orderBy('date', descending: true)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : querySnapshot.docs
              .map((doc) => ClientMonthlyFollowUp.fromFirestore(doc.data()))
              .toList();
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error fetching client monthly follow ups list by client ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint(
          'Unknown error fetching client monthly follow ups list by client ID: $e');
      return null;
    }
  }

  Future<ClientMonthlyFollowUp?> fetchClientMonthlyFollowUpById(
      String clientMonthlyFollowUpId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientMonthlyFollowUp')
            .where('clientMonthlyFollowUpId',
                isEqualTo: clientMonthlyFollowUpId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : ClientMonthlyFollowUp.fromFirestore(
              querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error fetching client monthly follow up by ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unknown error fetching client monthly follow up by ID: $e');
      return null;
    }
  }

  Future<void> updateClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final clientMonthlyFollowUpRef = FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUp')
          .doc(clientMonthlyFollowUp.mClientMonthlyFollowUpId);

      final docSnapshot = await r.retry(
        () => clientMonthlyFollowUpRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching client monthly follow up found with '
            'clientMonthlyFollowUpId: ${clientMonthlyFollowUp.mClientMonthlyFollowUpId}');
      }

      await r.retry(
        () => clientMonthlyFollowUpRef.update(clientMonthlyFollowUp.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error updating client monthly followup: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error updating client monthly follow up: $e');
    }
  }

  Future<void> deleteClientMonthlyFollowUp(
      String clientMonthlyFollowUpId) async {
    try {
      final clientMonthlyFollowUpRef = FirebaseSingleton.instance.firestore
          .collection('ClientMonthlyFollowUp')
          .doc(clientMonthlyFollowUpId);

      final docSnapshot = await r.retry(
        () => clientMonthlyFollowUpRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client monthly follow up found with ID: $clientMonthlyFollowUpId');
      }

      await r.retry(
        () => clientMonthlyFollowUpRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint(
          'Firebase error deleting client monthly followup: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error deleting client monthly follow up: $e');
    }
  }

  Future<void> deleteAllClientMonthlyFollowUps(String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientMonthlyFollowUp')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

      final batch = FirebaseSingleton.instance.firestore.batch();
      for (final doc in querySnapshot.docs) {
        batch.delete(doc.reference);
      }
      await batch.commit();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting all client monthly followups: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error deleting all client monthly follow ups: $e');
    }
  }
}
