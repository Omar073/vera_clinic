import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';

import '../Classes/ClientConstantInfo.dart';
import 'FirebaseSingelton.dart';

class ClientConstantInfoFirestoreMethods {
  Future<String> createClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .add(clientConstantInfo.toMap());
      await docRef.update({'clientConstantInfoId': docRef.id});
      return docRef.id;
    } catch (e) {
      debugPrint('Error creating client constant info: $e');
      return '';
    }
  }

  Future<ClientConstantInfo?> fetchClientConstantInfoByClientId(
      String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientConstantInfo')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : ClientConstantInfo.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<ClientConstantInfo?> fetchClientConstantInfoById(
      String clientConstantInfoId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientConstantInfo')
        .where('clientConstantInfoId', isEqualTo: clientConstantInfoId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : ClientConstantInfo.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<void> updateClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      final clientConstantInfoRef = FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .doc(clientConstantInfo.mClientConstantInfoId);

      final docSnapshot = await clientConstantInfoRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client constant info found with clientConstantInfoId: '
            '${clientConstantInfo.mClientConstantInfoId}');
      }

      await clientConstantInfoRef.update(clientConstantInfo.toMap());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating client constant info: ${e.message}');
    } catch (e) {
      throw Exception('Error updating client constant info: $e');
    }
  }

  Future<void> deleteClientConstantInfo(String clientConstantInfoId) async {
    try {
      final clientConstantInfoRef = FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .doc(clientConstantInfoId);

      final docSnapshot = await clientConstantInfoRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client constant info found with clientConstantInfoId: '
            '$clientConstantInfoId');
      }

      await clientConstantInfoRef.delete();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting client: ${e.message}');
    } catch (e) {
      throw Exception('Error deleting client constant info: $e');
    }
  }
}
