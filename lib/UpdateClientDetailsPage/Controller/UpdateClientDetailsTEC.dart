import 'package:flutter/cupertino.dart';

import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/ClientConstantInfo.dart';
import '../../Core/Model/Classes/ClientMonthlyFollowUp.dart';
import '../../Core/Model/Classes/Disease.dart';
import '../../Core/Model/Classes/PreferredFoods.dart';
import '../../Core/Model/Classes/WeightAreas.dart';

class UpdateClientDetailsTEC {
  // Client Controllers
  static late TextEditingController nameController;
  static late TextEditingController phoneController;
  static late TextEditingController birthdateController;
  static late TextEditingController dietController;
  static late List<TextEditingController> platControllers;
  static late TextEditingController heightController;
  static late TextEditingController weightController;
  static late TextEditingController subscriptionTypeController;

  static late TextEditingController notesController;
  static late TextEditingController genderController;

  // Disease Controllers
  static late TextEditingController hypertensionController;

  static late TextEditingController hypotensionController;

  static late TextEditingController vascularController;

  static late TextEditingController anemiaController;
  static late TextEditingController otherHeartController;

  static late TextEditingController renalController;
  static late TextEditingController liverController;
  static late TextEditingController gitController;
  static late TextEditingController colonController;
  static late TextEditingController constipationController;

  static late TextEditingController endocrineController;

  static late TextEditingController rheumaticController;

  static late TextEditingController allergiesController;

  static late TextEditingController neuroController;
  static late TextEditingController psychiatricController;

  static late TextEditingController otherDiseasesController;

  static late TextEditingController hormonalController;

  static late TextEditingController familyHistoryDMController;

  static late TextEditingController previousOBMedController;

  static late TextEditingController previousOBOperationsController;

  // Client Constant Info Controllers
  static late TextEditingController areaController;
  static late TextEditingController activityLevelController;
  static late TextEditingController yoyoController;
  static late TextEditingController sportsController;

  // Preferred Foods Controllers
  static late TextEditingController carbohydratesController;
  static late TextEditingController proteinController;
  static late TextEditingController dairyController;
  static late TextEditingController vegController;
  static late TextEditingController fruitsController;
  static late TextEditingController otherPreferredFoodsController;

  // Weight Areas Controllers
  static late TextEditingController abdomenController;
  static late TextEditingController buttocksController;
  static late TextEditingController waistController;
  static late TextEditingController thighsController;
  static late TextEditingController armsController;
  static late TextEditingController breastController;
  static late TextEditingController backController;

  // Client Monthly Follow-Up Controllers
  static late TextEditingController bmiController;
  static late TextEditingController pbfController;
  static late TextEditingController waterController;
  static late TextEditingController maxWeightController;
  static late TextEditingController optimalWeightController;
  static late TextEditingController bmrController;
  static late TextEditingController maxCaloriesController;
  static late TextEditingController dailyCaloriesController;

  static void init(Client c, Disease d, ClientConstantInfo cci, WeightAreas wa,
      PreferredFoods pf, ClientMonthlyFollowUp cmfu) {
    _initClientControllers(c);
    _initDiseaseControllers(d);
    _initConstantInfoControllers(cci);
    _initPreferredFoodsControllers(pf);
    _initWeightAreasControllers(wa);
    _initMonthlyFollowUpControllers(cmfu);
  }

  static void _initClientControllers(Client c) {
    nameController = TextEditingController(text: c.mName ?? '');
    phoneController = TextEditingController(text: c.mClientPhoneNum ?? '');
    birthdateController = TextEditingController(text: c.mBirthdate.toString());
    dietController = TextEditingController(text: c.mDiet ?? '');
    platControllers = List.generate(10,
        (index) => TextEditingController(text: c.Plat[index].toString()));
    heightController = TextEditingController(text: c.mHeight?.toString() ?? '');
    weightController = TextEditingController(text: c.mWeight?.toString() ?? '');
    subscriptionTypeController = TextEditingController(
        text: getSubscriptionTypeLabel(
            c.mSubscriptionType ?? SubscriptionType.none));
    notesController = TextEditingController(text: c.mNotes ?? '');
    genderController = TextEditingController(text: getGenderLabel(c.mGender));
  }

  static void _initDiseaseControllers(Disease d) {
    hypertensionController =
        TextEditingController(text: d.mHypertension ? 'true' : 'false');
    hypotensionController =
        TextEditingController(text: d.mHypotension ? 'true' : 'false');
    vascularController =
        TextEditingController(text: d.mVascular ? 'true' : 'false');
    anemiaController =
        TextEditingController(text: d.mAnemia ? 'true' : 'false');
    otherHeartController = TextEditingController(text: d.mOtherHeart ?? '');
    renalController = TextEditingController(text: d.mRenal);
    liverController = TextEditingController(text: d.mLiver);
    gitController = TextEditingController(text: d.mGit);
    colonController = TextEditingController(text: d.mColon ? 'true' : 'false');
    constipationController =
        TextEditingController(text: d.mConstipation ? 'true' : 'false');
    endocrineController = TextEditingController(text: d.mEndocrine);
    rheumaticController = TextEditingController(text: d.mRheumatic);
    allergiesController = TextEditingController(text: d.mAllergies);
    neuroController = TextEditingController(text: d.mNeuro);
    psychiatricController = TextEditingController(text: d.mPsychiatric);
    otherDiseasesController = TextEditingController(text: d.mOtherDiseases);
    hormonalController = TextEditingController(text: d.mHormonal);
    familyHistoryDMController =
        TextEditingController(text: d.mFamilyHistoryDM ? 'true' : 'false');
    previousOBMedController =
        TextEditingController(text: d.mPreviousOBMed ? 'true' : 'false');
    previousOBOperationsController =
        TextEditingController(text: d.mPreviousOBOperations ? 'true' : 'false');
  }

  static void _initConstantInfoControllers(ClientConstantInfo cci) {
    areaController = TextEditingController(text: cci.mArea ?? '');
    activityLevelController = TextEditingController(
        text: getActivityLevelLabel(cci.mActivityLevel ?? Activity.none));
    yoyoController = TextEditingController(text: cci.mYOYO ? 'true' : 'false');
    sportsController =
        TextEditingController(text: cci.mSports ? 'true' : 'false');
  }

  static void _initPreferredFoodsControllers(PreferredFoods pf) {
    carbohydratesController =
        TextEditingController(text: pf.mCarbohydrates ? 'true' : 'false');
    proteinController =
        TextEditingController(text: pf.mProtein ? 'true' : 'false');
    dairyController = TextEditingController(text: pf.mDairy ? 'true' : 'false');
    vegController = TextEditingController(text: pf.mVeg ? 'true' : 'false');
    fruitsController =
        TextEditingController(text: pf.mFruits ? 'true' : 'false');
    otherPreferredFoodsController = TextEditingController(text: pf.mOthers);
  }

  static void _initWeightAreasControllers(WeightAreas wa) {
    abdomenController =
        TextEditingController(text: wa.mAbdomen ? 'true' : 'false');
    buttocksController =
        TextEditingController(text: wa.mButtocks ? 'true' : 'false');
    waistController = TextEditingController(text: wa.mWaist ? 'true' : 'false');
    thighsController =
        TextEditingController(text: wa.mThighs ? 'true' : 'false');
    armsController = TextEditingController(text: wa.mArms ? 'true' : 'false');
    breastController =
        TextEditingController(text: wa.mBreast ? 'true' : 'false');
    backController = TextEditingController(text: wa.mBack ? 'true' : 'false');
  }

  static void _initMonthlyFollowUpControllers(ClientMonthlyFollowUp cmfu) {
    bmiController = TextEditingController(text: cmfu.mBMI?.toString() ?? '');
    pbfController = TextEditingController(text: cmfu.mPBF?.toString() ?? '');
    waterController =
        TextEditingController(text: cmfu.mWater?.toString() ?? '');
    maxWeightController =
        TextEditingController(text: cmfu.mMaxWeight?.toString() ?? '');
    optimalWeightController =
        TextEditingController(text: cmfu.mOptimalWeight?.toString() ?? '');
    bmrController = TextEditingController(text: cmfu.mBMR?.toString() ?? '');
    maxCaloriesController =
        TextEditingController(text: cmfu.mMaxCalories?.toString() ?? '');
    dailyCaloriesController =
        TextEditingController(text: cmfu.mDailyCalories?.toString() ?? '');
  }

  static void clear() {
    // Client Controllers
    nameController.clear();
    phoneController.clear();
    birthdateController.clear();
    dietController.clear();
    for (var controller in platControllers) {
      controller.clear();
    }
    heightController.clear();
    weightController.clear();
    subscriptionTypeController.clear();
    notesController.clear();
    genderController.clear();

    // Disease Controllers
    hypertensionController.clear();
    hypotensionController.clear();
    vascularController.clear();
    anemiaController.clear();
    otherHeartController.clear();
    colonController.clear();
    constipationController.clear();
    familyHistoryDMController.clear();
    previousOBMedController.clear();
    previousOBOperationsController.clear();
    renalController.clear();
    liverController.clear();
    gitController.clear();
    endocrineController.clear();
    rheumaticController.clear();
    allergiesController.clear();
    neuroController.clear();
    psychiatricController.clear();
    otherDiseasesController.clear();
    hormonalController.clear();

    // Client Constant Info Controllers
    areaController.clear();
    activityLevelController.clear();
    yoyoController.clear();
    sportsController.clear();

    // Preferred Foods Controllers
    carbohydratesController.clear();
    proteinController.clear();
    dairyController.clear();
    vegController.clear();
    fruitsController.clear();
    otherPreferredFoodsController.clear();

    // Weight Areas Controllers
    abdomenController.clear();
    buttocksController.clear();
    waistController.clear();
    thighsController.clear();
    armsController.clear();
    breastController.clear();
    backController.clear();

    // Client Monthly Follow-Up Controllers
    bmiController.clear();
    pbfController.clear();
    waterController.clear();
    maxWeightController.clear();
    optimalWeightController.clear();
    bmrController.clear();
    maxCaloriesController.clear();
    dailyCaloriesController.clear();
  }

  static void dispose() {
    // Client Controllers
    nameController.dispose();
    phoneController.dispose();
    birthdateController.dispose();
    dietController.dispose();
    for (var controller in platControllers) {
      controller.dispose();
    }
    heightController.dispose();
    weightController.dispose();
    subscriptionTypeController.dispose();
    notesController.dispose();
    genderController.dispose();

    // Disease Controllers
    hypertensionController.dispose();
    hypotensionController.dispose();
    vascularController.dispose();
    anemiaController.dispose();
    otherHeartController.dispose();
    renalController.dispose();
    liverController.dispose();
    gitController.dispose();
    colonController.dispose();
    constipationController.dispose();
    endocrineController.dispose();
    rheumaticController.dispose();
    allergiesController.dispose();
    neuroController.dispose();
    psychiatricController.dispose();
    otherDiseasesController.dispose();
    hormonalController.dispose();
    familyHistoryDMController.dispose();
    previousOBMedController.dispose();
    previousOBOperationsController.dispose();

    // Client Constant Info Controllers
    areaController.dispose();
    activityLevelController.dispose();
    yoyoController.dispose();
    sportsController.dispose();

    // Preferred Foods Controllers
    carbohydratesController.dispose();
    proteinController.dispose();
    dairyController.dispose();
    vegController.dispose();
    fruitsController.dispose();
    otherPreferredFoodsController.dispose();

    // Weight Areas Controllers
    abdomenController.dispose();
    buttocksController.dispose();
    waistController.dispose();
    thighsController.dispose();
    armsController.dispose();
    breastController.dispose();
    backController.dispose();

    // Client Monthly Follow-Up Controllers
    bmiController.dispose();
    pbfController.dispose();
    waterController.dispose();
    maxWeightController.dispose();
    optimalWeightController.dispose();
    bmrController.dispose();
    maxCaloriesController.dispose();
    dailyCaloriesController.dispose();
  }
}
