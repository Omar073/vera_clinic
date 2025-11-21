import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';

import '../Classes/ClientConstantInfo.dart';
import 'FirebaseSingelton.dart';

import '../../../Core/Services/DebugLoggerService.dart';
class ClientConstantInfoFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3);

  Future<String> createClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientConstantInfo')
            .add(clientConstantInfo.toMap()),
        retryIf: (e) => true,
      );
      await docRef.update({'clientConstantInfoId': docRef.id});
      return docRef.id;
    } catch (e) {
      mDebug('Error creating client constant info: $e');
      return '';
    }
  }

  Future<ClientConstantInfo?> fetchClientConstantInfoByClientId(
      String clientId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientConstantInfo')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : ClientConstantInfo.fromFirestore(querySnapshot.docs.first.data());
    } catch (e) {
      mDebug('Error fetching client constant info by client ID: $e');
      return null;
    }
  }

  Future<ClientConstantInfo?> fetchClientConstantInfoById(
      String clientConstantInfoId) async {
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('ClientConstantInfo')
            .where('clientConstantInfoId', isEqualTo: clientConstantInfoId)
            .get(),
        retryIf: (e) => true,
      );

      return querySnapshot.docs.isEmpty
          ? null
          : ClientConstantInfo.fromFirestore(querySnapshot.docs.first.data());
    } catch (e) {
      mDebug('Error fetching client constant info by ID: $e');
      return null;
    }
  }

  Future<void> updateClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      final clientConstantInfoRef = FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .doc(clientConstantInfo.mClientConstantInfoId);

      final docSnapshot = await r.retry(
        () => clientConstantInfoRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client constant info found with clientConstantInfoId: '
            '${clientConstantInfo.mClientConstantInfoId}');
      }

      await r.retry(
        () => clientConstantInfoRef.update(clientConstantInfo.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error updating client constant info: ${e.message}');
    } catch (e) {
      throw Exception('Error updating client constant info: $e');
    }
  }

  Future<void> deleteClientConstantInfo(String clientConstantInfoId) async {
    try {
      final clientConstantInfoRef = FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .doc(clientConstantInfoId);

      final docSnapshot = await r.retry(
        () => clientConstantInfoRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client constant info found with clientConstantInfoId: '
            '$clientConstantInfoId');
      }

      await r.retry(
        () => clientConstantInfoRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      mDebug('Firebase error deleting client: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting client constant info: $e');
    }
  }
}
