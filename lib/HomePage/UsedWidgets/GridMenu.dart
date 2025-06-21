import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/CheckedInClientsPage/CheckedInClientsPage.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';
import 'package:vera_clinic/DailyClientsPage/View/DailyClientsPage.dart';

import '../../AnalysisPage/AnalysisPage.dart';
import '../../ClientSearchPage/ClientSearchPage.dart';
import '../../Core/View/PopUps/MyAlertDialogue.dart';
import '../../NewClientRegistration/View/NewClientPage.dart';
import '../HomePageUF.dart';
import 'menuCard.dart';
import 'package:google_fonts/google_fonts.dart';

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
            Colors.teal,
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
        Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Expanded(
              flex: 2,
              child: _smallMenuCard(
                "قائمة عملاء اليوم",
                Icons.list,
                Colors.indigo,
                () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                        builder: (context) => const DailyClientsPage()),
                  );
                },
              ),
            ),
            const SizedBox(height: 10),
            Expanded(
              flex: 1,
              child: _smallHorizontalMenuCard(
                'خروج',
                Icons.exit_to_app,
                Colors.red,
                () {
                  showAlertDialogue(
                    context: context,
                    title: "تأكيد الخروج",
                    content: "هل تريد الخروج من البرنامج؟",
                    buttonText: "خروج",
                    returnText: "عودة",
                    onPressed: () async {
                      await context.read<ClinicProvider>().dailyClear();
                      if (isLastWednesdayOfMonth(DateTime.now())) {
                        await context.read<ClinicProvider>().monthlyClear();
                        await context
                            .read<ExpenseProvider>()
                            .monthlyClearExpenses();
                      }
                      exit(0);
                    },
                  );
                },
              ),
            ),
          ],
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

  Widget _smallHorizontalMenuCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 25),
            ),
            const SizedBox(width: 10),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _smallMenuCard(
      String title, IconData icon, Color color, VoidCallback onTap) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.1),
              spreadRadius: 2,
              blurRadius: 10,
            ),
          ],
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Container(
              padding: const EdgeInsets.all(8),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 25),
            ),
            const SizedBox(height: 5),
            Text(
              title,
              style: GoogleFonts.cairo(
                fontSize: 16,
                fontWeight: FontWeight.bold,
                color: Colors.grey[800],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
