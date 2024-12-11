import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/FirebaseSingelton.dart';

import '../Classes/Client.dart';

class ClientFirestoreMethods {
  Future<String> createClient(Client client) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('Clients')
          .add(client.toMap());

      // Update the client document with its generated ID
      await docRef.update({'clientId': docRef.id});

      return docRef.id;
    } catch (e) {
      debugPrint('Error creating client: $e');
      return '';
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      final clientRef = FirebaseSingleton.instance.firestore
          .collection('Clients')
          .doc(client.clientId);

      // Check if the document exists before updating
      final docSnapshot = await clientRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client found with clientId: ${client.clientId}');
      }

      await clientRef.update(client.toMap());
    } catch (e) {
      throw Exception('Error updating client: $e');
    }
  }

  Future<Client?> fetchClientById(String clientId) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Clients')
        .where('clientId', isEqualTo: clientId)
        .get();

    return querySnapshot.docs.isEmpty
        ? null
        : Client.fromFirestore(querySnapshot.docs.first.data());
  }

  Future<List<Client?>?> fetchClientByNum(String phoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Clients')
        .where('clientPhoneNum', isEqualTo: phoneNum)
        .get();
    return querySnapshot.docs
        .map((doc) => Client.fromFirestore(doc.data()))
        .toList();
  }
}
