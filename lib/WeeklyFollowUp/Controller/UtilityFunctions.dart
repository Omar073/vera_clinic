import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitTEC.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import '../../Core/View/SnackBars/RequiredFieldSnackBar.dart';
import 'WeeklyFollowUpTEC.dart';

String getAge(DateTime? birthDate) {
  final now = DateTime.now();
  final age = now.year - birthDate!.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    return (age - 1).toString();
  }
  return age.toString();
}

Future<bool> createWeeklyFollowUp(Client c, BuildContext context) async {
  try {
    Visit v = Visit(
      visitId: "",
      clientId: c.mClientId,
      date: DateTime.now(),
      diet: WeeklyFollowUpTEC.visitDietController.text,
      weight: double.tryParse(WeeklyFollowUpTEC.visitWeightController.text) ?? 0,
      bmi: double.tryParse(WeeklyFollowUpTEC.visitBMIController.text) ?? 0,
      visitNotes: WeeklyFollowUpTEC.visitNotesController.text,
    );

    await context.read<VisitProvider>().createVisit(v);
    v.printVisit();
    return true;
  } catch (e) {
    debugPrint('Error creating visit: $e');
    return false;
  }
}

bool verifyWFUInput(BuildContext context) {
  bool isValid = true;
  if (WeeklyFollowUpTEC.visitWeightController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'الوزن');
    isValid = false;
  }
  return isValid;
}
