import 'package:flutter/material.dart';
import 'package:vera_clinic/NewClientRegistration/Controller/UtilityFunctions.dart';
import 'package:vera_clinic/NewClientRegistration/View/InfoSections/weightDistributionCard.dart';
import 'package:vera_clinic/NewVisit/View/NewVisit.dart';
import '../../Core/View/Reusable widgets/MyInputField.dart';
import '../Controller/NewClientRegistrationTEC.dart';
import 'InfoSections/PersonalInfoCard.dart';
import 'InfoSections/actionButtons.dart';
import 'InfoSections/bodyMeasurementsCard.dart';
import 'InfoSections/dietPreferencesCard.dart';
import 'InfoSections/medicalHistoryCard.dart';
import 'InfoSections/weightHistoryCard.dart';
import '../../Core/View/Reusable widgets/myCard.dart';
import 'UsedWidgets/MyCheckBox.dart';

class NewClientPage extends StatefulWidget {
  const NewClientPage({super.key});

  @override
  State<NewClientPage> createState() => _NewClientPageState();
}

class _NewClientPageState extends State<NewClientPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('تسجيل عميل جديد'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 208, 241, 255),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 24.0).copyWith(top: 24),
        child: Column(
          children: [
            const PersonalInfoCard(),
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
            const SizedBox(height: 20),
            const ActionButtons(),
          ],
        ),
      ),
    );
  }
}
