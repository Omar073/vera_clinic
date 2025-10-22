import 'package:flutter/cupertino.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';

import '../../Core/Controller/Providers/VisitProvider.dart';
import '../../Core/Controller/UtilityFunctions.dart';
import '../../Core/Model/Classes/Client.dart';
import '../../Core/Model/Classes/Visit.dart';
import 'UpdateVisitDetailsTEC.dart';

Future<bool> updateVisit(BuildContext context, Visit v) async {
  try {
    Client? client =
        await context.read<ClientProvider>().getClientById(v.mClientId ?? '');

    v.mDate =
        DateTime.tryParse(UpdateVisitDetailsTEC.visitDateController.text) ??
            DateTime.now();
    v.mDiet = UpdateVisitDetailsTEC.visitDietController.text;
    v.mWeight =
        double.tryParse(UpdateVisitDetailsTEC.visitWeightController.text) ??
            0.0;

    if (double.tryParse(UpdateVisitDetailsTEC.visitBMIController.text) !=
        null) {
      v.mBMI = normalizeBmi(double.parse(UpdateVisitDetailsTEC.visitBMIController.text));
    } else if (v.mWeight > 0 && client?.mHeight != null && client!.mHeight! > 0) {
      v.mBMI = normalizeBmi(v.mWeight / ((client.mHeight! / 100) * (client.mHeight! / 100)));
    } else {
      v.mBMI = 0.0;
    }

    v.mVisitNotes = UpdateVisitDetailsTEC.visitNotesController.text;

    await context.read<VisitProvider>().updateVisit(v);

    return true;
  } on Exception catch (e) {
    debugPrint("Error updating visit: $e");
    return false;
  }
}
