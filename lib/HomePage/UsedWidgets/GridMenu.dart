import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../Core/View/Pages/AnalysisPage.dart';
import '../../Core/View/Pages/ClientSearchPage.dart';
import '../../Core/View/Pages/FollowUpNav.dart';
import '../../NewClientRegistration/View/NewClientPage.dart';

class gridMenu extends StatefulWidget {
  const gridMenu({super.key});

  @override
  State<gridMenu> createState() => _gridMenuState();
}

class _gridMenuState extends State<gridMenu> {
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
                    builder: (context) =>
                        ClientSearchPage(state: "search")))),
        menuCard(
          'عميل سابق',
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
        const SizedBox(
          height: 10,
        ), // this is used to push the grid menu to the right
        menuCard(
          'تحليل',
          Icons.analytics,
          Colors.orange,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const AnalysisPage()),
          ),
        ),
        menuCard(
          'متابعة',
          Icons.calendar_today,
          Colors.purple,
          () => Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const FollowUpNav()),
          ),
        ),
      ],
    );
  }
}

Widget menuCard(String title, IconData icon, Color color, VoidCallback onTap) {
  return SizedBox(
    width: 50,
    height: 50,
    child: GestureDetector(
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
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                color: color.withOpacity(0.1),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 30),
            ),
            const SizedBox(height: 15),
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
    ),
  );
}
