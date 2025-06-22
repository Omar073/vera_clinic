import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/HomePage/UsedWidgets/WelcomeSection.dart';

import '../Core/View/Reusable widgets/BackGround.dart';
import '../Shorebird/update_service.dart';
import 'UsedWidgets/GridMenu.dart';
import 'UsedWidgets/Header.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _updateService = UpdateService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateService.checkForUpdates(context);
    });
    _loadClinicData();
    context.read<ClinicProvider>().syncDailyClientsWithCheckedIn();
  }

  Future<void> _loadClinicData() async {
    await context.read<ClinicProvider>().getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Background(
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
                        const GridMenu(),
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
