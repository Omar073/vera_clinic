import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/PreferredFoods.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/NewVisit/Controller/TextEditingControllers.dart';

import '../../Core/Controller/Providers/ClientConstantInfoProvider.dart';
import '../../Core/Controller/Providers/PreferredFoodsProvider.dart';
import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Controller/Providers/WeightAreasProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Disease.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../NewVisit/Controller/UtilityFunctions.dart';
import 'TextEditingControllers.dart';

bool isNumOnly(String value) {
  final num? numValue = num.tryParse(value);
  return numValue != null;
}

Future<bool> createClient() async {
  try {
    Client c = Client(
        clientId: '',
        name: nameController.text,
        clientPhoneNum:
            isNumOnly(phoneController.text) ? phoneController.text : '',
        birthdate: DateTime.tryParse(birthdateController.text),
        diet: dietController.text,
        plat:
            platControllers.map((e) => double.tryParse(e.text) ?? 0.0).toList(),
        height: double.tryParse(heightController.text) ?? 0.0,
        weight: double.tryParse(weightController.text) ?? 0.0,
        subscriptionType: getSubscriptionType(subscriptionTypeController.text),
        notes: notesController.text,
        gender: getGenderFromString(genderController.text),
        lastVisitId: '',
        clientConstantInfoId: '',
        diseaseId: '',
        clientMonthlyFollowUpId: '',
        preferredFoodsId: '',
        weightAreasId: '');

    ClientProvider clientProvider = ClientProvider();
    await clientProvider.createClient(c); // client ID is generated here

    c.clientConstantInfoId = await createClientConstantInfo(c.mClientId);
    c.diseaseId = await createDisease(c.mClientId) ?? '';
    c.clientMonthlyFollowUpId =
        await createClientMonthlyFollowUp(c.mClientId) ?? '';
    c.preferredFoodsId = await createPreferredFoods(c.mClientId) ?? '';
    c.weightAreasId = await createWeightAreas(c.mClientId) ?? '';

    if (clientVisits.isNotEmpty) {
      c.lastVisitId = getLatestVisitId();
      for (Visit v in clientVisits) {
        v.mClientId = c.mClientId;
        VisitProvider visitProvider = VisitProvider();
        visitProvider.updateVisit(v);
      }
    }
    // c.lastVisitId = getLatestVisitId() ?? '';

    // only after you add all extra IDs to the client object
    await clientProvider.updateClient(c); // Update the client with new IDs
    c.printClientInfo();
    return true;
  } catch (e) {
    debugPrint('Error creating client: $e');
    return false;
  }
}

Future<String?> createDisease(String clientId) async {
  try {
    Disease d = Disease(
      diseaseId: '',
      clientId: clientId,
      hypertension: hypertensionController.text.toLowerCase() == 'true',
      hypotension: hypotensionController.text.toLowerCase() == 'true',
      vascular: vascularController.text.toLowerCase() == 'true',
      anemia: anemiaController.text.toLowerCase() == 'true',
      otherHeart: otherHeartController.text,
      colon: colonController.text.toLowerCase() == 'true',
      constipation: constipationController.text.toLowerCase() == 'true',
      familyHistoryDM: familyHistoryDMController.text.toLowerCase() == 'true',
      previousOBMed: previousOBMedController.text.toLowerCase() == 'true',
      previousOBOperations:
          previousOBOperationsController.text.toLowerCase() == 'true',
      renal: renalController.text,
      liver: liverController.text,
      git: gitController.text,
      endocrine: endocrineController.text,
      rheumatic: rheumaticController.text,
      allergies: allergiesController.text,
      neuro: neuroController.text,
      psychiatric: psychiatricController.text,
      others: othersDiseaseController.text,
      hormonal: hormonalController.text,
    );

    DiseaseProvider diseaseProvider = DiseaseProvider();
    await diseaseProvider.createDisease(d);
    d.printDisease();

    return d.mDiseaseId;
  } catch (e) {
    debugPrint('Error creating disease: $e');
    return null;
  }
}

Future<String?> createClientMonthlyFollowUp(String clientId) async {
  try {
    ClientMonthlyFollowUp cmfu = ClientMonthlyFollowUp(
      clientId: clientId,
      clientMonthlyFollowUpId: '',
      bmi: double.tryParse(bmiController.text) ?? 0.0,
      pbf: double.tryParse(pbfController.text) ?? 0.0,
      water: double.tryParse(waterController.text) ?? 0.0,
      maxWeight: double.tryParse(maxWeightController.text) ?? 0.0,
      optimalWeight: double.tryParse(optimalWeightController.text) ?? 0.0,
      bmr: double.tryParse(bmrController.text) ?? 0.0,
      maxCalories: double.tryParse(maxCaloriesController.text) ?? 0.0,
      dailyCalories: double.tryParse(dailyCaloriesController.text) ?? 0.0,
    );

    ClientMonthlyFollowUpProvider clientMonthlyFollowUpProvider =
        ClientMonthlyFollowUpProvider();
    await clientMonthlyFollowUpProvider.createClientMonthlyFollowUp(cmfu);
    cmfu.printClientMonthlyFollowUp();

    return cmfu.mClientMonthlyFollowUpId;
  } catch (e) {
    debugPrint('Error creating client monthly follow-up: $e');
    return null;
  }
}

Future<String?> createClientConstantInfo(String clientId) async {
  try {
    ClientConstantInfo cci = ClientConstantInfo(
      clientId: clientId,
      clientConstantInfoId: '',
      area: areaController.text,
      activityLevel: getActivityLevelFromString(activityLevelController.text),
      YOYO: yoyoController.text.toLowerCase() == 'true',
      sports: sportsController.text.toLowerCase() == 'true',
    );

    ClientConstantInfoProvider clientConstantInfoProvider =
        ClientConstantInfoProvider();
    await clientConstantInfoProvider.createClientConstantInfo(cci);
    cci.printClientConstantInfo();

    return cci.mClientConstantInfoId;
  } catch (e) {
    debugPrint('Error creating client constant info: $e');
    return null;
  }
}

Future<String?> createPreferredFoods(String clientId) async {
  try {
    PreferredFoods pf = PreferredFoods(
      preferredFoodsId: '',
      clientId: clientId,
      carbohydrates: carbohydratesController.text.toLowerCase() == 'true',
      protein: proteinController.text.toLowerCase() == 'true',
      dairy: dairyController.text.toLowerCase() == 'true',
      veg: vegController.text.toLowerCase() == 'true',
      fruits: fruitsController.text.toLowerCase() == 'true',
      others: othersPreferredFoodsController.text,
    );

    PreferredFoodsProvider preferredFoodsProvider = PreferredFoodsProvider();
    await preferredFoodsProvider.createPreferredFoods(pf);
    pf.printPreferredFoods();

    return pf.mPreferredFoodsId;
  } catch (e) {
    debugPrint('Error creating preferred foods: $e');
    return null;
  }
}

Future<String?> createWeightAreas(String clientId) async {
  try {
    WeightAreas wa = WeightAreas(
      weightAreasId: '',
      clientId: clientId,
      abdomen: abdomenController.text.toLowerCase() == 'true',
      buttocks: buttocksController.text.toLowerCase() == 'true',
      waist: waistController.text.toLowerCase() == 'true',
      thighs: thighsController.text.toLowerCase() == 'true',
      arms: armsController.text.toLowerCase() == 'true',
      breast: breastController.text.toLowerCase() == 'true',
      back: backController.text.toLowerCase() == 'true',
    );

    WeightAreasProvider weightAreasProvider = WeightAreasProvider();
    await weightAreasProvider.createWeightAreas(wa);
    wa.printWeightAreas();

    return wa.mWeightAreasId;
  } catch (e) {
    debugPrint('Error creating weight areas: $e');
    return null;
  }
}

void disposeControllers() {
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
  colonController.dispose();
  constipationController.dispose();
  familyHistoryDMController.dispose();
  previousOBMedController.dispose();
  previousOBOperationsController.dispose();
  renalController.dispose();
  liverController.dispose();
  gitController.dispose();
  endocrineController.dispose();
  rheumaticController.dispose();
  allergiesController.dispose();
  neuroController.dispose();
  psychiatricController.dispose();
  othersDiseaseController.dispose();
  hormonalController.dispose();

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

void clearControllers() {
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

SubscriptionType? getSubscriptionType(String value) {
  switch (value) {
    case 'none':
      return SubscriptionType.none;
    case 'newClient':
      return SubscriptionType.newClient;
    case 'singleVisit':
      return SubscriptionType.singleVisit;
    case 'weeklyVisit':
      return SubscriptionType.weeklyVisit;
    case 'monthlyVisit':
      return SubscriptionType.monthlyVisit;
    case 'afterBreak':
      return SubscriptionType.afterBreak;
    case 'cavSess':
      return SubscriptionType.cavSess;
    case 'cavSess6':
      return SubscriptionType.cavSess6;
    case 'miso':
      return SubscriptionType.miso;
    case 'punctureSess':
      return SubscriptionType.punctureSess;
    case 'punctureSess6':
      return SubscriptionType.punctureSess6;
    case 'other':
      return SubscriptionType.other;
    default:
      return null;
  }
}

Gender getGenderFromString(String value) {
  switch (value) {
    case 'male':
      return Gender.male;
    case 'female':
      return Gender.female;
    case 'none':
      return Gender.none;
    default:
      return Gender.none;
  }
}

Activity getActivityLevelFromString(String value) {
  // switch (value) {
  //   case 'sedentary':
  //     return Activity.sedentary;
  //   case 'mid':
  //     return Activity.mid;
  //   case 'high':
  //     return Activity.high;
  //   case 'none':
  //     return Activity.none;
  //   default:
  //     return Activity.none;
  // }
  // create a map to get the first instance of enum that has same name as given value
  //Gender.values.firstWhere(
  //         (e) => e.name == data['Gender'],
  //         orElse: () => Gender.none,
  return Activity.values.firstWhere(
    //todo: verify functionality
    (e) => e.name == value,
    orElse: () => Activity.none,
  );
}

String getGenderLabel(Gender g) {
  switch (g) {
    case Gender.male:
      return 'ذكر';
    case Gender.female:
      return 'أنثي';
    case Gender.none:
      return '';
    default:
      return '';
  }
}

String getActivityLevelLabel(Activity a) {
  switch (a) {
    case Activity.sedentary:
      return 'ضعيف';
    case Activity.mid:
      return 'متوسط';
    case Activity.high:
      return 'عالي';
    case Activity.none:
      return '';
    default:
      return '';
  }
}
