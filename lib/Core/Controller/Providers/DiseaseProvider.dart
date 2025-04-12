import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Firebase/DiseaseFirestoreMethods.dart';

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

  Future<void> createDisease(Disease disease) async {
    disease.mDiseaseId = await diseaseFirestoreMethods.createDisease(disease);
    cachedDiseases.add(disease);
    notifyListeners();
  }

  Future<Disease?> getDiseaseByClientId(String clientId) async {
    // Check cached diseases first
    Disease? disease = cachedDiseases.firstWhere(
      (disease) => disease?.mClientId == clientId,
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
      (disease) => disease?.mDiseaseId == diseaseId,
      orElse: () => null,
    );

    disease ??= await diseaseFirestoreMethods.fetchDiseaseById(diseaseId);
    disease == null ? cachedDiseases.add(disease) : null;
    notifyListeners();
    return disease;
  }

  Future<void> updateDisease(Disease disease) async {
    await diseaseFirestoreMethods.updateDisease(disease);
    notifyListeners();
  }

  void setCurrentDisease(Disease disease) {
    _mCurrentDisease = disease;
    notifyListeners();
  }
}
