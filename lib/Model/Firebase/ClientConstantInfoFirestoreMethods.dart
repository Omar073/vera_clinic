import 'package:flutter/cupertino.dart';

import '../Classes/ClientConstantInfo.dart';
import 'FirebaseSingelton.dart';

class ClientConstantInfoFirestoreMethods {
  createClientConstantInfo(ClientConstantInfo clientConstantInfo) async {
    try {
      final docRef = await FirebaseSingleton.instance.firestore
          .collection('ClientConstantInfo')
          .add(clientConstantInfo.toMap());
      clientConstantInfo.clientConstantInfoId = docRef.id;
    } catch (e) {
      debugPrint('Error creating client constant info: $e');
    }
    return clientConstantInfo.clientConstantInfoId ?? '';
  }

  fetchClientConstantInfoByNum(String clientPhoneNum) async {
    final querySnapshot = await FirebaseSingleton.instance.firestore
        .collection('ClientConstantInfo')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return ClientConstantInfo.fromFirestore(querySnapshot.docs.first.data());
  }
}
