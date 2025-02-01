import 'package:flutter/cupertino.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Visit.dart';
import 'package:vera_clinic/NewVisit/Controller/TextEditingControllers.dart';

Future<bool> createVisit() async {
  try {
    Visit v = Visit(
        visitId: '',
        clientId: '',
        date: DateTime.tryParse(visitDateController.text) ?? DateTime.now(),
        diet: visitDietController.text,
        weight: double.tryParse(visitWeightController.text) ?? 0.0,
        bmi: double.tryParse(visitBMIController.text) ?? 0.0,
        visitNotes: visitNotesController.text,
    );

    VisitProvider visitProvider = VisitProvider();
    await visitProvider.createVisit(v);

    clientVisits.add(v);
    return true;
  } on Exception catch (e) {
    debugPrint("Error creating visit: $e");
    return false;
  }
}

String? getLatestVisitId() {
  Visit latestVisit = clientVisits.last;
  if (clientVisits.isNotEmpty) {
    for (Visit v in clientVisits) {
      if (v.mDate.isAfter(latestVisit.mDate)) {
        latestVisit = v;
      }
    }
  }
  return latestVisit.mVisitId ?? '';
}

void disposeControllers() {
  visitDateController.dispose();
  visitDietController.dispose();
  visitWeightController.dispose();
  visitBMIController.dispose();
  visitNotesController.dispose();
}
