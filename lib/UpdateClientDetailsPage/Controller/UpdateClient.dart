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
import '../../Core/View/PopUps/MySnackBar.dart';
import 'UpdateClientDetailsTEC.dart';

Future<bool> updateClient(
  BuildContext context,
  Client client,
  Disease disease,
  ClientMonthlyFollowUp cmfu,
  ClientConstantInfo cci,
  WeightAreas wa,
  PreferredFoods pf,
) async {
  try {
    if (!await _validatePhoneNumber(context, client)) return false;

    _updateClientFields(client);
    if (!await _updateDisease(context, disease)) return false;
    if (!await _updateClientMonthlyFollowUp(context, cmfu)) return false;
    if (!await _updateClientConstantInfo(context, cci)) return false;
    if (!await _updatePreferredFoods(context, pf)) return false;
    if (!await _updateWeightAreas(context, wa)) return false;

    await context.read<ClientProvider>().updateClient(client);
    return true;
  } catch (e) {
    debugPrint("Failed to update client: $e");
    return false;
  }
}

Future<bool> _validatePhoneNumber(BuildContext context, Client client) async {
  final phoneController = UpdateClientDetailsTEC.phoneController.text;
  if (phoneController != client.mClientPhoneNum) {
    final isPhoneUsed =
        await context.read<ClientProvider>().isPhoneNumUsed(phoneController);
    if (isPhoneUsed) {
      showMySnackBar(context, 'هذا الرقم مستخدم بالفعل', Colors.red);
      return false;
    }
  }
  return true;
}

void _updateClientFields(Client client) {
  client.mName = UpdateClientDetailsTEC.nameController.text;
  client.mClientPhoneNum = UpdateClientDetailsTEC.phoneController.text;
  client.mBirthdate =
      int.tryParse(UpdateClientDetailsTEC.birthYearController.text) != null
          ? DateTime(int.parse(UpdateClientDetailsTEC.birthYearController.text),
              12, 31)
          : null;
  client.mDiet = UpdateClientDetailsTEC.dietController.text;
  client.Plat = UpdateClientDetailsTEC.platControllers
      .map((e) => double.tryParse(e.text) ?? 0.0)
      .toList();
  client.mHeight =
      double.tryParse(UpdateClientDetailsTEC.heightController.text);
  client.mWeight =
      double.tryParse(UpdateClientDetailsTEC.weightController.text);
  client.mSubscriptionType = getSubscriptionTypeFromString(
      UpdateClientDetailsTEC.subscriptionTypeController.text);
  client.mNotes = UpdateClientDetailsTEC.notesController.text;
  client.mGender =
      getGenderFromString(UpdateClientDetailsTEC.genderController.text);
}

Future<bool> _updateDisease(BuildContext context, Disease d) async {
  try {
    d.mHypertension =
        UpdateClientDetailsTEC.hypertensionController.text.toLowerCase() ==
            'true';
    d.mHypotension =
        UpdateClientDetailsTEC.hypotensionController.text.toLowerCase() ==
            'true';
    d.mVascular =
        UpdateClientDetailsTEC.vascularController.text.toLowerCase() == 'true';
    d.mAnemia =
        UpdateClientDetailsTEC.anemiaController.text.toLowerCase() == 'true';
    d.mOtherHeart = UpdateClientDetailsTEC.otherHeartController.text;
    d.mColon =
        UpdateClientDetailsTEC.colonController.text.toLowerCase() == 'true';
    d.mConstipation =
        UpdateClientDetailsTEC.constipationController.text.toLowerCase() ==
            'true';
    d.mFamilyHistoryDM =
        UpdateClientDetailsTEC.familyHistoryDMController.text.toLowerCase() ==
            'true';
    d.mPreviousOBMed =
        UpdateClientDetailsTEC.previousOBMedController.text.toLowerCase() ==
            'true';
    d.mPreviousOBOperations = UpdateClientDetailsTEC
            .previousOBOperationsController.text
            .toLowerCase() ==
        'true';
    d.mRenal = UpdateClientDetailsTEC.renalController.text;
    d.mLiver = UpdateClientDetailsTEC.liverController.text;
    d.mGit = UpdateClientDetailsTEC.gitController.text;
    d.mEndocrine = UpdateClientDetailsTEC.endocrineController.text;
    d.mRheumatic = UpdateClientDetailsTEC.rheumaticController.text;
    d.mAllergies = UpdateClientDetailsTEC.allergiesController.text;
    d.mNeuro = UpdateClientDetailsTEC.neuroController.text;
    d.mPsychiatric = UpdateClientDetailsTEC.psychiatricController.text;
    d.mOtherDiseases = UpdateClientDetailsTEC.otherDiseasesController.text;
    d.mHormonal = UpdateClientDetailsTEC.hormonalController.text;

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
        double.tryParse(UpdateClientDetailsTEC.bmiController.text) ?? 0.0;
    cmfu.mPBF =
        double.tryParse(UpdateClientDetailsTEC.pbfController.text) ?? 0.0;
    cmfu.mWater =
        double.tryParse(UpdateClientDetailsTEC.waterController.text) ?? 0.0;
    cmfu.mMaxWeight =
        double.tryParse(UpdateClientDetailsTEC.maxWeightController.text) ?? 0.0;
    cmfu.mOptimalWeight =
        double.tryParse(UpdateClientDetailsTEC.optimalWeightController.text) ??
            0.0;
    cmfu.mBMR =
        double.tryParse(UpdateClientDetailsTEC.bmrController.text) ?? 0.0;
    cmfu.mMaxCalories =
        double.tryParse(UpdateClientDetailsTEC.maxCaloriesController.text) ??
            0.0;
    cmfu.mDailyCalories =
        double.tryParse(UpdateClientDetailsTEC.dailyCaloriesController.text) ??
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
    cci.mArea = UpdateClientDetailsTEC.areaController.text;
    cci.mActivityLevel = getActivityLevelFromString(
        UpdateClientDetailsTEC.activityLevelController.text);
    cci.mYOYO =
        UpdateClientDetailsTEC.yoyoController.text.toLowerCase() == 'true';
    cci.mSports =
        UpdateClientDetailsTEC.sportsController.text.toLowerCase() == 'true';

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
        UpdateClientDetailsTEC.carbohydratesController.text.toLowerCase() ==
            'true';
    pf.mProtein =
        UpdateClientDetailsTEC.proteinController.text.toLowerCase() == 'true';
    pf.mDairy =
        UpdateClientDetailsTEC.dairyController.text.toLowerCase() == 'true';
    pf.mVeg = UpdateClientDetailsTEC.vegController.text.toLowerCase() == 'true';
    pf.mFruits =
        UpdateClientDetailsTEC.fruitsController.text.toLowerCase() == 'true';
    pf.mOthers = UpdateClientDetailsTEC.otherPreferredFoodsController.text;

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
        UpdateClientDetailsTEC.abdomenController.text.toLowerCase() == 'true';
    wa.mButtocks =
        UpdateClientDetailsTEC.buttocksController.text.toLowerCase() == 'true';
    wa.mWaist =
        UpdateClientDetailsTEC.waistController.text.toLowerCase() == 'true';
    wa.mThighs =
        UpdateClientDetailsTEC.thighsController.text.toLowerCase() == 'true';
    wa.mArms =
        UpdateClientDetailsTEC.armsController.text.toLowerCase() == 'true';
    wa.mBreast =
        UpdateClientDetailsTEC.breastController.text.toLowerCase() == 'true';
    wa.mBack =
        UpdateClientDetailsTEC.backController.text.toLowerCase() == 'true';

    await context.read<WeightAreasProvider>().updateWeightAreas(wa);
    return true;
  } on Exception catch (e) {
    debugPrint("Failed to update weight areas: $e");
    return false;
  }
}
