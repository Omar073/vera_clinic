import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:retry/retry.dart';
import 'package:vera_clinic/Core/Model/Firebase/FirebaseSingelton.dart';

import '../Classes/Client.dart';

class ClientFirestoreMethods {
  final r = RetryOptions(maxAttempts: 3); //todo: add retry logic

  Future<String> createClient(Client client) async {
    try {
      final docRef = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Clients')
            .add(client.toMap()),
        retryIf: (e) => true,
      );

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
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Clients')
            .where('clientId', isEqualTo: clientId)
            .get(),
        retryIf: (e) => true,
      );

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

    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Clients')
            .where('clientPhoneNum', isEqualTo: phoneNum)
            .get(),
        retryIf: (e) => true,
      );

      clients = querySnapshot.docs
          .map((doc) => Client.fromFirestore(doc.data()))
          .toList();
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching client by phone: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error fetching client by phone: $e');
    }
    return clients;
  }

  Future<List<Client?>> fetchClientByFirstName(String name) async {
    List<Client> clients = [];
    try {
      final querySnapshot = await FirebaseSingleton.instance.firestore
          .collection('Clients')
          .where('name', isGreaterThanOrEqualTo: name)
          .where('name', isLessThanOrEqualTo: '$name\uf8ff')
          .get();

      clients.addAll(querySnapshot.docs
          .map((doc) => Client.fromFirestore(doc.data()))
          .toList());
    } on FirebaseException catch (e) {
      debugPrint('Firebase error fetching client by first name: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error fetching client by first name: $e');
    }
    return clients;
  }

  Future<List<Client?>> fetchClientByName(String name) async {
    List<Client> clients = [];
    try {
      final querySnapshot = await r.retry(
        () => FirebaseSingleton.instance.firestore
            .collection('Clients')
            .where('name', isEqualTo: name)
            .get(),
        retryIf: (e) => true,
      );

      clients = querySnapshot.docs
          .map((doc) => Client.fromFirestore(doc.data()))
          .toList();
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

      final docSnapshot = await r.retry(
        () => clientRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception(
            'No matching client found with clientId: ${client.mClientId}');
      }

      await r.retry(
        () => clientRef.update(client.toMap()),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error updating client: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error updating client: $e');
    }
  }

  Future<void> deleteClient(String clientId) async {
    try {
      final clientRef = FirebaseSingleton.instance.firestore
          .collection('Clients')
          .doc(clientId);

      final docSnapshot = await r.retry(
        () => clientRef.get(),
        retryIf: (e) => true,
      );

      if (!docSnapshot.exists) {
        throw Exception('No matching client found with clientId: $clientId');
      }

      await r.retry(
        () => clientRef.delete(),
        retryIf: (e) => true,
      );
    } on FirebaseException catch (e) {
      debugPrint('Firebase error deleting client: ${e.message}');
    } catch (e) {
      debugPrint('Unknown error deleting client: $e');
    }
  }
}
