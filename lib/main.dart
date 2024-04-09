import 'dart:convert';

import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:haajar_final/configs/push_notification_config.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';
import 'package:haajar_final/firebase_options.dart';
import 'package:haajar_final/screens/admin_pages/home_screen.dart';
import 'package:haajar_final/screens/common_pages/sign_in_screen.dart';
import 'package:haajar_final/screens/student_pages/student_home_screen.dart';
import 'package:signals/signals_flutter.dart';

Future _firebaseBackgroundMessage(RemoteMessage message) async {}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
  ]);
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await dotenv.load(fileName: ".env");
  auth.listenToAuthChanges();
  await PushNotifications.init();
  PushNotifications.localNotiInit();
  await FirebaseMessaging.instance.getInitialMessage();
  FirebaseMessaging.onBackgroundMessage(_firebaseBackgroundMessage);
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    String payloadData = jsonEncode(message.data);
    if (message.notification != null) {
      PushNotifications.showSimpleNotification(
        title: message.notification!.title!,
        body: message.notification!.body!,
        payload: payloadData,
      );
    }
  });

  runApp(
    const MyApp(),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Haajar Final',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(
          seedColor: Colors.deepPurple,
        ),
        useMaterial3: true,
      ),
      home: const InitialiserScreen(),
    );
  }
}

class InitialiserScreen extends StatelessWidget {
  const InitialiserScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Watch((context) {
      if (auth.isLoggedIn.value) {
        if (auth.isAdmin.value) {
          return const HomeScreen();
        } else {
          return const StudentHomeScreen();
        }
      } else {
        return const SignInScreen();
      }
    });
  }
}
