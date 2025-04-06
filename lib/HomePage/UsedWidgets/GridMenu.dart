import 'dart:io';

import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/CheckedInClientsPage/CheckedInClientsPage.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';

import '../../AnalysisPage/AnalysisPage.dart';
import '../../ClientSearchPage/ClientSearchPage.dart';
import '../../Core/View/Pages/FollowUpNav.dart';
import '../../NewClientRegistration/View/NewClientPage.dart';
import '../HomePageUF.dart';
import 'menuCard.dart';

class GridMenu extends StatefulWidget {
  const GridMenu({super.key});

  @override
  State<GridMenu> createState() => _GridMenuState();
}

class _GridMenuState extends State<GridMenu> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      shrinkWrap: true,
      physics: const NeverScrollableScrollPhysics(),
      crossAxisCount: 3,
      mainAxisSpacing: 20,
      crossAxisSpacing: 20,
      childAspectRatio: 1.7,
      children: [
        menuCard(
            'بحث',
            Icons.search,
            Colors.red,
            () => Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (context) => ClientSearchPage(state: "search")))),
        menuCard(
          'تسجيل دخول',
          Icons.person,
          Colors.blue,
          () => Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => ClientSearchPage(state: "checkIn")),
          ),
        ),
        menuCard(
          'عميل جديد',
          Icons.person_add,
          Colors.green,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NewClientPage()),
          ),
        ),
        menuCard(
          'تسجيل خروج',
          Icons.exit_to_app,
          Colors.red,
          () async {
            await context.read<ClinicProvider>().dailyClear();
            if (isLastWednesdayOfMonth(DateTime.now())) {
              await context.read<ClinicProvider>().monthlyClear();
              await context.read<ExpenseProvider>().monthlyClearExpenses();
            }
            exit(0);
          },
        ),
        menuCard(
          'بيانات',
          Icons.analytics,
          Colors.orange,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnalysisPage()),
          ),
        ),
        menuCard('متابعة', Icons.calendar_today, Colors.purple, () {
          Navigator.push(
            context,
            MaterialPageRoute(
                builder: (context) => CheckedInClientsPage(
                    checkedInClients:
                        context.watch<ClinicProvider>().checkedInClients)),
          );
        }),
      ],
    );
  }
}
