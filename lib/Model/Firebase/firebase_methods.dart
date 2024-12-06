import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/Client.dart';
import 'package:vera_clinic/Model/Classes/Disease.dart';

import '../Classes/ClientConstantInfo.dart';
import '../Classes/ClientMonthlyFollowUp.dart';
import '../Classes/PreferredFoods.dart';
import '../Classes/Visit.dart';
import '../Classes/WeightAreas.dart';

class FirebaseMethods {
  static final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  void updateClient(Client client) async {
    try {
      final querySnapshot = await _firestore
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
    final querySnapshot = await _firestore
        .collection('Clients')
        .where('clientPhoneNum', isEqualTo: phoneNum)
        .get();
    return Client.fromFirestore(querySnapshot.docs.first
        .data()); // we use .first in case of finding more than one instance with the same number
  }

  void createClient(Client client) async {
    try {
      await _firestore.collection('Clients').add(client.toMap());
    } catch (e) {
      debugPrint('Error creating client: $e');
    }
  }

  //TODO: seperate into a new file
   createDisease(Disease disease) async {
    try {
      final docRef =
          await _firestore.collection('Diseases').add(disease.toMap());
      disease.diseaseId = docRef.id;
    } catch (e) {
      debugPrint('Error creating disease: $e');
    }
    return disease.diseaseId ?? '';
  }

  createClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) async {
    try {
      final docRef = await _firestore
          .collection('ClientMonthlyFollowUps')
          .add(clientMonthlyFollowUp.toMap());
      clientMonthlyFollowUp.clientMonthlyFollowUpId = docRef.id;
    } catch (e) {
      debugPrint('Error creating client monthly follow up: $e');
    }
    return clientMonthlyFollowUp.clientMonthlyFollowUpId ?? '';
  }

  createPreferredFoods(PreferredFoods preferredFoods) async {
    try {
      final docRef = await _firestore
          .collection('PreferredFoods')
          .add(preferredFoods.toMap());
      preferredFoods.preferredFoodsId = docRef.id;
    } catch (e) {
      debugPrint('Error creating preferred foods: $e');
    }
    return preferredFoods.preferredFoodsId ?? '';
  }

  createWeightAreas(WeightAreas weightAreas) async {
    try {
      final docRef =
          await _firestore.collection('WeightAreas').add(weightAreas.toMap());
      weightAreas.weightAreasId = docRef.id;
    } catch (e) {
      debugPrint('Error creating weight areas: $e');
    }
    return weightAreas.weightAreasId ?? '';
  }

  createClientConstantInfo(
      ClientConstantInfo clientConstantInfo) async {
    try {
      final docRef = await _firestore
          .collection('ClientConstantInfo')
          .add(clientConstantInfo.toMap());
      clientConstantInfo.clientConstantInfoId = docRef.id;
    } catch (e) {
      debugPrint('Error creating client constant info: $e');
    }
    return clientConstantInfo.clientConstantInfoId ?? '';
  }

  createVisit(Visit visit) async {
    try {
      final docRef = await _firestore.collection('Visits').add(visit.toMap());
      visit.visitId = docRef.id;
    } catch (e) {
      debugPrint('Error creating visit: $e');
    }
    return visit.visitId ?? '';
  }

  fetchDiseaseByNum(String clientPhoneNum) async {
    final querySnapshot = await _firestore
        .collection('Diseases')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return Disease.fromFirestore(querySnapshot.docs.first.data());
  }

  fetchClientMonthlyFollowUpByNum(String clientPhoneNum) async {
    final querySnapshot = await _firestore
        .collection('ClientMonthlyFollowUps')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return ClientMonthlyFollowUp.fromFirestore(querySnapshot.docs.first.data());
  }

  fetchPreferredFoodsByNum(String clientPhoneNum) async {
    final querySnapshot = await _firestore
        .collection('PreferredFoods')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return PreferredFoods.fromFirestore(querySnapshot.docs.first.data());
  }

  fetchWeightAreasByNum(String clientPhoneNum) async {
    final querySnapshot = await _firestore
        .collection('WeightAreas')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return WeightAreas.fromFirestore(querySnapshot.docs.first.data());
  }

  fetchClientConstantInfoByNum(String clientPhoneNum) async{
    final querySnapshot = await _firestore
        .collection('ClientConstantInfo')
        .where('clientPhoneNum', isEqualTo: clientPhoneNum)
        .get();
    return ClientConstantInfo.fromFirestore(querySnapshot.docs.first.data());
  }

}
