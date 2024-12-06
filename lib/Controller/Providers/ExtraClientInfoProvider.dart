import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/firebase_methods.dart';
import '../../Model/Classes/ClientConstantInfo.dart';
import '../../Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Model/Classes/Disease.dart';
import '../../Model/Classes/PreferredFoods.dart';
import '../../Model/Classes/WeightAreas.dart';

class ExtraClientInfoProvider with ChangeNotifier {
  final FirebaseMethods _firebaseMethods = FirebaseMethods();
  Disease? _currentDisease;
  ClientMonthlyFollowUp? _currentClientMonthlyFollowUp;
  PreferredFoods? _currentPreferredFoods;
  WeightAreas? _currentWeightAreas;
  ClientConstantInfo? _currentClientConstantInfo;

  Disease? get currentDisease => _currentDisease;
  ClientMonthlyFollowUp? get currentClientMonthlyFollowUp =>
      _currentClientMonthlyFollowUp;
  PreferredFoods? get currentPreferredFoods => _currentPreferredFoods;
  WeightAreas? get currentWeightAreas => _currentWeightAreas;
  ClientConstantInfo? get currentClientConstantInfo =>
      _currentClientConstantInfo;

  void createDisease(Disease disease) {
    disease.diseaseId = _firebaseMethods.createDisease(disease) as String;
    _currentDisease = disease;
    notifyListeners();
  }

  Disease getDisease(String clientPhoneNum) {
    _currentDisease =
        _firebaseMethods.fetchDiseaseByNum(clientPhoneNum) as Disease;
    return currentDisease!;
  }

  void createCurrentClientMonthlyFollowUp(
      ClientMonthlyFollowUp clientMonthlyFollowUp) {
    clientMonthlyFollowUp.clientMonthlyFollowUpId = _firebaseMethods
        .createClientMonthlyFollowUp(clientMonthlyFollowUp) as String;
    _currentClientMonthlyFollowUp = clientMonthlyFollowUp;
    notifyListeners();
  }

  ClientMonthlyFollowUp getClientMonthlyFollowUp(String clientPhoneNum) {
    _currentClientMonthlyFollowUp =
        _firebaseMethods.fetchClientMonthlyFollowUpByNum(clientPhoneNum)
            as ClientMonthlyFollowUp;
    return currentClientMonthlyFollowUp!;
  }

  void createCurrentPreferredFoods(PreferredFoods preferredFoods) {
    preferredFoods.preferredFoodsId =
        _firebaseMethods.createPreferredFoods(preferredFoods) as String;
    _currentPreferredFoods = preferredFoods;
    notifyListeners();
  }

  PreferredFoods getPreferredFoods(String clientPhoneNum) {
    _currentPreferredFoods = _firebaseMethods
        .fetchPreferredFoodsByNum(clientPhoneNum) as PreferredFoods;
    return currentPreferredFoods!;
  }

  void createCurrentWeightAreas(WeightAreas weightAreas) {
    weightAreas.weightAreasId =
        _firebaseMethods.createWeightAreas(weightAreas) as String;
    _currentWeightAreas = weightAreas;
    notifyListeners();
  }

  WeightAreas getWeightAreas(String clientPhoneNum) {
    _currentWeightAreas =
        _firebaseMethods.fetchWeightAreasByNum(clientPhoneNum) as WeightAreas;
    return currentWeightAreas!;
  }

  void createCurrentClientConstantInfo(ClientConstantInfo clientConstantInfo) {
    _currentClientConstantInfo = clientConstantInfo;
    clientConstantInfo.clientConstantInfoId =
        _firebaseMethods.createClientConstantInfo(clientConstantInfo) as String;
    notifyListeners();
  }

  ClientConstantInfo getClientConstantInfo(String clientPhoneNum) {
    _currentClientConstantInfo = _firebaseMethods
        .fetchClientConstantInfoByNum(clientPhoneNum) as ClientConstantInfo;
    return currentClientConstantInfo!;
  }
}
