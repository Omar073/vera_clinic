import 'package:flutter/material.dart';
import '../Reusable widgets/MyNavigationButton.dart';
import 'AnalysisPage.dart';
import 'ClientSearchPage.dart';
import 'FollowUpNav.dart';
import 'NewClientPage.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Vera-Life Clinic'),
        centerTitle: true,
        backgroundColor: Colors.transparent,
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SingleChildScrollView(
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  MyNavigationButton(mButtonText: "عميل جديد", mButtonIcon: Icons.person_add, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const NewClientPage()));
                  },),
                  MyNavigationButton(mButtonText: "عميل سابق", mButtonIcon: Icons.person, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClientSearchPage(state: "checkIn",)));
                  },),
                  MyNavigationButton(mButtonText: "بحث", mButtonIcon: Icons.search, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => ClientSearchPage(state: "search",)));
                  },),
                  MyNavigationButton(mButtonText: "متابعة", mButtonIcon: Icons.person_search, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const FollowUpNav()));
                  },),
                  MyNavigationButton(mButtonText: "بيانات", mButtonIcon: Icons.area_chart, onTap: () {
                    Navigator.push(context, MaterialPageRoute(builder: (context) => const AnalysisPage()));
                  },),
                ],
              ),
            )
          ],
        )
      ),
    );
  }
}
