import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/DiseaseFirestoreMethods.dart';

import '../../Model/Classes/Disease.dart';

class DiseaseProvider with ChangeNotifier {
  final DiseaseFirestoreMethods _diseaseFirestoreMethods =
      DiseaseFirestoreMethods();

  Disease? _currentDisease;
  List<Disease> _diseases = [];

  Disease? get currentDisease => _currentDisease;
  List<Disease> get diseases => _diseases;

  void createDisease(Disease disease) {
    disease.diseaseId = _diseaseFirestoreMethods.createDisease(disease);
    _diseases.add(disease);
    notifyListeners();
  }

  Disease? getDiseaseByNum(String clientPhoneNum) {
    return diseases.firstWhere(
      (disease) => disease.clientPhoneNum == clientPhoneNum,
      orElse: () => _diseaseFirestoreMethods.fetchDiseaseByNum(clientPhoneNum), //TODO: create default constructor
    );
  }

  void setCurrentDisease(Disease disease) {
    _currentDisease = disease;
    notifyListeners();
  }
}
