import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/VisitsDetailsPage/VisitsDetailsPage.dart';

import '../Core/Controller/Providers/ClientConstantInfoProvider.dart';
import '../Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import '../Core/Controller/Providers/PreferredFoodsProvider.dart';
import '../Core/Controller/Providers/WeightAreasProvider.dart';
import '../Core/Model/Classes/Disease.dart';
import '../Core/Model/Classes/PreferredFoods.dart';
import '../UpdateClientDetailsPage/UpdateClientDetailsPage.dart';
import 'InfoCards/weightDistributionCard.dart';
import 'InfoCards/weightHistoryCard.dart';
import 'InfoCards/dietPreferencesCard.dart';
import 'InfoCards/bodyMeasurementsCard.dart';
import 'InfoCards/medicalHistoryCard.dart';
import 'InfoCards/personalInfoCard.dart';

class ClientDetailsPage extends StatefulWidget {
  final Client? client;
  const ClientDetailsPage({super.key, required this.client});

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  late Future<void> _clientDetailsFuture;
  String? errorMessage;

  // Declare the missing variables
  Client? client;
  Disease? myDisease;
  ClientMonthlyFollowUp? myMonthlyFollowUp;
  ClientConstantInfo? myConstantInfo;
  WeightAreas? myWeightAreas;
  PreferredFoods? myPreferredFoods;

  @override
  void initState() {
    super.initState();
    _clientDetailsFuture = _loadClientDetails();
  }

  Future<void> _loadClientDetails() async {
    try {
      client = widget.client;

      myDisease = await context
          .read<DiseaseProvider>()
          .getDiseaseById(client?.mDiseaseId ?? '');

      myMonthlyFollowUp = await context
          .read<ClientMonthlyFollowUpProvider>()
          .getClientMonthlyFollowUpById(client?.mClientMonthlyFollowUpId ?? '');

      myConstantInfo = await context
          .read<ClientConstantInfoProvider>()
          .getClientConstantInfoById(client?.mClientConstantInfoId ?? '');

      myWeightAreas = await context
          .read<WeightAreasProvider>()
          .getWeightAreasById(client?.mWeightAreasId ?? '');

      myPreferredFoods = await context
          .read<PreferredFoodsProvider>()
          .getPreferredFoodsById(client?.mPreferredFoodsId ?? '');
    } on Exception catch (e) {
      errorMessage = 'حدث خطأ أثناء تحميل البيانات: $e';
      debugPrint('Error fetching client details: $e');
    }
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<void>(
      future: _clientDetailsFuture,
      builder: (context, snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Background(
              child: Center(
                child: CircularProgressIndicator(
                  color: Colors.blueAccent,
                ),
              ),
            ),
          );
        } else if (snapshot.hasError) {
          return const Scaffold(
            body: Background(
              child: Center(
                child: Text(
                  'حدث خطأ أثناء تحميل البيانات',
                  style: TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else if (errorMessage != null) {
          return Scaffold(
            body: Background(
              child: Center(
                child: Text(
                  errorMessage!,
                  style: const TextStyle(fontSize: 18, color: Colors.black),
                  textAlign: TextAlign.center,
                ),
              ),
            ),
          );
        } else {
          return _buildClientDetailsPage();
        }
      },
    );
  }

  Widget _buildClientDetailsPage() {
    return Scaffold(
      appBar: AppBar(
        title: const Text('معلومات العميل'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 208, 241, 255),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white,
                foregroundColor: Colors.blueAccent,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              onPressed: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => UpdateClientDetailsPage(
                      client: client!,
                      disease: myDisease!,
                      monthlyFollowUp: myMonthlyFollowUp!,
                      constantInfo: myConstantInfo!,
                      weightAreas: myWeightAreas!,
                      preferredFoods: myPreferredFoods!,
                      onUpdateFinished: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit, color: Colors.blueAccent),
              label: const Text(
                'تحديث',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Background(
        child: Center(
          child: Padding(
            padding:
                const EdgeInsets.symmetric(horizontal: 200.0).copyWith(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        personalInfoCard(client, myConstantInfo?.mArea ?? 'مجهول'),
                        const SizedBox(height: 20),
                        bodyMeasurementsCard(client, myMonthlyFollowUp!),
                        const SizedBox(height: 20),
                        dietPreferencesCard(client?.mDiet ?? 'مجهول',
                            myPreferredFoods!, myConstantInfo),
                        const SizedBox(height: 20),
                        weightHistoryCard(client),
                        const SizedBox(height: 20),
                        weightDistributionCard(myWeightAreas),
                        const SizedBox(height: 20),
                        medicalHistoryCard(myDisease),
                      ],
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.symmetric(vertical: 12.0),
                  child: ElevatedButton(
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.white,
                      foregroundColor: Colors.blueAccent,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) =>
                              VisitsDetailsPage(client: client!),
                        ),
                      );
                    },
                    child: const Text(
                      'عرض زيارات العميل',
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
