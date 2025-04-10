import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/Core/View/SnackBars/MySnackBar.dart';
import 'package:vera_clinic/NewVisit/Controller/NewVisitTEC.dart';

import '../../Core/View/SnackBars/RequiredFieldSnackBar.dart';

Future<bool> createVisit(BuildContext context) async {
  try {
    Visit v = Visit(
      visitId: '',
      clientId: '',
      date: DateTime.tryParse(NewVisitTEC.visitDateController.text) ??
          DateTime.now(),
      diet: NewVisitTEC.visitDietController.text,
      weight: double.tryParse(NewVisitTEC.visitWeightController.text) ?? 0.0,
      bmi: double.tryParse(NewVisitTEC.visitBMIController.text) ?? 0.0,
      visitNotes: NewVisitTEC.visitNotesController.text,
    );

    await context.read<VisitProvider>().createVisit(v);

    NewVisitTEC.clientVisits.add(v);
    return true;
  } on Exception catch (e) {
    debugPrint("Error creating visit: $e");
    return false;
  }
}

bool verifyVisitInput(BuildContext context) {
  bool isValid = true;
  if (NewVisitTEC.visitWeightController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'الوزن');
    isValid = false;
  }
  if (NewVisitTEC.visitDateController.text.isEmpty) {
    showRequiredFieldSnackBar(context, 'تاريخ الزيارة');
    isValid = false;
  }
  return isValid;
}

String? getLatestVisitId() {
  //todo: optimize?
  Visit latestVisit = NewVisitTEC.clientVisits.last;
  if (NewVisitTEC.clientVisits.isNotEmpty) {
    for (Visit v in NewVisitTEC.clientVisits) {
      if (v.mDate.isAfter(latestVisit.mDate)) {
        latestVisit = v;
      }
    }
  }
  return latestVisit.mVisitId ?? '';
}
