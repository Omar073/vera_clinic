import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Model/Classes/Visit.dart';
import 'UpdateVisitDetailsTEC.dart';

Future<bool> updateVisit(BuildContext context, Visit v) async {
  try {
    v.mDate =
        DateTime.tryParse(UpdateVisitDetailsTEC.visitDateController.text) ??
            DateTime.now();
    v.mDiet = UpdateVisitDetailsTEC.visitDietController.text;
    v.mWeight =
        double.tryParse(UpdateVisitDetailsTEC.visitWeightController.text) ??
            0.0;
    v.mBMI =
        double.tryParse(UpdateVisitDetailsTEC.visitBMIController.text) ?? 0.0;
    v.mVisitNotes = UpdateVisitDetailsTEC.visitNotesController.text;

    await context.read<VisitProvider>().updateVisit(v);

    return true;
  } on Exception catch (e) {
    debugPrint("Error updating visit: $e");
    return false;
  }
}
