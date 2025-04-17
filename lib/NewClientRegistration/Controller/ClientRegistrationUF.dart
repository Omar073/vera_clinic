import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/View/SnackBars/RequiredFieldSnackBar.dart';
import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/View/SnackBars/InvalidDataTypeSnackBar.dart';
import 'ClientRegistrationTEC.dart';

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

