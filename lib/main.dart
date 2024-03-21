import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';
import 'package:haajar_final/firebase_options.dart';
import 'package:haajar_final/screens/home_screen.dart';
import 'package:haajar_final/screens/sign_in_screen.dart';
import 'package:signals/signals_flutter.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  auth.listenToAuthChanges();
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
        return const HomeScreen();
      } else {
        return const SignInScreen();
      }
    });
  }
}
