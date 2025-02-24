import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/PreferredFoods.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitTEC.dart';

import '../../Core/Controller/Providers/ClientConstantInfoProvider.dart';
import '../../Core/Controller/Providers/PreferredFoodsProvider.dart';
import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Controller/Providers/WeightAreasProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Disease.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../NewVisit/Controller/NewVisitUF.dart';
import 'ClientRegistrationTEC.dart';

bool isNumOnly(String value) {
  final num? numValue = num.tryParse(value);
  return numValue != null;
}

Future<bool> createClient(
    BuildContext context) async {
  try {
    Client c = Client(
        clientId: '',
        name: ClientRegistrationTEC.nameController.text,
        clientPhoneNum: isNumOnly(ClientRegistrationTEC.phoneController.text)
            ? ClientRegistrationTEC.phoneController.text
            : '',
        birthdate:
            DateTime.tryParse(ClientRegistrationTEC.birthdateController.text),
        diet: ClientRegistrationTEC.dietController.text,
        plat: ClientRegistrationTEC.platControllers
            .map((e) => double.tryParse(e.text) ?? 0.0)
            .toList(),
        height:
            double.tryParse(ClientRegistrationTEC.heightController.text) ?? 0.0,
        weight:
            double.tryParse(ClientRegistrationTEC.weightController.text) ?? 0.0,
        subscriptionType: getSubscriptionType(
            ClientRegistrationTEC.subscriptionTypeController.text),
        notes: ClientRegistrationTEC.notesController.text,
        gender:
            getGenderFromString(ClientRegistrationTEC.genderController.text),
        lastVisitId: '',
        clientConstantInfoId: '',
        diseaseId: '',
        clientMonthlyFollowUpId: '',
        preferredFoodsId: '',
        weightAreasId: '');

    await context
        .read<ClientProvider>()
        .createClient(c); // client ID is generated here

    c.clientConstantInfoId =
        await createClientConstantInfo(c.mClientId);
    c.diseaseId = await createDisease(c.mClientId) ?? '';
    c.clientMonthlyFollowUpId =
        await createClientMonthlyFollowUp(c.mClientId) ??
            '';
    c.preferredFoodsId =
        await createPreferredFoods(c.mClientId) ?? '';
    c.weightAreasId =
        await createWeightAreas(c.mClientId) ?? '';

    if (NewVisitTEC.clientVisits.isNotEmpty) {
      c.lastVisitId = getLatestVisitId();
      for (Visit v in NewVisitTEC.clientVisits) {
        v.mClientId = c.mClientId;
        VisitProvider visitProvider = VisitProvider();
        visitProvider.updateVisit(v);
      }
    }
    // c.lastVisitId = getLatestVisitId() ?? '';

    // only after you add all extra IDs to the client object
    await context
        .read<ClientProvider>()
        .updateClient(c); // Update the client with new IDs
    c.printClientInfo();
    return true;
  } catch (e) {
    debugPrint('Error creating client: $e');
    return false;
  }
}

Future<String?> createDisease(
    String clientId) async {
  try {
    Disease d = Disease(
      diseaseId: '',
      clientId: clientId,
      hypertension:
          ClientRegistrationTEC.hypertensionController.text.toLowerCase() ==
              'true',
      hypotension:
          ClientRegistrationTEC.hypotensionController.text.toLowerCase() ==
              'true',
      vascular:
          ClientRegistrationTEC.vascularController.text.toLowerCase() == 'true',
      anemia:
          ClientRegistrationTEC.anemiaController.text.toLowerCase() == 'true',
      otherHeart: ClientRegistrationTEC.otherHeartController.text,
      colon: ClientRegistrationTEC.colonController.text.toLowerCase() == 'true',
      constipation:
          ClientRegistrationTEC.constipationController.text.toLowerCase() ==
              'true',
      familyHistoryDM:
          ClientRegistrationTEC.familyHistoryDMController.text.toLowerCase() ==
              'true',
      previousOBMed:
          ClientRegistrationTEC.previousOBMedController.text.toLowerCase() ==
              'true',
      previousOBOperations: ClientRegistrationTEC
              .previousOBOperationsController.text
              .toLowerCase() ==
          'true',
      renal: ClientRegistrationTEC.renalController.text,
      liver: ClientRegistrationTEC.liverController.text,
      git: ClientRegistrationTEC.gitController.text,
      endocrine: ClientRegistrationTEC.endocrineController.text,
      rheumatic: ClientRegistrationTEC.rheumaticController.text,
      allergies: ClientRegistrationTEC.allergiesController.text,
      neuro: ClientRegistrationTEC.neuroController.text,
      psychiatric: ClientRegistrationTEC.psychiatricController.text,
      others: ClientRegistrationTEC.othersDiseaseController.text,
      hormonal: ClientRegistrationTEC.hormonalController.text,
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

Future<String?> createClientMonthlyFollowUp(
    String clientId) async {
  try {
    ClientMonthlyFollowUp cmfu = ClientMonthlyFollowUp(
      clientId: clientId,
      clientMonthlyFollowUpId: '',
      bmi: double.tryParse(ClientRegistrationTEC.bmiController.text) ?? 0.0,
      pbf: double.tryParse(ClientRegistrationTEC.pbfController.text) ?? 0.0,
      water: double.tryParse(ClientRegistrationTEC.waterController.text) ?? 0.0,
      maxWeight:
          double.tryParse(ClientRegistrationTEC.maxWeightController.text) ??
              0.0,
      optimalWeight:
          double.tryParse(ClientRegistrationTEC.optimalWeightController.text) ??
              0.0,
      bmr: double.tryParse(ClientRegistrationTEC.bmrController.text) ?? 0.0,
      maxCalories:
          double.tryParse(ClientRegistrationTEC.maxCaloriesController.text) ??
              0.0,
      dailyCalories:
          double.tryParse(ClientRegistrationTEC.dailyCaloriesController.text) ??
              0.0,
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

Future<String?> createClientConstantInfo(
    String clientId) async {
  try {
    ClientConstantInfo cci = ClientConstantInfo(
      clientId: clientId,
      clientConstantInfoId: '',
      area: ClientRegistrationTEC.areaController.text,
      activityLevel: getActivityLevelFromString(
          ClientRegistrationTEC.activityLevelController.text),
      YOYO: ClientRegistrationTEC.yoyoController.text.toLowerCase() == 'true',
      sports:
          ClientRegistrationTEC.sportsController.text.toLowerCase() == 'true',
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

Future<String?> createPreferredFoods(
    String clientId) async {
  try {
    PreferredFoods pf = PreferredFoods(
      preferredFoodsId: '',
      clientId: clientId,
      carbohydrates:
          ClientRegistrationTEC.carbohydratesController.text.toLowerCase() ==
              'true',
      protein:
          ClientRegistrationTEC.proteinController.text.toLowerCase() == 'true',
      dairy: ClientRegistrationTEC.dairyController.text.toLowerCase() == 'true',
      veg: ClientRegistrationTEC.vegController.text.toLowerCase() == 'true',
      fruits:
          ClientRegistrationTEC.fruitsController.text.toLowerCase() == 'true',
      others: ClientRegistrationTEC.othersPreferredFoodsController.text,
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

Future<String?> createWeightAreas(
    String clientId) async {
  try {
    WeightAreas wa = WeightAreas(
      weightAreasId: '',
      clientId: clientId,
      abdomen:
          ClientRegistrationTEC.abdomenController.text.toLowerCase() == 'true',
      buttocks:
          ClientRegistrationTEC.buttocksController.text.toLowerCase() == 'true',
      waist: ClientRegistrationTEC.waistController.text.toLowerCase() == 'true',
      thighs:
          ClientRegistrationTEC.thighsController.text.toLowerCase() == 'true',
      arms: ClientRegistrationTEC.armsController.text.toLowerCase() == 'true',
      breast:
          ClientRegistrationTEC.breastController.text.toLowerCase() == 'true',
      back: ClientRegistrationTEC.backController.text.toLowerCase() == 'true',
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
