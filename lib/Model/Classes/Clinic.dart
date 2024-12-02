class Clinic {
  double _mDailyIncome;
  double _mMonthlyIncome;
  int _mDailyPatients;
  int _mMonthlyPatients;
  double _mDailyExpenses;
  double _mMonthlyExpenses;
  double _mDailyProfit;
  double _mMonthlyProfit;

  Clinic(
      this._mDailyIncome,
      this._mMonthlyIncome,
      this._mDailyPatients,
      this._mMonthlyPatients,
      this._mDailyExpenses,
      this._mMonthlyExpenses,
      this._mDailyProfit,
      this._mMonthlyProfit);

  double get dailyIncome => _mDailyIncome;
  set dailyIncome(double value) => _mDailyIncome = value;

  double get monthlyIncome => _mMonthlyIncome;
  set monthlyIncome(double value) => _mMonthlyIncome = value;

  int get dailyPatients => _mDailyPatients;
  set dailyPatients(int value) => _mDailyPatients = value;

  int get monthlyPatients => _mMonthlyPatients;
  set monthlyPatients(int value) => _mMonthlyPatients = value;

  double get dailyExpenses => _mDailyExpenses;
  set dailyExpenses(double value) => _mDailyExpenses = value;

  double get monthlyExpenses => _mMonthlyExpenses;
  set monthlyExpenses(double value) => _mMonthlyExpenses = value;

  double get dailyProfit => _mDailyProfit;
  set dailyProfit(double value) => _mDailyProfit = value;

  double get monthlyProfit => _mMonthlyProfit;
  set monthlyProfit(double value) => _mMonthlyProfit = value;

  factory Clinic.fromFirestore(Map<String, dynamic> data) {
    return Clinic(
      data['dailyIncome'] as double,
      data['monthlyIncome'] as double,
      data['dailyPatients'] as int,
      data['monthlyPatients'] as int,
      data['dailyExpenses'] as double,
      data['monthlyExpenses'] as double,
      data['dailyProfit'] as double,
      data['monthlyProfit'] as double,
    );
  }

  Map<String, dynamic> toMap() {
    return {
      'dailyIncome': _mDailyIncome,
      'monthlyIncome': _mMonthlyIncome,
      'dailyPatients': _mDailyPatients,
      'monthlyPatients': _mMonthlyPatients,
      'dailyExpenses': _mDailyExpenses,
      'monthlyExpenses': _mMonthlyExpenses,
      'dailyProfit': _mDailyProfit,
      'monthlyProfit': _mMonthlyProfit,
    };
  }
}

Clinic clinic = Clinic(
  1000.0,
  30000.0,
  10,
  300,
  500.0,
  15000.0,
  500.0,
  15000.0,
);
