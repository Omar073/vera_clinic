import 'package:flutter/cupertino.dart';

class ClientRegistrationTEC {
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

  static late TextEditingController othersDiseaseController;

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
  static late TextEditingController othersPreferredFoodsController;

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

  static void init() {
    // Client Controllers
    nameController = TextEditingController();
    phoneController = TextEditingController();
    birthdateController = TextEditingController();
    dietController = TextEditingController();
    platControllers = List.generate(10, (index) => TextEditingController());
    heightController = TextEditingController();
    weightController = TextEditingController();
    subscriptionTypeController = TextEditingController();
    notesController = TextEditingController();
    genderController = TextEditingController();

    // Disease Controllers
    hypertensionController = TextEditingController();
    hypotensionController = TextEditingController();
    vascularController = TextEditingController();
    anemiaController = TextEditingController();
    otherHeartController = TextEditingController();
    renalController = TextEditingController();
    liverController = TextEditingController();
    gitController = TextEditingController();
    colonController = TextEditingController();
    constipationController = TextEditingController();
    endocrineController = TextEditingController();
    rheumaticController = TextEditingController();
    allergiesController = TextEditingController();
    neuroController = TextEditingController();
    psychiatricController = TextEditingController();
    othersDiseaseController = TextEditingController();
    hormonalController = TextEditingController();
    familyHistoryDMController = TextEditingController();
    previousOBMedController = TextEditingController();
    previousOBOperationsController = TextEditingController();

    // Client Constant Info Controllers
    areaController = TextEditingController();
    activityLevelController = TextEditingController();
    yoyoController = TextEditingController();
    sportsController = TextEditingController();

    // Preferred Foods Controllers
    carbohydratesController = TextEditingController();
    proteinController = TextEditingController();
    dairyController = TextEditingController();
    vegController = TextEditingController();
    fruitsController = TextEditingController();
    othersPreferredFoodsController = TextEditingController();

    // Weight Areas Controllers
    abdomenController = TextEditingController();
    buttocksController = TextEditingController();
    waistController = TextEditingController();
    thighsController = TextEditingController();
    armsController = TextEditingController();
    breastController = TextEditingController();
    backController = TextEditingController();

    // Client Monthly Follow-Up Controllers
    bmiController = TextEditingController();
    pbfController = TextEditingController();
    waterController = TextEditingController();
    maxWeightController = TextEditingController();
    optimalWeightController = TextEditingController();
    bmrController = TextEditingController();
    maxCaloriesController = TextEditingController();
    dailyCaloriesController = TextEditingController();
  }

  static void clear() {
    // Client Controllers
    nameController.clear();
    phoneController.clear();
    birthdateController.clear();
    dietController.clear();
    platControllers.forEach((element) {
      element.clear();
    });
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
    othersDiseaseController.clear();
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
    othersPreferredFoodsController.clear();

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
    platControllers.forEach((element) {
      ;
      element.dispose();
    });
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
    othersDiseaseController.dispose();
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
    othersPreferredFoodsController.dispose();

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

/*
All client inserted attributes
Client:
Name
ClientPhoneNum
Birthdate dateTime
Diet
Plat (Last 10 stable weights) list of doubles
Height double
Weight double
Subscription type enum
Notes

ClientConstantInfo:
Area
ActivityLevel enum
YOYO bool
sports bool

Disease:
Hypertension: bool
Hypotension: bool
Vascular: bool
Anemia: bool
Renal: String
Liver: String
Git: String
Colon: bool
Constipation: bool
Endocrine: String
Rheumatic: String
Allergies: String
Neuro: String
Psychiatric: String
Others: String
Hormonal: String
FamilyHistoryDM: bool
PreviousOBMed: bool
PreviousOBOperations: bool

ClientMonthlyFollowUp:
BMI: double?
PBF: double?
Water: double?
MaxWeight: double?
OptimalWeight: double?
BMR: double?
MaxCalories: int?
OptimalCalories: int?

Preferred foods:
carbohydrates - bool
protein - bool
dairy - bool
veg - bool
fruits - bool
others - String

WeightAreas:
Abdomen: bool
Buttocks: bool
Waist: bool
Thighs: bool
Arms: bool
Breast: bool
Back: bool

Visit:
Date: DateTime
Diet: String
Weight: double
BMI: double
*/
