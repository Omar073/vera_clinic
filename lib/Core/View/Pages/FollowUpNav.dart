import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/ClientDetailsPage/ClientDetailsPage.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Model/Classes/Client.dart';
import 'package:vera_clinic/Core/View/PopUps/MyAlertDialogue.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import 'package:vera_clinic/BiweeklyFollowUp/View/BiweeklyFollowUp.dart';

import '../../../SingleFollowUp/View/SingleFollowUp.dart';
import '../Reusable widgets/BackGround.dart';
import '../Reusable widgets/MyNavigationButton.dart';

class FollowUpNav extends StatefulWidget {
  final Client client;
  const FollowUpNav({super.key, required this.client});

  @override
  State<FollowUpNav> createState() => _FollowUpNavState();
}

class _FollowUpNavState extends State<FollowUpNav> {
  bool _isCheckingOut = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vera-Life Clinic'),
        centerTitle: true,
        backgroundColor: Colors.white,
        surfaceTintColor: Colors.white,
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                // backgroundColor: const Color.fromARGB(255, 208, 241, 255),
                backgroundColor: Colors.blueAccent,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(24.0),
                ),
              ),
              onPressed: () async {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) =>
                        ClientDetailsPage(client: widget.client),
                  ),
                );
              },
              child: const Text(
                'عرض بيانات العميل',
                style: TextStyle(fontSize: 16),
              ),
            ),
          ),
        ],
      ),
      body: Background(
        child: Center(
            child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Column(
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      MyNavigationButton(
                        mButtonText: "متابعة أسبوعين",
                        mButtonIcon: Icons.calendar_month_rounded,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      BiweeklyFollowUp(client: widget.client)));
                        },
                      ),
                      MyNavigationButton(
                        mButtonText: "متابعة منفردة",
                        mButtonIcon: Icons.calendar_today_rounded,
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) =>
                                      SingleFollowUp(client: widget.client)));
                        },
                      ),
                    ],
                  ),
                  const SizedBox(height: 80),
                  ElevatedButton(
                    onPressed: _isCheckingOut
                        ? null
                        : () async {
                            await showAlertDialogue(
                              context: context,
                              title: 'تأكيد تسجيل الخروج',
                              content:
                                  'هل أنت متأكد من تسجيل خروج العميل ${widget.client.mName}؟',
                              onPressed: () async {
                                if (mounted) {
                                  setState(() {
                                    _isCheckingOut = true;
                                  });
                                }
                                try {
                                  await context
                                      .read<ClinicProvider>()
                                      .checkOutClient(widget.client);
                                  if (mounted) {
                                    Navigator.pushReplacement(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const HomePage()));
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() {
                                      _isCheckingOut = false;
                                    });
                                  }
                                }
                              },
                            );
                          },
                    style: ElevatedButton.styleFrom(
                      backgroundColor:
                          _isCheckingOut ? Colors.grey : Colors.red,
                      padding: const EdgeInsets.symmetric(
                          horizontal: 24.0, vertical: 12.0),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(24.0),
                      ),
                    ),
                    child: Row(
                      mainAxisSize: MainAxisSize.min,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        if (_isCheckingOut) ...[
                          const SizedBox(
                            width: 20,
                            height: 20,
                            child: CircularProgressIndicator(
                              color: Colors.white,
                              strokeWidth: 2,
                            ),
                          ),
                          const SizedBox(width: 12),
                          const Text('جاري تسجيل الخروج...',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                        ] else
                          const Text('تسجيل خروج',
                              style:
                                  TextStyle(fontSize: 18, color: Colors.white)),
                      ],
                    ),
                  ),
                ],
              ),
            )
          ],
        )),
      ),
    );
  }
}
