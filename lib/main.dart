import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:provider/provider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClinicProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ExpenseProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/PreferredFoodsProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/WeightAreasProvider.dart';
import 'package:vera_clinic/HomePage/HomePage.dart';
import 'package:vera_clinic/theme/app_theme.dart';
import 'package:vera_clinic/Shorebird/update_service.dart';
import 'package:window_manager/window_manager.dart';

import 'Core/Controller/Providers/ClientProvider.dart';
import 'firebase_setup/firebase_options.dart';

Future<void> main() async {
  //todo: check tips to Stay Within firebase daily quota limit
  //todo: add Firebase Crashlytics
  WidgetsFlutterBinding.ensureInitialized();

  await initializeDateFormatting('ar', null);
  await windowManager.ensureInitialized();
  await windowManager.setMinimumSize(const Size(800, 600));

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

  await UpdateService().initPatch();

  WindowOptions windowOptions = const WindowOptions(
    center: true,
    backgroundColor: Colors.transparent,
    skipTaskbar: false,
    titleBarStyle: TitleBarStyle.normal,
    // fullScreen: true,
  );
  windowManager.waitUntilReadyToShow(windowOptions, () async {
    await windowManager.show();

    // Adding a small delay to ensure the window is fully initialized before maximizing and focusing
    await Future.delayed(const Duration(milliseconds: 100));
    await windowManager.maximize();
    await windowManager.focus();
  });

  runApp(
    MultiProvider(
      //todo: only wrap each provider at the level it is needed
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider()),
        ChangeNotifierProvider(create: (_) => ClinicProvider()),
        ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ChangeNotifierProvider(create: (_) => ClientConstantInfoProvider()),
        ChangeNotifierProvider(create: (_) => ClientMonthlyFollowUpProvider()),
        ChangeNotifierProvider(create: (_) => DiseaseProvider()),
        ChangeNotifierProvider(create: (_) => PreferredFoodsProvider()),
        ChangeNotifierProvider(create: (_) => VisitProvider()),
        ChangeNotifierProvider(create: (_) => WeightAreasProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});
  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  final _updateService = UpdateService();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _updateService.checkForUpdates(context);
    });
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: AppTheme.themeData,
      debugShowCheckedModeBanner: false,
      home: const HomePage(),
    );
  }
}
