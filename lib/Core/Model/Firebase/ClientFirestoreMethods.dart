import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';

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
    } on FirebaseException catch (e) {
      debugPrint('Firebase error creating client: ${e.message}');
      return '';
    } catch (e) {
      debugPrint('Unknown error creating client: $e');
      return '';
    }
  }

  Future<void> updateClient(Client client) async {
    try {
      final clientRef = FirebaseSingleton.instance.firestore
          .collection('Clients')
          .doc(client.mClientId);

      // Check if the document exists before updating
      final docSnapshot = await clientRef.get();

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client found with clientId: ${client.mClientId}');
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

  Future<List<Client?>> fetchClientByPhone(String phoneNum) async {
    debugPrint("firebase fetching client by phone: $phoneNum");
    List<Client> clients = [];
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Clients')
        .where('clientPhoneNum', isEqualTo: phoneNum)
        .get();

    debugPrint("Query snapshot docs length: ${querySnapshot.docs.length}");
    clients.addAll(querySnapshot.docs
        .map((doc) => Client.fromFirestore(doc.data()))
        .toList());
    for (Client c in clients) {
      debugPrint("fetched client with phone: ${c.mClientPhoneNum}");
    }

    return clients;
  }

  Future<List<Client?>> fetchClientByName(String name) async {
    //todo: maybe match by first name
    List<Client> clients = [];
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Clients')
        .where('name', isEqualTo: name)
        .get();
    clients.addAll(querySnapshot.docs
        .map((doc) => Client.fromFirestore(doc.data()))
        .toList());

    return clients;
  }
}
