import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/Reusable%20widgets/BackGround.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';

import '../../../Core/Controller/UtilityFunctions.dart';
import '../../../Core/View/PopUps/MySnackBar.dart';

class CheckInButton extends StatefulWidget {
  final TextEditingController visitSubscriptionTypeController;
  final TextEditingController visitSubscriptionPriceController;
  final Client? client;

  const CheckInButton({
    super.key,
    required this.client,
    required this.visitSubscriptionTypeController,
    required this.visitSubscriptionPriceController,
  });

  @override
  State<CheckInButton> createState() => _CheckInButtonState();
}

class _CheckInButtonState extends State<CheckInButton> {
  bool _isLoading = false;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: _isLoading
          ? const Background(
              child: Center(
                  child: CircularProgressIndicator(
              color: Colors.blueAccent,
            )))
          : ElevatedButton(
              onPressed: () async {
                setState(() {
                  _isLoading = true;
                });

                try {
                  final double subscriptionPrice = double.parse(
                      widget.visitSubscriptionPriceController.text);

                  widget.client?.mSubscriptionType =
                      getSubscriptionTypeFromString(
                          widget.visitSubscriptionTypeController.text);

                  bool isAlreadyCheckedIn = await context
                      .read<ClinicProvider>()
                      .isClientCheckedIn(widget.client!.mClientId);
                  if (isAlreadyCheckedIn) {
                    showMySnackBar(context, 'العميل مسجل بالفعل', Colors.red);
                    return;
                  }

                  await context
                      .read<ClinicProvider>()
                      .checkInClient(widget.client!);
                  await context
                      .read<ClinicProvider>()
                      .incrementDailyPatients();
                  await context
                      .read<ClinicProvider>()
                      .updateDailyIncome(subscriptionPrice);
                  await context
                      .read<ClientProvider>()
                      .updateClient(widget.client!);

                  showMySnackBar(
                      context, 'تم تسجيل العميل بنجاح', Colors.green);
                  Navigator.of(context).pushReplacement(MaterialPageRoute(
                      builder: (context) => const HomePage()));
                } catch (e) {
                  if (mounted) {
                    showMySnackBar(
                        context, 'فشل تسجيل الدخول: ${e.toString()}', Colors.red);
                  }
                } finally {
                  if (mounted) {
                    setState(() {
                      _isLoading = false;
                    });
                  }
                }
              },
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.white, // Set background color to white
                padding: const EdgeInsets.symmetric(
                    horizontal: 24.0, vertical: 12.0),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              child: const Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  Icon(Icons.check, color: Colors.blueAccent),
                  SizedBox(width: 12),
                  Text('تسجيل دخول',
                      style: TextStyle(fontSize: 16, color: Colors.blueAccent)),
                ],
              ),
            ),
    );
  }
}
