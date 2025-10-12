import 'package:flutter/cupertino.dart';

class BiweeklyFollowUpTEC {
  static late TextEditingController mWeightController;
  static late TextEditingController mPBFController;
  static late TextEditingController mWaterController;
  static late TextEditingController mMaxWeightController;
  static late TextEditingController mOptimalWeightController;
  static late TextEditingController mBMRController;
  static late TextEditingController mMaxCaloriesController;
  static late TextEditingController mDailyCaloriesController;
  static late TextEditingController mMuscleMassController;

  static void init() {
    mWeightController = TextEditingController();
    mPBFController = TextEditingController();
    mWaterController = TextEditingController();
    mMaxWeightController = TextEditingController();
    mOptimalWeightController = TextEditingController();
    mBMRController = TextEditingController();
    mMaxCaloriesController = TextEditingController();
    mDailyCaloriesController = TextEditingController();
    mMuscleMassController = TextEditingController();
  }

  static void clear() {
    mWeightController.clear();
    mPBFController.clear();
    mWaterController.clear();
    mMaxWeightController.clear();
    mOptimalWeightController.clear();
    mBMRController.clear();
    mMaxCaloriesController.clear();
    mDailyCaloriesController.clear();
    mMuscleMassController.clear();
  }

  static void dispose() {
    mWeightController.dispose();
    mPBFController.dispose();
    mWaterController.dispose();
    mMaxWeightController.dispose();
    mOptimalWeightController.dispose();
    mBMRController.dispose();
    mMaxCaloriesController.dispose();
    mDailyCaloriesController.dispose();
    mMuscleMassController.dispose();
  }
}