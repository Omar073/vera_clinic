import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientConstantInfo.dart';
import 'package:vera_clinic/Core/Model/Classes/ClientMonthlyFollowUp.dart';
import 'package:vera_clinic/Core/Model/Classes/Disease.dart';
import 'package:vera_clinic/Core/Model/Classes/PreferredFoods.dart';
import 'package:vera_clinic/Core/Model/Classes/WeightAreas.dart';

class UpdateClientDetailsPage extends StatefulWidget {
  final Client? client;
  final Disease? disease;
  final ClientMonthlyFollowUp? followUp;
  final ClientConstantInfo? constantInfo;
  final WeightAreas? weightAreas;
  final PreferredFoods? preferredFoods;

  const UpdateClientDetailsPage(
      {super.key,
      required this.client,
      required this.disease,
      required this.followUp,
      required this.constantInfo,
      required this.weightAreas,
      required this.preferredFoods});

  @override
  State<UpdateClientDetailsPage> createState() =>
      _UpdateClientDetailsPageState();
}

class _UpdateClientDetailsPageState extends State<UpdateClientDetailsPage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold();
  }
}
