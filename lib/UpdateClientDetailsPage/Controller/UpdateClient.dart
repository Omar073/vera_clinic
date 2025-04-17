import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/PreferredFoods.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';

import '../../Core/Controller/Providers/ClientProvider.dart';
import '../../Core/Controller/Providers/PreferredFoodsProvider.dart';
import '../../Core/Controller/Providers/WeightAreasProvider.dart';
import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Disease.dart';
import '../../Core/View/SnackBars/MySnackBar.dart';
import 'UpdateClientDetailsPageTEC.dart';

Future<bool> updateClient(
    BuildContext context,
    Client c,
    Disease d,
    ClientMonthlyFollowUp cmfu,
    ClientConstantInfo cci,
    WeightAreas wa,
    PreferredFoods pf) async {
  try {
    if (UpdateClientDetailsPageTEC.phoneController.text !=
        c.mClientPhoneNum.toString()) {
      if (await context
          .read<ClientProvider>()
          .isPhoneNumUsed(UpdateClientDetailsPageTEC.phoneController.text)) {
        showMySnackBar(context, 'هذا الرقم مستخدم بالفعل', Colors.red);
        return false;
      }
    }

    //update c parameters with parameters from text fields
    c.mName = UpdateClientDetailsPageTEC.nameController.text;
    c.mClientPhoneNum = UpdateClientDetailsPageTEC.phoneController.text;
    c.mBirthdate =
        DateTime.tryParse(UpdateClientDetailsPageTEC.birthdateController.text);
    c.mDiet = UpdateClientDetailsPageTEC.dietController.text;
    c.Plat = UpdateClientDetailsPageTEC.platControllers
        .map((e) => double.tryParse(e.text) ?? 0.0)
        .toList();
    c.mHeight =
        double.tryParse(UpdateClientDetailsPageTEC.heightController.text);
    c.mWeight =
        double.tryParse(UpdateClientDetailsPageTEC.weightController.text);
    c.mSubscriptionType = getSubscriptionTypeFromString(
        UpdateClientDetailsPageTEC.subscriptionTypeController.text);
    c.mNotes = UpdateClientDetailsPageTEC.notesController.text;
    c.mGender =
        getGenderFromString(UpdateClientDetailsPageTEC.genderController.text);

    if (!await _updateDisease(context, d)) return false;
    if (!await _updateClientMonthlyFollowUp(context, cmfu)) return false;
    if (!await _updateClientConstantInfo(context, cci)) return false;
    if (!await _updatePreferredFoods(context, pf)) return false;
    if (!await _updateWeightAreas(context, wa)) return false;

    await context.read<ClientProvider>().updateClient(c);

    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update client: $e");
    return false;
  }
}

Future<bool> _updateDisease(BuildContext context, Disease d) async {
  try {
    d.mHypertension =
        UpdateClientDetailsPageTEC.hypertensionController.text.toLowerCase() ==
            'true';
    d.mHypotension =
        UpdateClientDetailsPageTEC.hypotensionController.text.toLowerCase() ==
            'true';
    d.mVascular =
        UpdateClientDetailsPageTEC.vascularController.text.toLowerCase() ==
            'true';
    d.mAnemia =
        UpdateClientDetailsPageTEC.anemiaController.text.toLowerCase() ==
            'true';
    d.mOtherHeart = UpdateClientDetailsPageTEC.otherHeartController.text;
    d.mColon =
        UpdateClientDetailsPageTEC.colonController.text.toLowerCase() == 'true';
    d.mConstipation =
        UpdateClientDetailsPageTEC.constipationController.text.toLowerCase() ==
            'true';
    d.mFamilyHistoryDM = UpdateClientDetailsPageTEC
            .familyHistoryDMController.text
            .toLowerCase() ==
        'true';
    d.mPreviousOBMed =
        UpdateClientDetailsPageTEC.previousOBMedController.text.toLowerCase() ==
            'true';
    d.mPreviousOBOperations = UpdateClientDetailsPageTEC
            .previousOBOperationsController.text
            .toLowerCase() ==
        'true';
    d.mRenal = UpdateClientDetailsPageTEC.renalController.text;
    d.mLiver = UpdateClientDetailsPageTEC.liverController.text;
    d.mGit = UpdateClientDetailsPageTEC.gitController.text;
    d.mEndocrine = UpdateClientDetailsPageTEC.endocrineController.text;
    d.mRheumatic = UpdateClientDetailsPageTEC.rheumaticController.text;
    d.mAllergies = UpdateClientDetailsPageTEC.allergiesController.text;
    d.mNeuro = UpdateClientDetailsPageTEC.neuroController.text;
    d.mPsychiatric = UpdateClientDetailsPageTEC.psychiatricController.text;
    d.mOtherDiseases = UpdateClientDetailsPageTEC.otherDiseasesController.text;
    d.mHormonal = UpdateClientDetailsPageTEC.hormonalController.text;

    await context.read<DiseaseProvider>().updateDisease(d);
    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update disease: $e");
    return false;
  }
}

Future<bool> _updateClientMonthlyFollowUp(
    BuildContext context, ClientMonthlyFollowUp cmfu) async {
  try {
    cmfu.mBMI =
        double.tryParse(UpdateClientDetailsPageTEC.bmiController.text) ?? 0.0;
    cmfu.mPBF =
        double.tryParse(UpdateClientDetailsPageTEC.pbfController.text) ?? 0.0;
    cmfu.mWater =
        double.tryParse(UpdateClientDetailsPageTEC.waterController.text) ?? 0.0;
    cmfu.mMaxWeight =
        double.tryParse(UpdateClientDetailsPageTEC.maxWeightController.text) ??
            0.0;
    cmfu.mOptimalWeight = double.tryParse(
            UpdateClientDetailsPageTEC.optimalWeightController.text) ??
        0.0;
    cmfu.mBMR =
        double.tryParse(UpdateClientDetailsPageTEC.bmrController.text) ?? 0.0;
    cmfu.mMaxCalories = double.tryParse(
            UpdateClientDetailsPageTEC.maxCaloriesController.text) ??
        0.0;
    cmfu.mDailyCalories = double.tryParse(
            UpdateClientDetailsPageTEC.dailyCaloriesController.text) ??
        0.0;

    await context
        .read<ClientMonthlyFollowUpProvider>()
        .updateClientMonthlyFollowUp(cmfu);
    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update client monthly follow up: $e");
    return false;
  }
}

Future<bool> _updateClientConstantInfo(
    BuildContext context, ClientConstantInfo cci) async {
  try {
    cci.mArea = UpdateClientDetailsPageTEC.areaController.text;
    cci.mActivityLevel = getActivityLevelFromString(
        UpdateClientDetailsPageTEC.activityLevelController.text);
    cci.mYOYO =
        UpdateClientDetailsPageTEC.yoyoController.text.toLowerCase() == 'true';
    cci.mSports =
        UpdateClientDetailsPageTEC.sportsController.text.toLowerCase() ==
            'true';

    await context
        .read<ClientConstantInfoProvider>()
        .updateClientConstantInfo(cci);
    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update client constant info: $e");
    return false;
  }
}

Future<bool> _updatePreferredFoods(
    BuildContext context, PreferredFoods pf) async {
  try {
    pf.mCarbohydrates =
        UpdateClientDetailsPageTEC.carbohydratesController.text.toLowerCase() ==
            'true';
    pf.mProtein =
        UpdateClientDetailsPageTEC.proteinController.text.toLowerCase() ==
            'true';
    pf.mDairy =
        UpdateClientDetailsPageTEC.dairyController.text.toLowerCase() == 'true';
    pf.mVeg =
        UpdateClientDetailsPageTEC.vegController.text.toLowerCase() == 'true';
    pf.mFruits =
        UpdateClientDetailsPageTEC.fruitsController.text.toLowerCase() ==
            'true';
    pf.mOthers = UpdateClientDetailsPageTEC.otherPreferredFoodsController.text;

    await context.read<PreferredFoodsProvider>().updatePreferredFoods(pf);
    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update preferred foods: $e");
    return false;
  }
}

Future<bool> _updateWeightAreas(BuildContext context, WeightAreas wa) async {
  try {
    wa.mAbdomen =
        UpdateClientDetailsPageTEC.abdomenController.text.toLowerCase() ==
            'true';
    wa.mButtocks =
        UpdateClientDetailsPageTEC.buttocksController.text.toLowerCase() ==
            'true';
    wa.mWaist =
        UpdateClientDetailsPageTEC.waistController.text.toLowerCase() == 'true';
    wa.mThighs =
        UpdateClientDetailsPageTEC.thighsController.text.toLowerCase() ==
            'true';
    wa.mArms =
        UpdateClientDetailsPageTEC.armsController.text.toLowerCase() == 'true';
    wa.mBreast =
        UpdateClientDetailsPageTEC.breastController.text.toLowerCase() ==
            'true';
    wa.mBack =
        UpdateClientDetailsPageTEC.backController.text.toLowerCase() == 'true';

    await context.read<WeightAreasProvider>().updateWeightAreas(wa);
    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update weight areas: $e");
    return false;
  }
}
