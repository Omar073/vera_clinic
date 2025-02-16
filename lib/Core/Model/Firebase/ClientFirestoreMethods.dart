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

  Future<Client?> fetchClientById(String clientId) async {
    try {
      final querySnapshot = await FirebaseSingleton.instance.firestore
          .collection('Clients')
          .where('clientId', isEqualTo: clientId)
          .get();

      return querySnapshot.docs.isEmpty
          ? null
          : Client.fromFirestore(querySnapshot.docs.first.data());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching client by ID: ${e.message}');
      return null;
    } catch (e) {
      debugPrint('Unknown error fetching client by ID: $e');
      return null;
    }
  }

  Future<List<Client?>> fetchClientByPhone(String phoneNum) async {
    debugPrint("firebase fetching client by phone: $phoneNum");
    List<Client> clients = [];

    // final r = RetryOptions(maxAttempts: 3); //todo: add retry logic

    try {
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
    } on FirebaseException catch (e) {
      debugPrint("Firebase error fetching client by phone: ${e.message}");
    } catch (e) {
      debugPrint("Unknown error fetching client by phone: $e");
    }

    return clients;
  }

  Future<List<Client?>> fetchClientByName(String name) async {
    List<Client> clients = [];
    try {
      final querySnapshot = await FirebaseSingleton.instance.firestore
          .collection('Clients')
          .where('name', isEqualTo: name)
          .get();
      clients.addAll(querySnapshot.docs
          .map((doc) => Client.fromFirestore(doc.data()))
          .toList());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching client by name: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error fetching client by name: $e');
    }

    return clients;
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
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating client: ${e.message}');
      throw Exception('Firebase error updating client: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error updating client: $e');
      throw Exception('Unknown error updating client: $e');
    }
  }
}
