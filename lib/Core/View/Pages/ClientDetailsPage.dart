import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';
import 'package:vera_clinic/Core/View/Pages/CheckInPage.dart';
import 'package:vera_clinic/NewClientRegistration/View/UsedWidgets/MyCard.dart';

import '../../Controller/Providers/ClientConstantInfoProvider.dart';
import '../../Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import '../../Controller/Providers/PreferredFoodsProvider.dart';
import '../../Controller/Providers/WeightAreasProvider.dart';
import '../../Model/Classes/Disease.dart';
import '../../Model/Classes/PreferredFoods.dart';

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
        child: Container(
          constraints:
              const BoxConstraints(maxWidth: 800), // Scales for desktop
          padding: const EdgeInsets.all(16.0),
          child: FutureBuilder<void>(
            future: _loadClientDetails(),
            builder: (context, snapshot) {
              if (snapshot.connectionState == ConnectionState.waiting) {
                return const Center(child: CircularProgressIndicator());
              } else if (snapshot.hasError) {
                return const Center(
                    child: Text('Error loading client details'));
              } else {
                return SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        "Client Details",
                        style: TextStyle(
                            fontSize: 24, fontWeight: FontWeight.bold),
                      ),
                      const SizedBox(height: 16),
                      _buildPersonalInfoCard(client, myConstantInfo!.mArea),
                      const SizedBox(height: 20),
                      _buildBodyMeasurementsCard(client, myFollowUp!),
                      const SizedBox(height: 20),
                      _buildDietPreferencesCard(client?.mDiet ?? '',
                          myPreferredFoods!, myConstantInfo),
                      const SizedBox(height: 20),
                      _buildWeightHistoryCard(client),
                      const SizedBox(height: 20),
                      _buildWeightDistributionCard(myWeightAreas),
                      const SizedBox(height: 20),
                      _buildMedicalHistoryCard(myDisease),
                    ],
                  ),
                );
              }
            },
          ),
        ),
      ),
    );
  }

  Widget _buildPersonalInfoCard(Client? client, String area) {
    return myCard(
      'Personal Information',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Name', client?.mName ?? 'Unknown'),
          _buildInfoRow('Phone Number', client?.mClientPhoneNum ?? 'Unknown'),
          _buildInfoRow('Gender', client?.mGender.name ?? 'Unknown'),
          _buildInfoRow(
              'Birthdate',
              client?.mBirthdate?.toLocal().toString().split(' ')[0] ??
                  'Unknown'),
          _buildInfoRow('Area', area),
          _buildInfoRow(
              'Subscription Type',
              getSubscriptionTypeLabel(
                  client!.mSubscriptionType ?? SubscriptionType.none)),
        ],
      ),
    );
  }

  Widget _buildBodyMeasurementsCard(
      Client? client, ClientMonthlyFollowUp? monthlyFollowUp) {
    return myCard(
      'Body Measurements',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (monthlyFollowUp != null) ...[
            _buildInfoRow('Height', '${client?.mHeight ?? 0} cm'),
            _buildInfoRow('Weight', '${client?.mWeight ?? 0} kg'),
            _buildInfoRow('BMI', '${monthlyFollowUp.mBMI}'),
            _buildInfoRow('PBF', '${monthlyFollowUp.mPBF} %'),
            _buildInfoRow('Water', '${monthlyFollowUp.mWater}'),
            _buildInfoRow('Max Weight', '${monthlyFollowUp.mMaxWeight} kg'),
            _buildInfoRow(
                'Optimal Weight', '${monthlyFollowUp.mOptimalWeight} kg'),
            _buildInfoRow('BMR', '${monthlyFollowUp.mBMR}'),
            _buildInfoRow('Max Calories', '${monthlyFollowUp.mMaxCalories}'),
            _buildInfoRow(
                'Daily Calories', '${monthlyFollowUp.mDailyCalories}'),
          ] else ...[
            const Center(child: Text('No body measurements data available')),
          ]
        ],
      ),
    );
  }

  Widget _buildDietPreferencesCard(String diet, PreferredFoods? preferredFoods,
      ClientConstantInfo? clientConstantInfo) {
    return myCard(
      'Diet Preferences',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          _buildInfoRow('Diet', client?.mDiet ?? 'Unknown'),
          if (preferredFoods != null) ...[
            _buildInfoRow(
                'carbohydrates', preferredFoods.mCarbohydrates ? 'Yes' : 'No'),
            _buildInfoRow('Proteins', preferredFoods.mProtein ? 'Yes' : 'No'),
            _buildInfoRow('Dairy', preferredFoods.mDairy ? 'Yes' : 'No'),
            _buildInfoRow('Vegetables', preferredFoods.mVeg ? 'Yes' : 'No'),
            _buildInfoRow('Fruits', preferredFoods.mFruits ? 'Yes' : 'No'),
            _buildInfoRow('Other', preferredFoods.mOthers),
          ] else ...[
            const Center(child: Text('No preferred foods data available')),
          ],
          if (clientConstantInfo != null) ...[
            _buildInfoRow('Sports', clientConstantInfo.mSports ? 'Yes' : 'No'),
            _buildInfoRow(
                '(رجيم سابق) YOYO', clientConstantInfo.mYOYO ? 'Yes' : 'No'),
          ] else ...[
            const Center(child: Text('No client constant info available')),
          ]
        ],
      ),
    );
  }

  Widget _buildWeightHistoryCard(Client? client) {
    return myCard(
      'Weight History',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: List.generate(client?.Plat.length ?? 0, (index) {
          return _buildInfoRow(
              'Stable Weight ${index + 1}', '${client?.Plat[index] ?? 0} kg');
        }),
      ),
    );
  }

  Widget _buildWeightDistributionCard(WeightAreas? weightAreas) {
    return myCard(
      'Weight Distribution',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (weightAreas != null) ...[
            _buildInfoRow('Abdomen', weightAreas.mAbdomen ? 'Yes' : 'No'),
            _buildInfoRow('Buttocks', weightAreas.mButtocks ? 'Yes' : 'No'),
            _buildInfoRow('Waist', weightAreas.mWaist ? 'Yes' : 'No'),
            _buildInfoRow('Thighs', weightAreas.mThighs ? 'Yes' : 'No'),
            _buildInfoRow('Arms', weightAreas.mArms ? 'Yes' : 'No'),
            _buildInfoRow('Breast', weightAreas.mBreast ? 'Yes' : 'No'),
            _buildInfoRow('Back', weightAreas.mBack ? 'Yes' : 'No'),
          ] else ...[
            const Center(child: Text('No weight distribution data available')),
          ],
        ],
      ),
    );
  }

  Widget _buildMedicalHistoryCard(Disease? myDisease) {
    return myCard(
      'Medical History',
      Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          if (myDisease != null) ...[
            _buildInfoRow(
                'Hypertension', myDisease.mHypertension ? 'Yes' : 'No'),
            _buildInfoRow('Hypotension', myDisease.mHypotension ? 'Yes' : 'No'),
            _buildInfoRow('Vascular', myDisease.mVascular ? 'Yes' : 'No'),
            _buildInfoRow('Anemia', myDisease.mAnemia ? 'Yes' : 'No'),
            _buildInfoRow('Other Heart', myDisease.mOtherHeart),
            _buildInfoRow('Colon', myDisease.mColon ? 'Yes' : 'No'),
            _buildInfoRow(
                'Constipation', myDisease.mConstipation ? 'Yes' : 'No'),
            _buildInfoRow(
                'Family History DM', myDisease.mFamilyHistoryDM ? 'Yes' : 'No'),
            _buildInfoRow(
                'Previous OB Med', myDisease.mPreviousOBMed ? 'Yes' : 'No'),
            _buildInfoRow('Previous OB Operations',
                myDisease.mPreviousOBOperations ? 'Yes' : 'No'),
            _buildInfoRow('Renal', myDisease.mRenal),
            _buildInfoRow('Liver', myDisease.mLiver),
            _buildInfoRow('GIT', myDisease.mGit),
            _buildInfoRow('Endocrine', myDisease.mEndocrine),
            _buildInfoRow('Rheumatic', myDisease.mRheumatic),
            _buildInfoRow('Allergies', myDisease.mAllergies),
            _buildInfoRow('Neuro', myDisease.mNeuro),
            _buildInfoRow('Psychiatric', myDisease.mPsychiatric),
            _buildInfoRow('Others', myDisease.mOthers),
            _buildInfoRow('Hormonal', myDisease.mHormonal),
          ] else ...[
            const Center(child: Text('No medical history available')),
          ],
        ],
      ),
    );
  }

  Widget _buildInfoRow(String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 4.0),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            value,
            style: const TextStyle(fontSize: 16),
          ),
          Text(
            label,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
          ),
        ],
      ),
    );
  }
}
