import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';

class UpdateMonthlyFollowUpDetailsTEC {
  // Monthly Follow Up
  static late TextEditingController dateController;
  static late TextEditingController waterController;
  static late TextEditingController bmiController;
  static late TextEditingController muscleMassController;
  static late TextEditingController pbfController;
  static late TextEditingController bmrController;
  static late TextEditingController maxWeightController;
  static late TextEditingController optimalWeightController;
  static late TextEditingController dailyCaloriesController;
  static late TextEditingController maxCaloriesController;
  static late TextEditingController notesController;

  static void init(ClientMonthlyFollowUp cmfu) {
    dateController = TextEditingController(
        text: cmfu.mDate != null ? DateFormat('dd/MM/yyyy').format(cmfu.mDate!) : '');
    waterController = TextEditingController(text: cmfu.mWater ?? '');
    bmiController = TextEditingController(text: _formatDouble(cmfu.mBMI));
    muscleMassController = TextEditingController(text: _formatDouble(cmfu.mMuscleMass));
    pbfController = TextEditingController(text: _formatDouble(cmfu.mPBF));
    bmrController = TextEditingController(text: _formatDouble(cmfu.mBMR));
    maxWeightController = TextEditingController(text: _formatDouble(cmfu.mMaxWeight));
    optimalWeightController = TextEditingController(text: _formatDouble(cmfu.mOptimalWeight));
    dailyCaloriesController = TextEditingController(text: _formatDouble(cmfu.mDailyCalories));
    maxCaloriesController = TextEditingController(text: _formatDouble(cmfu.mMaxCalories));
    notesController = TextEditingController(text: cmfu.mNotes ?? '');
  }

  static String _formatDouble(double? value) {
    if (value == null) return '';
    return value.toString();
  }

  static void clear() {
    dateController.clear();
    waterController.clear();
    bmiController.clear();
    muscleMassController.clear();
    pbfController.clear();
    bmrController.clear();
    maxWeightController.clear();
    optimalWeightController.clear();
    dailyCaloriesController.clear();
    maxCaloriesController.clear();
    notesController.clear();
  }

  static void dispose() {
    dateController.dispose();
    waterController.dispose();
    bmiController.dispose();
    muscleMassController.dispose();
    pbfController.dispose();
    bmrController.dispose();
    maxWeightController.dispose();
    optimalWeightController.dispose();
    dailyCaloriesController.dispose();
    maxCaloriesController.dispose();
    notesController.dispose();
  }
}
