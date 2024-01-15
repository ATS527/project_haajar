import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/logs/realtime_logs.dart';
import 'package:project_haajar/router.dart';
import 'package:signals/signals_flutter.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  await auth.initialiseUser().then((value) {
    realtimeLogs.subscribeRealtime();
    if (auth.userPrefs.value["data"]["theme"] == "light") {
      auth.themeMode.value = ThemeMode.light;
    } else if (auth.userPrefs.value["data"]["theme"] == "dark") {
      auth.themeMode.value = ThemeMode.dark;
    } else {
      auth.themeMode.value = ThemeMode.system;
    }
  }).catchError((_) {});

  runApp(
    const MaterialApp(
      home: MyApp(),
      debugShowCheckedModeBanner: false,
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  ThemeData theme(Brightness brightness) {
    return ThemeData(
      colorScheme: ColorScheme.fromSeed(
        seedColor: Colors.teal,
        brightness: brightness,
      ),
      brightness: brightness,
      useMaterial3: true,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => MaterialApp.router(
        theme: theme(Brightness.light),
        darkTheme: theme(Brightness.dark),
        themeMode: auth.themeMode.value,
        routerConfig: CustomRouter.routerFunction(),
      ),
    );
  }
}
