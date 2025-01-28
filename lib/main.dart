import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientConstantInfoProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/ClientMonthlyFollowUpProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/DiseaseProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/PreferredFoodsProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/VisitProvider.dart';
import 'package:vera_clinic/Core/Controller/Providers/WeightAreasProvider.dart';
import 'package:vera_clinic/Core/View/Pages/HomePage.dart';
import 'Core/Controller/Providers/ClientProvider.dart';
import 'Core/Model/Firebase/firebase_options.dart';
import 'package:provider/provider.dart';


Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ClientProvider()),
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

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const MaterialApp(
      debugShowCheckedModeBanner: false,
      home: HomePage(),
    );
  }
}
