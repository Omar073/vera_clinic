import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:vera_clinic/HomePage/UsedWidgets/WelcomeSection.dart';
import '../NewClientRegistration/View/NewClientPage.dart';
import '../Core/View/Pages/AnalysisPage.dart';
import '../Core/View/Pages/ClientSearchPage.dart';
import '../Core/View/Pages/FollowUpNav.dart';

import 'UsedWidgets/GridMenu.dart';
import 'UsedWidgets/Header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        decoration: BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [
              Colors.blue[50]!,
              Colors.white,
            ],
          ),
        ),
        child: SafeArea(
          child: Column(
            children: [
              customAppBar(),
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        welcomeSection(),
                        const SizedBox(height: 20),
                        const gridMenu(),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}