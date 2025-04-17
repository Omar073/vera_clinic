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

  Future<void> createPreferredFoods(PreferredFoods preferredFoods) async {
    preferredFoods.mPreferredFoodsId = await preferredFoodsFirestoreMethods
        .createPreferredFoods(preferredFoods);
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

  Future<bool> updatePreferredFoods(PreferredFoods preferredFoods) async {
    try {
      await preferredFoodsFirestoreMethods.updatePreferredFoods(preferredFoods);
      int index = cachedPreferredFoods.indexWhere(
          (p) => p?.mPreferredFoodsId == preferredFoods.mPreferredFoodsId);
      if (index != -1) {
        cachedPreferredFoods[index] = preferredFoods;
      } else {
        cachedPreferredFoods.add(preferredFoods);
      }
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error updating preferred foods: $e');
      return false;
    }
  }

  Future<bool> deletePreferredFoods(String preferredFoodsId) async {
    try {
      await preferredFoodsFirestoreMethods
          .deletePreferredFoods(preferredFoodsId);

      cachedPreferredFoods.removeWhere(
          (p) => p?.mPreferredFoodsId == preferredFoodsId);
      notifyListeners();
      return true;
    } catch (e) {
      debugPrint('Error deleting preferred foods: $e');
      return false;
    }
  }

  void setCurrentPreferredFoods(PreferredFoods preferredFoods) {
    _currentPreferredFoods = preferredFoods;
    notifyListeners();
  }
}
