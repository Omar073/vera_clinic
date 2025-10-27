import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
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
  bool _initialized = false;

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
  }

  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    if (!_initialized) {
      _clientDetailsFuture = _loadClientDetails();
      _initialized = true;
    }
  }

  Future<void> _loadClientDetails() async {
    try {
      client = widget.client;
      
      if (client == null) {
        errorMessage = 'العميل غير موجود';
        return;
      }

      debugPrint('Loading client details for: ${client!.mName} (ID: ${client!.mClientId})');
      debugPrint('Disease ID: ${client!.mDiseaseId}');
      debugPrint('Monthly FollowUp ID: ${client!.mClientLastMonthlyFollowUpId}');
      debugPrint('Constant Info ID: ${client!.mClientConstantInfoId}');
      debugPrint('Weight Areas ID: ${client!.mWeightAreasId}');
      debugPrint('Preferred Foods ID: ${client!.mPreferredFoodsId}');

      // Load disease if ID is not empty
      if (client!.mDiseaseId != null && client!.mDiseaseId!.isNotEmpty) {
        try {
          myDisease = await context
              .read<DiseaseProvider>()
              .getDiseaseById(client!.mDiseaseId!);
          debugPrint('Disease loaded: ${myDisease != null ? "Success" : "Not found"}');
        } catch (e) {
          debugPrint('Error loading disease: $e');
        }
      }

      // Load monthly follow-up if ID is not empty
      if (client!.mClientLastMonthlyFollowUpId != null && client!.mClientLastMonthlyFollowUpId!.isNotEmpty) {
        try {
          myMonthlyFollowUp = await context
              .read<ClientMonthlyFollowUpProvider>()
              .getClientMonthlyFollowUpById(client!.mClientLastMonthlyFollowUpId!);
          debugPrint('Monthly FollowUp loaded by ID: ${myMonthlyFollowUp != null ? "Success" : "Not found"}');
        } catch (e) {
          debugPrint('Error loading monthly follow-up by ID: $e');
        }
      }
      
      // Fallback: If no monthly follow-up found by ID, try to get the latest one by client ID
      if (myMonthlyFollowUp == null) {
        try {
          myMonthlyFollowUp = await context
              .read<ClientMonthlyFollowUpProvider>()
              .getLatestClientMonthlyFollowUp(client!.mClientId);
          debugPrint('Monthly FollowUp loaded by client ID (fallback): ${myMonthlyFollowUp != null ? "Success" : "Not found"}');
        } catch (e) {
          debugPrint('Error loading latest monthly follow-up by client ID: $e');
        }
      }

      // Load constant info if ID is not empty
      if (client!.mClientConstantInfoId != null && client!.mClientConstantInfoId!.isNotEmpty) {
        try {
          myConstantInfo = await context
              .read<ClientConstantInfoProvider>()
              .getClientConstantInfoById(client!.mClientConstantInfoId!);
          debugPrint('Constant Info loaded: ${myConstantInfo != null ? "Success" : "Not found"}');
        } catch (e) {
          debugPrint('Error loading constant info: $e');
        }
      }

      // Load weight areas if ID is not empty
      if (client!.mWeightAreasId != null && client!.mWeightAreasId!.isNotEmpty) {
        try {
          myWeightAreas = await context
              .read<WeightAreasProvider>()
              .getWeightAreasById(client!.mWeightAreasId!);
          debugPrint('Weight Areas loaded: ${myWeightAreas != null ? "Success" : "Not found"}');
        } catch (e) {
          debugPrint('Error loading weight areas: $e');
        }
      }

      // Load preferred foods if ID is not empty
      if (client!.mPreferredFoodsId != null && client!.mPreferredFoodsId!.isNotEmpty) {
        try {
          myPreferredFoods = await context
              .read<PreferredFoodsProvider>()
              .getPreferredFoodsById(client!.mPreferredFoodsId!);
          debugPrint('Preferred Foods loaded: ${myPreferredFoods != null ? "Success" : "Not found"}');
        } catch (e) {
          debugPrint('Error loading preferred foods: $e');
        }
      }

      debugPrint('Client details loading completed successfully');
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
            appBar: MyAppBar(
              title: 'تفاصيل العميل',
            ),
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
            appBar: MyAppBar(
              title: 'تفاصيل العميل',
            ),
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
            appBar: const MyAppBar(
              title: 'تفاصيل العميل',
            ),
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
      appBar: MyAppBar(
        title: 'معلومات العميل',
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
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
                      disease: myDisease,
                      monthlyFollowUp: myMonthlyFollowUp,
                      constantInfo: myConstantInfo,
                      weightAreas: myWeightAreas,
                      preferredFoods: myPreferredFoods,
                      onUpdateFinished: () {
                        setState(() {});
                      },
                    ),
                  ),
                );
              },
              icon: const Icon(Icons.edit, color: Colors.white),
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
                const EdgeInsets.symmetric(horizontal: 140.0).copyWith(top: 12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                Expanded(
                  child: SingleChildScrollView(
                    child: Column(
                      children: [
                        personalInfoCard(
                            client, myConstantInfo?.mArea ?? 'مجهول'),
                        const SizedBox(height: 20),
                        bodyMeasurementsCard(context, client, myMonthlyFollowUp),
                        const SizedBox(height: 20),
                        dietPreferencesCard(client?.mDiet ?? 'مجهول',
                            myPreferredFoods, myConstantInfo),
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
                      backgroundColor: Colors.blueAccent,
                      foregroundColor: Colors.white,
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
