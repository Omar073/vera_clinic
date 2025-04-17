import 'package:flutter/cupertino.dart';

import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/View/SnackBars/InvalidDataTypeSnackBar.dart';
import '../../Core/View/SnackBars/RequiredFieldSnackBar.dart';
import 'UpdateClientDetailsPageTEC.dart';

bool verifyRequiredFieldsU(BuildContext context) {
  bool isValid = true;
  if (UpdateClientDetailsPageTEC.phoneController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'رقم الهاتف');
    isValid = false;
  }
  if (UpdateClientDetailsPageTEC.nameController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'الاسم');
    isValid = false;
  }
  return isValid;
}

bool verifyFieldsDataTypeU(BuildContext context) {
  bool isValid = true;

  final controllersWithMessages = [
    {
      'controller': UpdateClientDetailsPageTEC.heightController,
      'message': 'الطول',
    },
    {
      'controller': UpdateClientDetailsPageTEC.weightController,
      'message': 'الوزن',
    },
    {
      'controller': UpdateClientDetailsPageTEC.bmiController,
      'message': 'مؤشر كتلة الجسم',
    },
    {
      'controller': UpdateClientDetailsPageTEC.pbfController,
      'message': 'نسبة الدهون في الجسم',
    },
    {
      'controller': UpdateClientDetailsPageTEC.waterController,
      'message': 'نسبة الماء في الجسم',
    },
    {
      'controller': UpdateClientDetailsPageTEC.maxWeightController,
      'message': 'الوزن الأقصى',
    },
    {
      'controller': UpdateClientDetailsPageTEC.optimalWeightController,
      'message': 'الوزن المثالي',
    },
    {
      'controller': UpdateClientDetailsPageTEC.bmrController,
      'message': 'حد الحرق الأدنى',
    },
    {
      'controller': UpdateClientDetailsPageTEC.maxCaloriesController,
      'message': 'السعرات الحرارية القصوى',
    },
    {
      'controller': UpdateClientDetailsPageTEC.dailyCaloriesController,
      'message': 'السعرات الحرارية اليومية',
    },
  ];

  for (var item in controllersWithMessages) {
    if (!isNumOnly((item['controller'] as TextEditingController).text)) {
      showInvalidDataTypeSnackBar(context, item['message'] as String);
      isValid = false;
    }
  }

  for (var controller in UpdateClientDetailsPageTEC.platControllers) {
    if (!isNumOnly(controller.text)) {
      showInvalidDataTypeSnackBar(context, 'الوزن الثابت');
      isValid = false;
    }
  }

  return isValid;
}
