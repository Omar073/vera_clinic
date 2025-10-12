import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';

import 'UsedWidgets/app_bar.dart';
import 'UsedWidgets/check_out_button.dart';
import 'UsedWidgets/follow_up_buttons.dart';

class FollowUpNavPage extends StatelessWidget {
  final Client client;
  const FollowUpNavPage({super.key, required this.client});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: FollowUpNavAppBar(client: client),
      body: Background(
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              SingleChildScrollView(
                child: Column(
                  children: [
                    FollowUpButtons(client: client),
                    const SizedBox(height: 80),
                    CheckOutButton(client: client),
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}
