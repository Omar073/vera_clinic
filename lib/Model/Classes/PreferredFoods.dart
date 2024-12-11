class PreferredFoods {
  String _mPreferredFoodsId;
  String _mClientId;

  bool _mCarbohydrates = false;
  bool _mProtein = false;
  bool _mDairy = false;
  bool _mVeg = false;
  bool _mFruits = false;
  String _mOthers = '';

  PreferredFoods(
      this._mPreferredFoodsId,
      this._mClientId,
      this._mCarbohydrates,
      this._mProtein,
      this._mDairy,
      this._mVeg,
      this._mFruits,
      this._mOthers);

  // Getters
  String get preferredFoodsId => _mPreferredFoodsId;
  String get clientId => _mClientId;
  bool get carbohydrates => _mCarbohydrates;
  bool get protein => _mProtein;
  bool get dairy => _mDairy;
  bool get veg => _mVeg;
  bool get fruits => _mFruits;
  String get others => _mOthers;

  // Setters
  set preferredFoodsId(String preferredFoodsId) {
    _mPreferredFoodsId = preferredFoodsId;
  }

  set clientId(String clientId) {
    _mClientId = clientId;
  }

  set carbohydrates(bool carbohydrates) {
    _mCarbohydrates = carbohydrates;
  }

  set protein(bool protein) {
    _mProtein = protein;
  }

  set dairy(bool dairy) {
    _mDairy = dairy;
  }

  set veg(bool veg) {
    _mVeg = veg;
  }

  set fruits(bool fruits) {
    _mFruits = fruits;
  }

  set others(String others) {
    _mOthers = others;
  }

  factory PreferredFoods.fromFirestore(Map<String, dynamic> data) {
    return PreferredFoods(
      data['preferredFoodsId'] as String,
      data['clientId'] as String,
      data['carbohydrates'] as bool,
      data['protein'] as bool,
      data['dairy'] as bool,
      data['veg'] as bool,
      data['fruits'] as bool,
      data['others'] as String,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'preferredFoodsId': _mPreferredFoodsId,
      'clientId': _mClientId,
      'carbohydrates': _mCarbohydrates,
      'protein': _mProtein,
      'dairy': _mDairy,
      'veg': _mVeg,
      'fruits': _mFruits,
      'others': _mOthers,
    };
  }
}
