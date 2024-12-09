import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Model/Firebase/PreferredFoodsFirestoreMethods.dart';

import '../../Model/Classes/PreferredFoods.dart';

class PreferredFoodsProvider with ChangeNotifier{
  PreferredFoodsFirestoreMethods _preferredFoodsFirestoreMethods = PreferredFoodsFirestoreMethods();

  PreferredFoods? _currentPreferredFoods;
  List<PreferredFoods> _cachedPreferredFoods = [];

  PreferredFoods? get currentPreferredFoods => _currentPreferredFoods;
  List<PreferredFoods> get cachedPreferredFoods => _cachedPreferredFoods;
  PreferredFoodsFirestoreMethods get preferredFoodsFirestoreMethods => _preferredFoodsFirestoreMethods;
  
  void createCurrentPreferredFoods(PreferredFoods preferredFoods) {
    preferredFoods.preferredFoodsId =
    preferredFoodsFirestoreMethods.createPreferredFoods(preferredFoods) as String;
    cachedPreferredFoods.add(preferredFoods);
    // _currentPreferredFoods = preferredFoods;
    notifyListeners();
  }

  PreferredFoods getPreferredFoods(String clientPhoneNum) {
    _currentPreferredFoods = preferredFoodsFirestoreMethods
        .fetchPreferredFoodsByNum(clientPhoneNum) as PreferredFoods;
    return currentPreferredFoods!;
  }

  void setCurrentPreferredFoods(PreferredFoods preferredFoods) {
    _currentPreferredFoods = preferredFoods;
    notifyListeners();
  }
}