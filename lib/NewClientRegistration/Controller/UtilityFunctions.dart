import 'package:vera_clinic/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Model/Classes/PreferredFoods.dart';
import 'package:vera_clinic/Model/Classes/WeightAreas.dart';

import '../../Controller/Providers/ClientConstantInfoProvider.dart';
import '../../Controller/Providers/PreferredFoodsProvider.dart';
import '../../Controller/Providers/WeightAreasProvider.dart';
import '../../Model/Classes/Client.dart';
import '../../Model/Classes/Disease.dart';
import 'TextEditingControllers.dart';

bool isNumOnly(String value) {
  final num? numValue = num.tryParse(value);
  return numValue != null;
}

void createClient() {
  Client c = Client(
      clientId: '',
      name: nameController.text,
      clientPhoneNum:
          isNumOnly(phoneController.text) ? phoneController.text : '',
      birthdate: DateTime.tryParse(birthdateController.text),
      diet: dietController.text,
      plat: platControllers.map((e) => double.tryParse(e.text) ?? 0.0).toList(),
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
  clientProvider.createClient(c); // client ID is generated here

  c.clientConstantInfoId = createClientConstantInfo(c.mClientId) ?? '';
  c.diseaseId = createDisease(c.mClientId) ?? '';
  c.clientMonthlyFollowUpId = createClientMonthlyFollowUp(c.mClientId) ?? '';
  c.preferredFoodsId = createPreferredFoods(c.mClientId) ?? '';
  c.weightAreasId = createWeightAreas(c.mClientId) ?? '';

  // only after you add all IDs to the client object
  clientProvider.updateClient(c);
}

String? createDisease(String clientId) {
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
      hormonal: hormonalController.text);

  DiseaseProvider diseaseProvider = DiseaseProvider();
  diseaseProvider.createDisease(d);

  return d.mDiseaseId;
}

String? createClientMonthlyFollowUp(String clientId) {
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
  clientMonthlyFollowUpProvider.createClientMonthlyFollowUp(cmfu);

  return cmfu.mClientMonthlyFollowUpId;
}

String? createClientConstantInfo(String clientId) {
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

  clientConstantInfoProvider.createClientConstantInfo(cci);
  return cci.mClientConstantInfoId;
}

String? createPreferredFoods(String clientId) {
  PreferredFoods pf = PreferredFoods(
      preferredFoodsId: '',
      clientId: clientId,
      carbohydrates: carbohydratesController.text.toLowerCase() == 'true',
      protein: proteinController.text.toLowerCase() == 'true',
      dairy: dairyController.text.toLowerCase() == 'true',
      veg: vegController.text.toLowerCase() == 'true',
      fruits: fruitsController.text.toLowerCase() == 'true',
      others: othersPreferredFoodsController.text);

  PreferredFoodsProvider preferredFoodsProvider = PreferredFoodsProvider();
  preferredFoodsProvider.createPreferredFoods(pf);

  return pf.mPreferredFoodsId;
}

String? createWeightAreas(String clientId) {
  WeightAreas wa = WeightAreas(
      weightAreasId: '',
      clientId: clientId,
      abdomen: abdomenController.text.toLowerCase() == 'true',
      buttocks: buttocksController.text.toLowerCase() == 'true',
      waist: waistController.text.toLowerCase() == 'true',
      thighs: thighsController.text.toLowerCase() == 'true',
      arms: armsController.text.toLowerCase() == 'true',
      breast: breastController.text.toLowerCase() == 'true',
      back: backController.text.toLowerCase() == 'true');

  WeightAreasProvider weightAreasProvider = WeightAreasProvider();
  weightAreasProvider.createWeightAreas(wa);

  return wa.mWeightAreasId;
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
  switch (value) {
    case 'sedentary':
      return Activity.sedentary;
    case 'mid':
      return Activity.mid;
    case 'high':
      return Activity.high;
    case 'none':
      return Activity.none;
    default:
      return Activity.none;
  }
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