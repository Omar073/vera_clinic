import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/DiseaseFirestoreMethods.dart';

import '../../Model/Classes/Disease.dart';

class DiseaseProvider with ChangeNotifier {
  final DiseaseFirestoreMethods _diseaseFirestoreMethods =
      DiseaseFirestoreMethods();

  Disease? _currentDisease;
  List<Disease?> _cachedDiseases = [];

  Disease? get currentDisease => _currentDisease;
  List<Disease?> get cachedDiseases => _cachedDiseases;
  DiseaseFirestoreMethods get diseaseFirestoreMethods =>
      _diseaseFirestoreMethods;

  void createDisease(Disease disease) {
    disease.diseaseId =
        diseaseFirestoreMethods.createDisease(disease) as String;
    cachedDiseases.add(disease);
    notifyListeners();
  }

  Future<Disease?> getDiseaseById(String clientId) async {
    // Check cached diseases first
    Disease? disease = cachedDiseases.firstWhere(
      (disease) => disease?.clientId == clientId,
      orElse: () => null,
    );
    disease ??= await diseaseFirestoreMethods.fetchDiseaseById(clientId);
    return disease;
  }

  void setCurrentDisease(Disease disease) {
    _currentDisease = disease;
    notifyListeners();
  }
}
