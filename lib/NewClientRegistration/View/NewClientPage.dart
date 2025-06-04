import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/NewClientRegistration/View/InfoSections/weightDistributionCard.dart';

import '../Controller/ClientRegistrationTEC.dart';
import 'InfoSections/action_buttons/action_buttons_widget.dart';
import 'InfoSections/bodyMeasurementsCard.dart';
import 'InfoSections/dietPreferencesCard.dart';
import 'InfoSections/medicalHistoryCard.dart';
import 'InfoSections/personalInfoCard.dart';
import 'InfoSections/weightHistoryCard.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  @override
  void initState() {
    super.initState();
    ClientRegistrationTEC.init();
  }

  @override
  void dispose() {
    ClientRegistrationTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل عميل جديد'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
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
                    personalInfoCard(),
                    const SizedBox(height: 20),
                    bodyMeasurementsCard(),
                    const SizedBox(height: 20),
                    dietPreferencesCard(),
                    const SizedBox(height: 20),
                    weightHistoryCard(),
                    const SizedBox(height: 20),
                    weightDistributionCard(),
                    const SizedBox(height: 20),
                    medicalHistoryCard(),
                  ],
                ),
              ),
            ),
            const ActionButtonsWidget(),
          ],
        ),
      ),
    );
  }
}
