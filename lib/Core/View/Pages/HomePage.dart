import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/View/Pages/ClientDetailsPage.dart';
import '../../../NewClientRegistration/View/NewClientPage.dart';
import '../../Model/Classes/Client.dart';
import '../Reusable widgets/MyNavigationButton.dart';
import 'AnalysisPage.dart';
import 'CheckInPage.dart';
import 'ClientSearchPage.dart';
import 'FollowUpNav.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  Client? c;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
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
                  MyNavigationButton(
                    mButtonText: "عميل جديد",
                    mButtonIcon: Icons.person_add,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const NewClientPage()));
                    },
                  ),
                  MyNavigationButton(
                    mButtonText: "عميل سابق",
                    mButtonIcon: Icons.person,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientSearchPage(
                                    state: "checkIn",
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               CheckInPage(client: c)));
                                    // },
                                    // client: c,
                                  )));
                    },
                  ),
                  MyNavigationButton(
                    mButtonText: "بحث",
                    mButtonIcon: Icons.search,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => ClientSearchPage(
                                    state: "search",
                                    // onTap: () {
                                    //   Navigator.push(
                                    //       context,
                                    //       MaterialPageRoute(
                                    //           builder: (context) =>
                                    //               ClientDetailsPage(client: c)));
                                    // },
                                    // client: c,
                                  )));
                    },
                  ),
                  MyNavigationButton(
                    mButtonText: "متابعة",
                    mButtonIcon: Icons.person_search,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const FollowUpNav()));
                    },
                  ),
                  MyNavigationButton(
                    mButtonText: "بيانات",
                    mButtonIcon: Icons.area_chart,
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const AnalysisPage()));
                    },
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
