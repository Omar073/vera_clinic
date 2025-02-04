import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/PreferredFoods.dart';

import 'Disease.dart';
import 'Visit.dart';
import 'WeightAreas.dart';

enum SubscriptionType {
  none,
  newClient,
  singleVisit,
  weeklyVisit,
  monthlyVisit,
  afterBreak,
  cavSess,
  cavSess6,
  miso,
  punctureSess,
  punctureSess6,
  other
}

enum Gender { none, male, female }

class Client {
  late String mClientId;
  String? mName;
  String? mClientPhoneNum;
  Gender mGender;
  String? mLastVisitId;
  DateTime? mBirthdate;
  String? mClientConstantInfoId;
  String? mDiseaseId;
  String? mDiet;
  List<double> Plat = List.filled(10, 0); // Last 10 stable weights
  String? mClientMonthlyFollowUpId;
  String? mPreferredFoodsId;
  String? mWeightAreasId;
  String? mNotes;
  double? mHeight;
  double? mWeight;

  SubscriptionType? mSubscriptionType;

  Client({
    required String clientId,
    required String? name,
    required String? clientPhoneNum,
    required Gender gender,
    required String? lastVisitId,
    required DateTime? birthdate,
    required String? clientConstantInfoId,
    required String? diseaseId,
    required String? diet,
    required List<double> plat,
    required String? clientMonthlyFollowUpId,
    required String? preferredFoodsId,
    required String? weightAreasId,
    required String? notes,
    required double? height,
    required double? weight,
    required SubscriptionType? subscriptionType,
  })  : mClientId = clientId,
        mName = name,
        mClientPhoneNum = clientPhoneNum,
        mGender = gender,
        mLastVisitId = lastVisitId,
        mBirthdate = birthdate,
        mClientConstantInfoId = clientConstantInfoId,
        mDiseaseId = diseaseId,
        mDiet = diet,
        Plat = plat,
        mClientMonthlyFollowUpId = clientMonthlyFollowUpId,
        mPreferredFoodsId = preferredFoodsId,
        mWeightAreasId = weightAreasId,
        mNotes = notes,
        mHeight = height,
        mWeight = weight,
        mSubscriptionType = subscriptionType;

// Setters
  set clientId(String clientId) {
    mClientId = clientId;
  }

  set name(String? name) {
    mName = name;
  }

  set clientPhoneNum(String? clientPhoneNum) {
    mClientPhoneNum = clientPhoneNum;
  }

  set gender(Gender gender) {
    mGender = gender;
  }

  set lastVisitId(String? lastVisitId) {
    mLastVisitId = lastVisitId;
  }

  set birthdate(DateTime? birthdate) {
    mBirthdate = birthdate;
  }

  set clientConstantInfoId(String? clientConstantInfoId) {
    mClientConstantInfoId = clientConstantInfoId;
  }

  set diseaseId(String? diseaseId) {
    mDiseaseId = diseaseId;
  }

  set diet(String? diet) {
    mDiet = diet;
  }

  set plat(List<double> plat) {
    Plat = plat;
  }

  set clientMonthlyFollowUpId(String? clientMonthlyFollowUpId) {
    mClientMonthlyFollowUpId = clientMonthlyFollowUpId;
  }

  set preferredFoodsId(String? preferredFoodsId) {
    mPreferredFoodsId = preferredFoodsId;
  }

  set weightAreasId(String? weightAreasId) {
    mWeightAreasId = weightAreasId;
  }

  set notes(String? notes) {
    mNotes = notes;
  }

  set height(double? height) {
    mHeight = height;
  }

  set weight(double? weight) {
    mWeight = weight;
  }

  set subscriptionType(SubscriptionType? subscriptionType) {
    mSubscriptionType = subscriptionType;
  }

  void printClientInfo() {
    debugPrint('\n\t\t<<Client>>\nClient ID: $mClientId, Name: $mName, '
        'Phone Number: $mClientPhoneNum, Gender: ${mGender.name}, '
        'Last Visit ID: $mLastVisitId, Birthdate: $mBirthdate, '
        'Client Constant Info ID: $mClientConstantInfoId, '
        'Disease ID: $mDiseaseId, Diet: $mDiet, Plat: $Plat, '
        'Client Monthly Follow Up ID: $mClientMonthlyFollowUpId, '
        'Preferred Foods ID: $mPreferredFoodsId, '
        'Weight Areas ID: $mWeightAreasId, Notes: $mNotes, '
        'Height: $mHeight, Weight: $mWeight, '
        'Subscription Type: ${mSubscriptionType?.name}');
  }

  factory Client.fromFirestore(Map<String, dynamic> data) {
    return Client(
      clientId: data['clientId'] as String? ?? '',
      name: data['name'] as String? ?? '',
      clientPhoneNum: data['clientPhoneNum'] as String? ?? '',
      gender: Gender.values.firstWhere(
        (e) => e.name == data['gender'],
        orElse: () => Gender.none,
      ),
      lastVisitId: data['lastVisitId'] as String? ?? '',
      birthdate: (data['birthDate'] as Timestamp?)
          ?.toDate(), //TODO: what should I replace it with
      clientConstantInfoId: data['clientConstantInfoId'] as String? ?? '',
      diseaseId: data['diseaseId'] as String? ?? '',
      diet: data['diet'] as String? ?? '',
      plat: (data['plat'] as List<dynamic>)
          .map((e) => (e as num).toDouble())
          .toList(),
      clientMonthlyFollowUpId: data['clientMonthlyFollowUpId'] as String? ?? '',
      preferredFoodsId: data['preferredFoodsId'] as String? ?? '',
      weightAreasId: data['weightAreasId'] as String? ?? '',
      notes: data['notes'] as String? ?? '',
      height: (data['height'] as num?)?.toDouble() ?? 0.0,
      weight: (data['weight'] as num?)?.toDouble() ?? 0.0,
      subscriptionType: SubscriptionType.values.firstWhere(
        (e) => e.name == data['subscriptionType'],
        orElse: () => SubscriptionType.newClient,
      ),
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'clientId': mClientId,
      'name': mName,
      'clientPhoneNum': mClientPhoneNum,
      'gender': mGender.name,
      'lastVisitId': mLastVisitId,
      'birthDate': mBirthdate,
      'clientConstantInfoId': mClientConstantInfoId,
      'diseaseId': mDiseaseId,
      'diet': mDiet,
      'plat': Plat,
      'clientMonthlyFollowUpId': mClientMonthlyFollowUpId,
      'preferredFoodsId': mPreferredFoodsId,
      'weightAreasId': mWeightAreasId,
      'notes': mNotes,
      'height': mHeight,
      'weight': mWeight,
      'subscriptionType': mSubscriptionType?.name,
    };
  }
}

// Visit visit = Visit(
//   visitId: "abc123",
//   clientId: 'id123',
//   date: DateTime.now(),
//   diet: 'Vegetarian',
//   weight: 75.0,
//   bmi: 23.1,
//   visitNotes: 'No specific notes',
// );
//
// Disease disease = Disease(
//   diseaseId: 'def456',
//   clientId: 'id123',
//   hypertension: false,
//   hypotension: true,
//   vascular: false,
//   anemia: false,
//   otherHeart: 'no heart notes',
//   colon: false,
//   constipation: true,
//   familyHistoryDM: false,
//   previousOBMed: true,
//   previousOBOperations: false,
//   renal: '',
//   liver: '',
//   git: '',
//   endocrine: '',
//   rheumatic: '',
//   allergies: '',
//   neuro: '',
//   psychiatric: '',
//   others: '',
//   hormonal: '',
// );
// ClientConstantInfo clientConstantInfo = ClientConstantInfo(
//   clientConstantInfoId: 'const123',
//   clientId: 'id123',
//   area: 'mokattam',
//   activityLevel: Activity.high,
//   YOYO: false,
//   sports: true,
// );
// ClientMonthlyFollowUp clientMonthlyFollowUp = ClientMonthlyFollowUp(
//   clientMonthlyFollowUpId: 'mfi123',
//   clientId: 'id123',
//   bmi: 23.1,
//   pbf: 15.0,
//   water: 2.0,
//   maxWeight: 75.0,
//   optimalWeight: 70.0,
//   bmr: 1500.0,
//   maxCalories: 2000,
//   dailyCalories: 1800,
// );
// PreferredFoods preferredFoods = PreferredFoods(
//   preferredFoodsId: 'ghi789',
//   clientId: 'id123',
//   carbohydrates: true,
//   protein: true,
//   dairy: false,
//   veg: true,
//   fruits: true,
//   others: 'No specific notes',
// );
// WeightAreas weightAreas = WeightAreas(
//   weightAreasId: 'jkl012',
//   clientId: 'id123',
//   abdomen: true,
//   buttocks: false,
//   waist: true,
//   thighs: false,
//   arms: true,
//   breast: false,
//   back: true,
// );
//
// Client client = Client(
//   clientId: 'id123',
//   name: 'John Doe',
//   clientPhoneNum: '1234567890',
//   gender: Gender.male,
//   lastVisitId: 'abc123',
//   birthdate: DateTime(1990, 1, 1),
//   clientConstantInfoId: 'const123',
//   diseaseId: 'def456',
//   diet: 'Vegetarian',
//   plat: [70, 71, 72, 73, 74, 75, 76, 77, 78, 79],
//   clientMonthlyFollowUpId: 'mfi123',
//   preferredFoodsId: 'ghi789',
//   weightAreasId: 'jkl012',
//   notes: 'No specific notes',
//   height: 180.0,
//   weight: 75.0,
//   subscriptionType: SubscriptionType.newClient,
// );
