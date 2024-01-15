import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
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

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  late StreamSubscription subscription;
  bool isDeviceConnected = false;
  bool isAlertSet = false;

  @override
  void initState() {
    getConnectivity();
    super.initState();
  }

  void getConnectivity() {
    subscription = Connectivity()
        .onConnectivityChanged
        .listen((ConnectivityResult result) async {
      isDeviceConnected = await InternetConnectionChecker().hasConnection;
      if (!isDeviceConnected && isAlertSet == false) {
        showDialogBox();
        setState(() {
          isAlertSet = true;
        });
      }
    });
  }

  @override
  void dispose() {
    subscription.cancel();
    super.dispose();
  }

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

  void showDialogBox() {
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("No Connection"),
          content: const Text("Please check your internet connection!"),
          actions: [
            TextButton(
              onPressed: () async {
                Navigator.pop(context, "Cancel");
                setState(() {
                  isAlertSet = false;
                });
                isDeviceConnected =
                    await InternetConnectionChecker().hasConnection;
                if (!isDeviceConnected) {
                  showDialogBox();
                  setState(() {
                    isAlertSet = true;
                  });
                }
              },
              child: const Text("Ok"),
            ),
          ],
        );
      },
    );
  }
}
