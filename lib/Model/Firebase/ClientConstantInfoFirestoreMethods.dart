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

  Future<void> updateClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      final clientConstantInfoRef = FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .doc(clientConstantInfo.clientConstantInfoId);

      final docSnapshot = await clientConstantInfoRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client constant info found with clientConstantInfoId: ${clientConstantInfo.clientConstantInfoId}');
      }

      await clientConstantInfoRef.update(clientConstantInfo.toMap());
    } catch (e) {
      throw Exception('Error updating client constant info: $e');
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
}
