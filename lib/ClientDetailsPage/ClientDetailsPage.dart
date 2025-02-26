import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/CheckInPage/View/CheckInPage.dart';
import 'package:vera_clinic/VisitsDetailsPage/VisitsDetailsPage.dart';
import '../../Core/View/Reusable widgets/myCard.dart';

import '../Core/Controller/Providers/ClientConstantInfoProvider.dart';
import '../Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import '../Core/Controller/Providers/PreferredFoodsProvider.dart';
import '../Core/Controller/Providers/WeightAreasProvider.dart';
import '../Core/Model/Classes/Disease.dart';
import '../Core/Model/Classes/PreferredFoods.dart';
import 'InfoCards/weightDistributionCard.dart';
import 'InfoCards/weightHistoryCard.dart';
import 'InfoCards/dietPreferencesCard.dart';
import 'InfoCards/bodyMeasurementsCard.dart';
import 'InfoCards/medicalHistoryCard.dart';
import 'InfoCards/infoRow.dart';
import 'InfoCards/personalInfoCard.dart';

class ClientDetailsPage extends StatefulWidget {
  final Client? client;
  const ClientDetailsPage({super.key, required this.client});

  @override
  State<ClientDetailsPage> createState() => _ClientDetailsPageState();
}

class _ClientDetailsPageState extends State<ClientDetailsPage> {
  Client? client;
  Disease? myDisease;
  ClientMonthlyFollowUp? myFollowUp;
  ClientConstantInfo? myConstantInfo;
  WeightAreas? myWeightAreas;
  PreferredFoods? myPreferredFoods;

  @override
  void initState() {
    super.initState();
    _loadClientDetails();
  }

  Future<void> _loadClientDetails() async {
    //todo: extract?
    client = widget.client;

    myDisease = await context
        .read<DiseaseProvider>()
        .getDiseaseById(client?.mDiseaseId ?? '');

    myFollowUp = await context
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

    debugPrint('Disease ID: ${myDisease?.mDiseaseId}');
    debugPrint(
        'Client Monthly Follow Up ID: ${myFollowUp?.mClientMonthlyFollowUpId}');
    debugPrint(
        'Client Constant Info ID: ${myConstantInfo?.mClientConstantInfoId}');
    debugPrint('Weight Areas ID: ${myWeightAreas?.mWeightAreasId}');
    debugPrint('Preferred Foods ID: ${myPreferredFoods?.mPreferredFoodsId}');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Client Details'),
        centerTitle: true,
        backgroundColor: const Color.fromARGB(255, 208, 241, 255),
      ),
      body: Center(
        child: FutureBuilder<void>(
          future: _loadClientDetails(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else if (snapshot.hasError) {
              return const Center(child: Text('Error loading client details'));
            } else {
              return Padding(
                padding: const EdgeInsets.symmetric(horizontal: 200.0)
                    .copyWith(top: 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Expanded(
                      child: SingleChildScrollView(
                        child: Column(
                          children: [
                            personalInfoCard(client, myConstantInfo!.mArea),
                            const SizedBox(height: 20),
                            bodyMeasurementsCard(client, myFollowUp!),
                            const SizedBox(height: 20),
                            dietPreferencesCard(client?.mDiet ?? '',
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
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      VisitsDetailsPage(client: client!)));
                        },
                        child: const Text(
                            'عرض زيارات العميل',
                          style: TextStyle(color: Colors.blueAccent),
                        ),
                      ),
                    ),
                    // const SizedBox(height: 20),
                  ],
                ),
              );
            }
          },
        ),
      ),
    );
  }
}
