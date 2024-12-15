import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/DiseaseFirestoreMethods.dart';

import '../../Model/Classes/Disease.dart';

class DiseaseProvider with ChangeNotifier {
  final DiseaseFirestoreMethods _mDiseaseFirestoreMethods =
      DiseaseFirestoreMethods();

  Disease? _mCurrentDisease;
  List<Disease?> _mCachedDiseases = [];

  Disease? get currentDisease => _mCurrentDisease;
  List<Disease?> get cachedDiseases => _mCachedDiseases;
  DiseaseFirestoreMethods get diseaseFirestoreMethods =>
      _mDiseaseFirestoreMethods;

  void createDisease(Disease disease) {
    disease.diseaseId =
        diseaseFirestoreMethods.createDisease(disease) as String;
    cachedDiseases.add(disease);
    notifyListeners();
  }

  Future<Disease?> getDiseaseByClientId(String clientId) async {
    // Check cached diseases first
    Disease? disease = cachedDiseases.firstWhere(
      (disease) => disease?.clientId == clientId,
      orElse: () => null,
    );

    disease ??= await diseaseFirestoreMethods.fetchDiseaseByClientId(clientId);
    disease == null ? cachedDiseases.add(disease) : null;
    notifyListeners();
    return disease;
  }

  Future<Disease?> getDiseaseById(String diseaseId) async {
    // Check cached diseases first
    Disease? disease = cachedDiseases.firstWhere(
      (disease) => disease?.diseaseId == diseaseId,
      orElse: () => null,
    );

    disease ??= await diseaseFirestoreMethods.fetchDiseaseById(diseaseId);
    disease == null ? cachedDiseases.add(disease) : null;
    notifyListeners();
    return disease;
  }

  void updateDisease(Disease disease) {
    diseaseFirestoreMethods.updateDisease(disease);
    notifyListeners();
  }

  void setCurrentDisease(Disease disease) {
    _mCurrentDisease = disease;
    notifyListeners();
  }
}
