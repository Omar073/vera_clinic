import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import 'package:vera_clinic/NewClientRegistration/Controller/UtilityFunctions.dart';

import '../../Controller/TextEditingControllers2.dart';

class CheckInButton extends StatefulWidget {
  final Client? client;
  final TextEditingController subscriptionPriceController;
  const CheckInButton(
      {super.key,
      required this.client,
      required this.subscriptionPriceController});

  @override
  State<CheckInButton> createState() => _CheckInButtonState();
}

class _CheckInButtonState extends State<CheckInButton> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: ElevatedButton(
        onPressed: () {
          widget.client?.subscriptionType =
              getSubscriptionType(visitSubscriptionTypeController.text);

          context.read<ClinicProvider>().addCheckedInClient(widget.client!);
          context.read<ClinicProvider>().incrementDailyPatients();
          context.read<ClinicProvider>().updateDailyIncome(
              double.parse(widget.subscriptionPriceController.text));

          Navigator.of(context).pushReplacement(
              MaterialPageRoute(builder: (context) => const HomePage()));

          visitSubscriptionTypeController.dispose();
          visitSubscriptionPriceController.dispose();
        },
        child: const Row(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(Icons.check, color: Colors.blueAccent),
            SizedBox(width: 12),
            Text('تسجيل الدخول',
                style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
          ],
        ),
      ),
    );
  }
}
