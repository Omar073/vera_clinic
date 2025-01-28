import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/Core/Model/Firebase/WeightAreasFirestoreMethods.dart';

class WeightAreasProvider with ChangeNotifier {
  final WeightAreasFirestoreMethods _weightAreasFirestoreMethods =
      WeightAreasFirestoreMethods();

  WeightAreas? _currentWeightAreas;
  List<WeightAreas?> _cachedWeightAreas = [];

  WeightAreas? get currentWeightAreas => _currentWeightAreas;
  List<WeightAreas?> get cachedWeightAreas => _cachedWeightAreas;
  WeightAreasFirestoreMethods get weightAreasFirestoreMethods =>
      _weightAreasFirestoreMethods;

  void createWeightAreas(WeightAreas weightAreas) {
    weightAreas.weightAreasId =
        weightAreasFirestoreMethods.createWeightAreas(weightAreas) as String;

    _cachedWeightAreas.add(weightAreas);
    notifyListeners();
  }

  Future<WeightAreas?> getWeightAreasByClientId(String clientId) async {
    WeightAreas? weightAreas = _cachedWeightAreas.firstWhere(
      (weightAreas) => weightAreas?.mClientId == clientId,
      orElse: () => null,
    );

    weightAreas ??=
        await weightAreasFirestoreMethods.fetchWeightAreasByClientId(clientId);
    weightAreas == null ? _cachedWeightAreas.add(weightAreas) : null;
    notifyListeners();
    return weightAreas;
  }

  Future<WeightAreas?> getWeightAreasById(String weightAreasId) async {
    WeightAreas? weightAreas = _cachedWeightAreas.firstWhere(
      (weightAreas) => weightAreas?.mWeightAreasId == weightAreasId,
      orElse: () => null,
    );

    weightAreas ??= await weightAreasFirestoreMethods.fetchWeightAreasById(weightAreasId);
    weightAreas == null ? _cachedWeightAreas.add(weightAreas) : null;
    notifyListeners();
    return weightAreas;
  }

  void updateWeightAreas(WeightAreas weightAreas) {
    weightAreasFirestoreMethods.updateWeightAreas(weightAreas);
    notifyListeners();
  }

  void setCurrentWeightAreas(WeightAreas weightAreas) {
    _currentWeightAreas = weightAreas;
    notifyListeners();
  }
}
