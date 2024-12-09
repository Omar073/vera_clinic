import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/Model/Firebase/WeightAreasFirestoreMethods.dart';

class WeightAreasProvider with ChangeNotifier {
  final WeightAreasFirestoreMethods _weightAreasFirestoreMethods =
      WeightAreasFirestoreMethods();
  WeightAreas? _currentWeightAreas;
  List<WeightAreas> _cachedWeightAreas = [];

  WeightAreas? get currentWeightAreas => _currentWeightAreas;
  List<WeightAreas> get cachedWeightAreas => _cachedWeightAreas;
  WeightAreasFirestoreMethods get weightAreasFirestoreMethods =>
      _weightAreasFirestoreMethods;

  void createCurrentWeightAreas(WeightAreas weightAreas) {
    weightAreas.weightAreasId =
        weightAreasFirestoreMethods.createWeightAreas(weightAreas) as String;

    _cachedWeightAreas.add(weightAreas);
    notifyListeners();
  }

  WeightAreas getWeightAreas(String clientPhoneNum) {
    _currentWeightAreas = weightAreasFirestoreMethods
        .fetchWeightAreasByNum(clientPhoneNum) as WeightAreas;
    return currentWeightAreas!;
  }

  void setCurrentWeightAreas(WeightAreas weightAreas) {
    _currentWeightAreas = weightAreas;
    notifyListeners();
  }
}
