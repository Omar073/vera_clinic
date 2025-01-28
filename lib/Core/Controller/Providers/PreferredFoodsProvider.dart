import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Model/Firebase/PreferredFoodsFirestoreMethods.dart';

import '../../Model/Classes/PreferredFoods.dart';

class PreferredFoodsProvider with ChangeNotifier {
  final PreferredFoodsFirestoreMethods _preferredFoodsFirestoreMethods =
      PreferredFoodsFirestoreMethods();

  PreferredFoods? _currentPreferredFoods;
  List<PreferredFoods?> _cachedPreferredFoods = [];

  PreferredFoods? get currentPreferredFoods => _currentPreferredFoods;
  List<PreferredFoods?> get cachedPreferredFoods => _cachedPreferredFoods;
  PreferredFoodsFirestoreMethods get preferredFoodsFirestoreMethods =>
      _preferredFoodsFirestoreMethods;

  void createPreferredFoods(PreferredFoods preferredFoods) {
    preferredFoods.preferredFoodsId = preferredFoodsFirestoreMethods
        .createPreferredFoods(preferredFoods) as String;
    cachedPreferredFoods.add(preferredFoods);
    notifyListeners();
  }

  Future<PreferredFoods?> getPreferredFoodsByClientId(String clientId) async {
    PreferredFoods? preferredFoods = cachedPreferredFoods.firstWhere(
      (preferredFoods) => preferredFoods?.mClientId == clientId,
      orElse: () => null,
    );

    preferredFoods ??= await preferredFoodsFirestoreMethods
        .fetchPreferredFoodsByClientId(clientId);

    preferredFoods == null ? cachedPreferredFoods.add(preferredFoods) : null;
    notifyListeners();
    return preferredFoods;
  }

  Future<PreferredFoods?> getPreferredFoodsById(String preferredFoodsId) async {
    PreferredFoods? preferredFoods = cachedPreferredFoods.firstWhere(
      (preferredFoods) => preferredFoods?.mPreferredFoodsId == preferredFoodsId,
      orElse: () => null,
    );

    preferredFoods ??= await preferredFoodsFirestoreMethods
        .fetchPreferredFoodsById(preferredFoodsId);

    preferredFoods == null ? cachedPreferredFoods.add(preferredFoods) : null;
    notifyListeners();
    return preferredFoods;
  }

  void updatePreferredFoods(PreferredFoods preferredFoods) {
    preferredFoodsFirestoreMethods.updatePreferredFoods(preferredFoods);
    notifyListeners();
  }

  void setCurrentPreferredFoods(PreferredFoods preferredFoods) {
    _currentPreferredFoods = preferredFoods;
    notifyListeners();
  }
}
