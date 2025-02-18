import 'package:flutter/cupertino.dart';

class ClientRegistrationTEC {
  // Client Controllers
  static final TextEditingController nameController = TextEditingController();
  static final TextEditingController phoneController = TextEditingController();
  static final TextEditingController birthdateController =
      TextEditingController();
  static final TextEditingController dietController = TextEditingController();
  static final List<TextEditingController> platControllers =
      List.generate(10, (index) => TextEditingController());
  static final TextEditingController heightController = TextEditingController();
  static final TextEditingController weightController = TextEditingController();
  static final TextEditingController subscriptionTypeController =
      TextEditingController();
  static final TextEditingController notesController = TextEditingController();
  static final TextEditingController genderController = TextEditingController();

  // Disease Controllers
  static final TextEditingController hypertensionController =
      TextEditingController();
  static final TextEditingController hypotensionController =
      TextEditingController();
  static final TextEditingController vascularController =
      TextEditingController();
  static final TextEditingController anemiaController = TextEditingController();
  static final TextEditingController otherHeartController =
      TextEditingController();
  static final TextEditingController renalController = TextEditingController();
  static final TextEditingController liverController = TextEditingController();
  static final TextEditingController gitController = TextEditingController();
  static final TextEditingController colonController = TextEditingController();
  static final TextEditingController constipationController =
      TextEditingController();
  static final TextEditingController endocrineController =
      TextEditingController();
  static final TextEditingController rheumaticController =
      TextEditingController();
  static final TextEditingController allergiesController =
      TextEditingController();
  static final TextEditingController neuroController = TextEditingController();
  static final TextEditingController psychiatricController =
      TextEditingController();
  static final TextEditingController othersDiseaseController =
      TextEditingController();
  static final TextEditingController hormonalController =
      TextEditingController();
  static final TextEditingController familyHistoryDMController =
      TextEditingController();
  static final TextEditingController previousOBMedController =
      TextEditingController();
  static final TextEditingController previousOBOperationsController =
      TextEditingController();

  // Client Constant Info Controllers
  static final TextEditingController areaController = TextEditingController();
  static final TextEditingController activityLevelController =
      TextEditingController();
  static final TextEditingController yoyoController = TextEditingController();
  static final TextEditingController sportsController = TextEditingController();

  // Preferred Foods Controllers
  static final TextEditingController carbohydratesController =
      TextEditingController();
  static final TextEditingController proteinController =
      TextEditingController();
  static final TextEditingController dairyController = TextEditingController();
  static final TextEditingController vegController = TextEditingController();
  static final TextEditingController fruitsController = TextEditingController();
  static final TextEditingController othersPreferredFoodsController =
      TextEditingController();

  // Weight Areas Controllers
  static final TextEditingController abdomenController =
      TextEditingController();
  static final TextEditingController buttocksController =
      TextEditingController();
  static final TextEditingController waistController = TextEditingController();
  static final TextEditingController thighsController = TextEditingController();
  static final TextEditingController armsController = TextEditingController();
  static final TextEditingController breastController = TextEditingController();
  static final TextEditingController backController = TextEditingController();

  // Client Monthly Follow-Up Controllers
  static final TextEditingController bmiController = TextEditingController();
  static final TextEditingController pbfController = TextEditingController();
  static final TextEditingController waterController = TextEditingController();
  static final TextEditingController maxWeightController =
      TextEditingController();
  static final TextEditingController optimalWeightController =
      TextEditingController();
  static final TextEditingController bmrController = TextEditingController();
  static final TextEditingController maxCaloriesController =
      TextEditingController();
  static final TextEditingController dailyCaloriesController =
      TextEditingController();

  static void clearControllers() {
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
