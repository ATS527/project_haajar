import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/logs/realtime_logs.dart';
import 'package:project_haajar/router.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await auth.initialiseUser();
  realtimeLogs.subscribeRealtime();
  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: const Color.fromARGB(255, 142, 174, 165),
        ),
      ),
      routerConfig: CustomRouter.routerFunction(),
    );
  }
}
