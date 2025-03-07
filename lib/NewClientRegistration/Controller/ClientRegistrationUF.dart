import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/View/SnackBars/RequiredFieldSnackBar.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/SnackBars/InvalidDataTypeSnackBar.dart';
import 'ClientRegistrationTEC.dart';

bool isNumOnly(String? value) {
  if (value == null || value.isEmpty || value == '') return true;
  return double.tryParse(value) != null;
}

bool verifyRequiredFields(BuildContext context) {
  bool isValid = true;
  if (ClientRegistrationTEC.phoneController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'رقم الهاتف');
    isValid = false;
  }
  if (ClientRegistrationTEC.nameController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'الاسم');
    isValid = false;
  }
  return isValid;
}

bool verifyFieldsDataType(BuildContext context) {
  bool isValid = true;

  final controllersWithMessages = [
    {
      'controller': ClientRegistrationTEC.heightController,
      'message': 'الطول',
    },
    {
      'controller': ClientRegistrationTEC.weightController,
      'message': 'الوزن',
    },
    {
      'controller': ClientRegistrationTEC.bmiController,
      'message': 'مؤشر كتلة الجسم',
    },
    {
      'controller': ClientRegistrationTEC.pbfController,
      'message': 'نسبة الدهون في الجسم',
    },
    {
      'controller': ClientRegistrationTEC.waterController,
      'message': 'نسبة الماء في الجسم',
    },
    {
      'controller': ClientRegistrationTEC.maxWeightController,
      'message': 'الوزن الأقصى',
    },
    {
      'controller': ClientRegistrationTEC.optimalWeightController,
      'message': 'الوزن المثالي',
    },
    {
      'controller': ClientRegistrationTEC.bmrController,
      'message': 'حد الحرق الأدنى',
    },
    {
      'controller': ClientRegistrationTEC.maxCaloriesController,
      'message': 'السعرات الحرارية القصوى',
    },
    {
      'controller': ClientRegistrationTEC.dailyCaloriesController,
      'message': 'السعرات الحرارية اليومية',
    },
  ];

  for (var item in controllersWithMessages) {
    if (!isNumOnly((item['controller'] as TextEditingController).text)) {
      showInvalidDataTypeSnackBar(context, item['message'] as String);
      isValid = false;
    }
  }

  for (var controller in ClientRegistrationTEC.platControllers) {
    if (!isNumOnly(controller.text)) {
      showInvalidDataTypeSnackBar(context, 'الوزن الثابت');
      isValid = false;
    }
  }

  return isValid;
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
