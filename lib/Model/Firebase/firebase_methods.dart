import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:vera_clinic/Model/Classes/Client.dart';

class FirebaseMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  Future<Client> fetchClientByNum(String phoneNum) async {
    // final Client = FirebaseAuth.instance
    final querySnapshot = await _firestore
        .collection('Clients')
        .where('telephone', isEqualTo: phoneNum)
        .get();
    return Client.fromFirestore(querySnapshot.docs
        .first.data()); // we use .first in case of finding more than one client with the same number
  }

  void createClient(Client client) async {
    // _firestore.collection('Clients').add(client.toMap());
    final docRef = await _firestore.collection('Clients').add(client.toMap());
  }
}
