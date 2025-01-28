class PreferredFoods {
  late String mPreferredFoodsId;
  String? mClientId;

  bool mCarbohydrates = false;
  bool mProtein = false;
  bool mDairy = false;
  bool mVeg = false;
  bool mFruits = false;
  String mOthers = '';

PreferredFoods({
  required String preferredFoodsId,
  required String? clientId,
  required bool carbohydrates,
  required bool protein,
  required bool dairy,
  required bool veg,
  required bool fruits,
  required String others,
})  : mPreferredFoodsId = preferredFoodsId,
      mClientId = clientId,
      mCarbohydrates = carbohydrates,
      mProtein = protein,
      mDairy = dairy,
      mVeg = veg,
      mFruits = fruits,
      mOthers = others;

  // Setters
  set preferredFoodsId(String preferredFoodsId) {
    mPreferredFoodsId = preferredFoodsId;
  }

  set clientId(String? clientId) {
    mClientId = clientId;
  }

  set carbohydrates(bool carbohydrates) {
    mCarbohydrates = carbohydrates;
  }

  set protein(bool protein) {
    mProtein = protein;
  }

  set dairy(bool dairy) {
    mDairy = dairy;
  }

  set veg(bool veg) {
    mVeg = veg;
  }

  set fruits(bool fruits) {
    mFruits = fruits;
  }

  set others(String others) {
    mOthers = others;
  }

factory PreferredFoods.fromFirestore(Map<String, dynamic> data) {
  return PreferredFoods(
    preferredFoodsId: data['preferredFoodsId'] as String,
    clientId: data['clientId'] as String?,
    carbohydrates: data['carbohydrates'] as bool,
    protein: data['protein'] as bool,
    dairy: data['dairy'] as bool,
    veg: data['veg'] as bool,
    fruits: data['fruits'] as bool,
    others: data['others'] as String,
  );
}

  Map<String, dynamic> toMap() {
    return {
      'preferredFoodsId': mPreferredFoodsId,
      'clientId': mClientId,
      'carbohydrates': mCarbohydrates,
      'protein': mProtein,
      'dairy': mDairy,
      'veg': mVeg,
      'fruits': mFruits,
      'others': mOthers,
    };
  }
}

