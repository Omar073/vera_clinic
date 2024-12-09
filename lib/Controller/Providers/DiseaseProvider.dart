import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/DiseaseFirestoreMethods.dart';

import '../../Model/Classes/Disease.dart';

class DiseaseProvider with ChangeNotifier {
  final DiseaseFirestoreMethods _diseaseFirestoreMethods =
      DiseaseFirestoreMethods();

  Disease? _currentDisease;
  List<Disease> _cachedDiseases = [];

  Disease? get currentDisease => _currentDisease;
  List<Disease> get cachedDiseases => _cachedDiseases;
  DiseaseFirestoreMethods get diseaseFirestoreMethods =>
      _diseaseFirestoreMethods;

  void createDisease(Disease disease) {
    disease.diseaseId =
        diseaseFirestoreMethods.createDisease(disease) as String;
    cachedDiseases.add(disease);
    notifyListeners();
  }

  Disease? getDiseaseByNum(String clientPhoneNum) {
    return cachedDiseases.firstWhere(
      (disease) => disease.clientPhoneNum == clientPhoneNum,
      orElse: () => diseaseFirestoreMethods.fetchDiseaseByNum(clientPhoneNum),
    );
  }

  void setCurrentDisease(Disease disease) {
    _currentDisease = disease;
    notifyListeners();
  }
}
