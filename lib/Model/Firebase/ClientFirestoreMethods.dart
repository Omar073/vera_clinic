import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/FirebaseSingelton.dart';

import '../Classes/Client.dart';

class ClientFirestoreMethods{
  void createClient(Client client) async {
    try {
      await FirebaseSingleton.instance.firestore.collection('Clients').add(client.toMap());
    } catch (e) {
      debugPrint('Error creating client: $e');
    }
  }

  void updateClient(Client client) async {
    try {
      final querySnapshot = await FirebaseSingleton.instance.firestore
          .collection('Clients')
          .where('clientPhoneNum', isEqualTo: client.clientPhoneNum)
          .get();

      for (var doc in querySnapshot.docs) {
        await doc.reference.update(client.toMap());
      }
    } catch (e) {
      debugPrint('Error updating client: $e');
    }
  }

  Future<Client> fetchClientByNum(String phoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('Clients')
        .where('clientPhoneNum', isEqualTo: phoneNum)
        .get();
    return Client.fromFirestore(querySnapshot.docs.first
        .data()); // we use .first in case of finding more than one instance with the same number
  }

}