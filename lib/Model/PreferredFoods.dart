class PreferredFoods{
  bool _mCarbohydrates;
  bool _mProtein;
  bool _mDairy;
  bool _mVeg;
  bool _mFruits;
  String _mOthers;

  PreferredFoods(this._mCarbohydrates, this._mProtein, this._mDairy, this._mVeg, this._mFruits, this._mOthers);

  // Getters
  bool get carbohydrates => _mCarbohydrates;
  bool get protein => _mProtein;
  bool get dairy => _mDairy;
  bool get veg => _mVeg;
  bool get fruits => _mFruits;
  String get others => _mOthers;

  // Setters
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
}