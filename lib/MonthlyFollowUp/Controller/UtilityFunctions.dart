import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';

import '../../Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import 'MonthlyFollowUpTEC.dart';

Future<void> createMonthlyFollowUp(Client c, BuildContext context) async {
  try {
    ClientMonthlyFollowUp cmfu = ClientMonthlyFollowUp(
        clientMonthlyFollowUpId: '',
        clientId: c.mClientId,
        bmi: double.tryParse(MonthlyFollowUpTEC.mBMIController.text),
        pbf: double.tryParse(MonthlyFollowUpTEC.mPBFController.text),
        water: double.tryParse(MonthlyFollowUpTEC.mWaterController.text),
        maxWeight:
            double.tryParse(MonthlyFollowUpTEC.mMaxWeightController.text),
        optimalWeight:
            double.tryParse(MonthlyFollowUpTEC.mOptimalWeightController.text),
        bmr: double.tryParse(MonthlyFollowUpTEC.mBMRController.text),
        maxCalories:
            double.tryParse(MonthlyFollowUpTEC.mMaxCaloriesController.text),
        dailyCalories:
            double.tryParse(MonthlyFollowUpTEC.mDailyCaloriesController.text));

    await context
        .read<ClientMonthlyFollowUpProvider>()
        .createClientMonthlyFollowUp(cmfu);
    cmfu.printClientMonthlyFollowUp();
  } on Exception catch (e) {
    debugPrint('Error creating monthly follow up: $e');
  }
}
