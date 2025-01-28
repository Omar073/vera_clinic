import 'package:flutter/cupertino.dart';

//Client:
final TextEditingController nameController = TextEditingController();
final TextEditingController phoneController = TextEditingController();
final TextEditingController birthdateController = TextEditingController();
final TextEditingController genderController = TextEditingController();
final TextEditingController dietController = TextEditingController();
final List<TextEditingController> platControllers =
    List.generate(10, (index) => TextEditingController());
final TextEditingController weightController = TextEditingController();
final TextEditingController heightController = TextEditingController();
final TextEditingController subscriptionTypeController =
    TextEditingController();
final TextEditingController notesController = TextEditingController();

//ClientConstantInfo:
final TextEditingController areaController = TextEditingController();
final TextEditingController activityLevelController = TextEditingController();
final TextEditingController yoyoController = TextEditingController();
final TextEditingController sportsController = TextEditingController();

// Disease
final TextEditingController hypertensionController = TextEditingController();
final TextEditingController hypotensionController = TextEditingController();
final TextEditingController vascularController = TextEditingController();
final TextEditingController anemiaController = TextEditingController();
final TextEditingController otherHeartController = TextEditingController();
final TextEditingController renalController = TextEditingController();
final TextEditingController liverController = TextEditingController();
final TextEditingController gitController = TextEditingController();
final TextEditingController colonController = TextEditingController();
final TextEditingController constipationController = TextEditingController();
final TextEditingController endocrineController = TextEditingController();
final TextEditingController rheumaticController = TextEditingController();
final TextEditingController allergiesController = TextEditingController();
final TextEditingController neuroController = TextEditingController();
final TextEditingController psychiatricController = TextEditingController();
final TextEditingController othersDiseaseController = TextEditingController();
final TextEditingController hormonalController = TextEditingController();
final TextEditingController familyHistoryDMController = TextEditingController();
final TextEditingController previousOBMedController = TextEditingController();
final TextEditingController previousOBOperationsController =
    TextEditingController();

// ClientMonthlyFollowUp:
final TextEditingController bmiController = TextEditingController();
final TextEditingController pbfController = TextEditingController();
final TextEditingController waterController = TextEditingController();
final TextEditingController maxWeightController = TextEditingController();
final TextEditingController optimalWeightController = TextEditingController();
final TextEditingController bmrController = TextEditingController();
final TextEditingController maxCaloriesController = TextEditingController();
final TextEditingController dailyCaloriesController = TextEditingController();

// Preferred foods
final TextEditingController carbohydratesController = TextEditingController();
final TextEditingController proteinController = TextEditingController();
final TextEditingController dairyController = TextEditingController();
final TextEditingController vegController = TextEditingController();
final TextEditingController fruitsController = TextEditingController();
final TextEditingController othersPreferredFoodsController =
    TextEditingController();

// WeightAreas
final TextEditingController abdomenController = TextEditingController();
final TextEditingController buttocksController = TextEditingController();
final TextEditingController waistController = TextEditingController();
final TextEditingController thighsController = TextEditingController();
final TextEditingController armsController = TextEditingController();
final TextEditingController breastController = TextEditingController();
final TextEditingController backController = TextEditingController();

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
