class WeightAreas {
  bool _mAbdomen;
  bool _mButtocks;
  bool _mWaist;
  bool _mThighs;
  bool _mArms;
  bool _mBreast;
  bool _mBack;

  WeightAreas(this._mAbdomen, this._mButtocks, this._mWaist, this._mThighs, this._mArms, this._mBreast, this._mBack);

  // Getters
  bool get abdomen => _mAbdomen;
  bool get buttocks => _mButtocks;
  bool get waist => _mWaist;
  bool get thighs => _mThighs;
  bool get arms => _mArms;
  bool get breast => _mBreast;
  bool get back => _mBack;

  // Setters
  set abdomen(bool abdomen) {
    _mAbdomen = abdomen;
  }

  set buttocks(bool buttocks) {
    _mButtocks = buttocks;
  }

  set waist(bool waist) {
    _mWaist = waist;
  }

  set thighs(bool thighs) {
    _mThighs = thighs;
  }

  set arms(bool arms) {
    _mArms = arms;
  }

  set breast(bool breast) {
    _mBreast = breast;
  }

  set back(bool back) {
    _mBack = back;
  }
}