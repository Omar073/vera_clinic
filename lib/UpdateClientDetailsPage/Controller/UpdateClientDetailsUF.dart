import 'package:flutter/cupertino.dart';

import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/View/PopUps/InvalidDataTypeSnackBar.dart';
import '../../Core/View/PopUps/RequiredFieldSnackBar.dart';
import 'UpdateClientDetailsTEC.dart';

bool verifyRequiredFieldsU(BuildContext context) {
  bool isValid = true;
  if (UpdateClientDetailsTEC.phoneController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'رقم التليفون');
    isValid = false;
  }
  if (UpdateClientDetailsTEC.nameController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'الاسم');
    isValid = false;
  }
  return isValid;
}

bool verifyFieldsDataTypeU(BuildContext context) {
  bool isValid = true;

  final controllersWithMessages = [
    {
      'controller': UpdateClientDetailsTEC.birthYearController,
      'message': 'سنة الميلاد',
    },
    {
      'controller': UpdateClientDetailsTEC.heightController,
      'message': 'الطول',
    },
    {
      'controller': UpdateClientDetailsTEC.weightController,
      'message': 'الوزن',
    },
    {
      'controller': UpdateClientDetailsTEC.bmiController,
      'message': 'مؤشر كتلة الجسم',
    },
    {
      'controller': UpdateClientDetailsTEC.pbfController,
      'message': 'نسبة الدهون في الجسم',
    },
    {
      'controller': UpdateClientDetailsTEC.waterController,
      'message': 'نسبة الماء في الجسم',
    },
    {
      'controller': UpdateClientDetailsTEC.maxWeightController,
      'message': 'الوزن الأقصى',
    },
    {
      'controller': UpdateClientDetailsTEC.optimalWeightController,
      'message': 'الوزن المثالي',
    },
    {
      'controller': UpdateClientDetailsTEC.bmrController,
      'message': 'حد الحرق الأدنى',
    },
    {
      'controller': UpdateClientDetailsTEC.maxCaloriesController,
      'message': 'السعرات الحرارية القصوى',
    },
    {
      'controller': UpdateClientDetailsTEC.dailyCaloriesController,
      'message': 'السعرات الحرارية اليومية',
    },
  ];

  for (var item in controllersWithMessages) {
    if (!isNumOnly((item['controller'] as TextEditingController).text)) {
      showInvalidDataTypeSnackBar(context, item['message'] as String);
      isValid = false;
    }
  }

  for (var controller in UpdateClientDetailsTEC.platControllers) {
    if (!isNumOnly(controller.text)) {
      showInvalidDataTypeSnackBar(context, 'الوزن الثابت');
      isValid = false;
    }
  }

  if (validateYear(context, 'سنة الميلاد',
          UpdateClientDetailsTEC.birthYearController.text) ==
      false) {
    isValid = false;
  }

  return isValid;
}
