import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/Disease.dart';
import 'package:vera_clinic/Core/Model/Classes/PreferredFoods.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/Controller/UpdateClientDetailsTEC.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/View/InfoSections/ActionButtonsU.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/View/InfoSections/dietPreferencesCardU.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/View/InfoSections/medicalHistoryCardU.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/View/InfoSections/personalInfoCardU.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/View/InfoSections/weightDistributionCardU.dart';
import 'package:vera_clinic/UpdateClientDetailsPage/View/InfoSections/weightHistoryCardU.dart';

import '../Core/View/Reusable widgets/BackGround.dart';
import '../Core/View/Reusable widgets/my_app_bar.dart';
import 'View/InfoSections/bodyMeasurementsCardU.dart';

class UpdateClientDetailsPage extends StatefulWidget {
  final Client? client;
  final Disease? disease;
  final ClientMonthlyFollowUp? monthlyFollowUp;
  final ClientConstantInfo? constantInfo;
  final WeightAreas? weightAreas;
  final PreferredFoods? preferredFoods;
  final VoidCallback onUpdateFinished;

  const UpdateClientDetailsPage(
      {super.key,
      required this.client,
      required this.disease,
      required this.monthlyFollowUp,
      required this.constantInfo,
      required this.weightAreas,
      required this.preferredFoods,
      required this.onUpdateFinished});

  @override
  State<UpdateClientDetailsPage> createState() =>
      _UpdateClientDetailsPageState();
}

class _UpdateClientDetailsPageState extends State<UpdateClientDetailsPage> {
  @override
  void initState() {
    super.initState();
    UpdateClientDetailsTEC.init(
        widget.client!,
        widget.disease!,
        widget.constantInfo!,
        widget.weightAreas!,
        widget.preferredFoods!,
        widget.monthlyFollowUp!);
  }

  @override
  void dispose() {
    UpdateClientDetailsTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: const MyAppBar(
        title: 'تحديث بيانات العميل',
      ),
      body: Background(
        child: Column(
          children: [
            const SizedBox(height: 12),
            Expanded(
              child: SingleChildScrollView(
                padding: const EdgeInsets.symmetric(horizontal: 24.0)
                    .copyWith(top: 12),
                child: Column(
                  children: [
                    personalInfoCardU(),
                    const SizedBox(height: 20),
                    bodyMeasurementsCardU(),
                    const SizedBox(height: 20),
                    dietPreferencesCardU(),
                    const SizedBox(height: 20),
                    weightHistoryCardU(),
                    const SizedBox(height: 20),
                    weightDistributionCardU(),
                    const SizedBox(height: 20),
                    medicalHistoryCardU(),
                  ],
                ),
              ),
            ),
            ActionButtonsU(
              client: widget.client,
              disease: widget.disease,
              monthlyFollowUp: widget.monthlyFollowUp,
              constantInfo: widget.constantInfo,
              weightAreas: widget.weightAreas,
              preferredFoods: widget.preferredFoods,
              onUpdateSuccess: () {
                widget.onUpdateFinished();
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}
