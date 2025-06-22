import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import 'SingleFollowUpTEC.dart';

String getAge(DateTime? birthDate) {
  if (birthDate == null) return 'مجهول';
  final now = DateTime.now();
  final age = now.year - birthDate.year;
  if (now.month < birthDate.month ||
      (now.month == birthDate.month && now.day < birthDate.day)) {
    return (age - 1).toString();
  }
  return age.toString();
}

Future<bool> createSingleFollowUp(Client c, BuildContext context) async {
  try {
    Visit v = Visit(
      visitId: "",
      clientId: c.mClientId,
      date: DateTime.now(),
      diet: SingleFollowUpTEC.singleFollowUpDietController.text,
      weight:
          double.tryParse(SingleFollowUpTEC.singleFollowUpWeightController.text) ?? 0,
      bmi: double.tryParse(SingleFollowUpTEC.singleFollowUpBMIController.text) ?? 0,
      visitNotes: SingleFollowUpTEC.singleFollowUpNotesController.text,
    );

    await context.read<VisitProvider>().createVisit(v);
    return true;
  } catch (e) {
    debugPrint('Error creating SingleFollowUp: $e');
    return false;
  }
}
