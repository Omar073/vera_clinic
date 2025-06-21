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

    if (disease != null) {
      return disease;
    }

    disease = await diseaseFirestoreMethods.fetchDiseaseByClientId(clientId);
    if (disease != null) {
      cachedDiseases.add(disease);
      notifyListeners();
    }
    return disease;
  }

  Future<Disease?> getDiseaseById(String diseaseId) async {
    // Check cached diseases first
    Disease? disease = cachedDiseases.firstWhere(
      (disease) => disease?.mDiseaseId == diseaseId,
      orElse: () => null,
    );

    if (disease != null) {
      return disease;
    }

    disease = await diseaseFirestoreMethods.fetchDiseaseById(diseaseId);
    if (disease != null) {
      cachedDiseases.add(disease);
      notifyListeners();
    }
    return disease;
  }

  Future<bool> updateDisease(Disease disease) async {
    try {
      await diseaseFirestoreMethods.updateDisease(disease);
      int index =
          cachedDiseases.indexWhere((d) => d?.mDiseaseId == disease.mDiseaseId);
      if (index != -1) {
        cachedDiseases[index] = disease;
      } else {
        cachedDiseases.add(disease);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Failed to update disease: $e");
      return false;
    }
  }

  Future<bool> deleteDisease(String diseaseId) async {
    try {
      await diseaseFirestoreMethods.deleteDisease(diseaseId);
      cachedDiseases.removeWhere((disease) => disease?.mDiseaseId == diseaseId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint("Failed to delete disease: $e");
      return false;
    }
  }

  void setCurrentDisease(Disease disease) {
    _mCurrentDisease = disease;
    notifyListeners();
  }
}
