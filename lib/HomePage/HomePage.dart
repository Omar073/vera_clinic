import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';
import 'package:shorebird_code_push/shorebird_code_push.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/HomePage/UsedWidgets/WelcomeSection.dart';

import '../Core/View/Reusable widgets/BackGround.dart';
import '../Core/View/Reusable widgets/my_app_bar.dart';
import '../Shorebird/update_service.dart';
import 'UsedWidgets/GridMenu.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  final _updateService = UpdateService();
  final ShorebirdUpdater _updater = ShorebirdUpdater();
  int? _patchVersion;

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateService.checkForUpdates(context);
    });
    _loadClinicData();
    _getPatchVersion();
    context.read<ClinicProvider>().syncDailyClientsWithCheckedIn();
  }

  Future<void> _getPatchVersion() async {
    try {
      final patch = await _updater.readCurrentPatch();
      setState(() {
        _patchVersion = patch?.number;
      });
    } catch (e) {
      // Handle error if any, e.g. no patch installed
      debugPrint('Error getting patch version: $e');
    }
  }

  Future<void> _loadClinicData() async {
    await context.read<ClinicProvider>().getClinic();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: MyAppBar(
        titleWidget: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              'Vera-Life Clinic',
              style: GoogleFonts.cairo(
                fontSize: 24,
                fontWeight: FontWeight.bold,
                color: Colors.blue[800],
              ),
            ),
            if (_patchVersion != null) ...[
              const SizedBox(width: 10),
              Text(
                'v$_patchVersion',
                style: GoogleFonts.cairo(
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  color: Colors.grey[600],
                ),
              ),
            ],
          ],
        ),
      ),
      body: Background(
        child: SafeArea(
          child: Column(
            children: [
              Expanded(
                child: SingleChildScrollView(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 40)
                        .copyWith(top: 15, bottom: 20),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.stretch,
                      children: [
                        welcomeSection(),
                        SizedBox(height: 20),
                        GridMenu(),
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
