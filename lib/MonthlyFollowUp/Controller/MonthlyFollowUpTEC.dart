import 'package:flutter/cupertino.dart';

class MonthlyFollowUpTEC {
  static late TextEditingController mBMIController;
  static late TextEditingController mPBFController;
  static late TextEditingController mWaterController;
  static late TextEditingController mMaxWeightController;
  static late TextEditingController mOptimalWeightController;
  static late TextEditingController mBMRController;
  static late TextEditingController mMaxCaloriesController;
  static late TextEditingController mDailyCaloriesController;

  static void initMonthlyFollowUpTEC() {
    mBMIController = TextEditingController();
    mPBFController = TextEditingController();
    mWaterController = TextEditingController();
    mMaxWeightController = TextEditingController();
    mOptimalWeightController = TextEditingController();
    mBMRController = TextEditingController();
    mMaxCaloriesController = TextEditingController();
    mDailyCaloriesController = TextEditingController();
  }

  static void clearMonthlyFollowUpTEC() {
    mBMIController.clear();
    mPBFController.clear();
    mWaterController.clear();
    mMaxWeightController.clear();
    mOptimalWeightController.clear();
    mBMRController.clear();
    mMaxCaloriesController.clear();
    mDailyCaloriesController.clear();
  }

  static void disposeMonthlyFollowUpTEC() {
    mBMIController.dispose();
    mPBFController.dispose();
    mWaterController.dispose();
    mMaxWeightController.dispose();
    mOptimalWeightController.dispose();
    mBMRController.dispose();
    mMaxCaloriesController.dispose();
    mDailyCaloriesController.dispose();
  }
}