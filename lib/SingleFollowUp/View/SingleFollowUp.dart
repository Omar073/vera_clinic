import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/my_app_bar.dart';
import 'package:vera_clinic/SingleFollowUp/View/UsedWidgets/SFUInfo1.dart';

import '../../Core/Model/Classes/Client.dart';
import '../Controller/SingleFollowUpTEC.dart';
import 'UsedWidgets/SFUActionButton.dart';
import 'UsedWidgets/SFUClientInfoCard.dart';
import 'UsedWidgets/SFUInfo2.dart';
import 'UsedWidgets/lastSFUInfo.dart';

class SingleFollowUp extends StatefulWidget {
  final Client client;
  const SingleFollowUp({super.key, required this.client});

  @override
  State<SingleFollowUp> createState() => _SingleFollowUpState();
}

class _SingleFollowUpState extends State<SingleFollowUp> {
  @override
  void initState() {
    super.initState();
    SingleFollowUpTEC.init();
  }

  @override
  void dispose() {
    SingleFollowUpTEC.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        title: '${widget.client.mName!} :متابعة منفردة',
      ),
      body: Background(
        child: Center(
            child: SingleChildScrollView(
          child: Column(
            children: [
              singleFollowUpClientInfoCard(widget.client),
              const SizedBox(height: 20),
              LastSingleFollowUpInfo(client: widget.client),
              const SizedBox(height: 20),
              singleFollowUpInfo1(),
              const SizedBox(height: 20),
              singleFollowUpInfo2(),
              const SizedBox(height: 30),
              SingleFollowUpActionButton(client: widget.client),
            ],
          ),
        )),
      ),
    );
  }
}
