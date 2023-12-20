import 'package:flutter/material.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/screens/authentication/sign_in_screen.dart';
import 'package:project_haajar/screens/home_page_screens/home_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: FutureBuilder(
        future: auth.getCurrentlyLoggedInUser(),
        builder: (ctx, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
          if (snapshot.hasData) {
            return  HomeScreen();
          }
          return const SignInScreen();
        },
      ),
    );
  }
}
