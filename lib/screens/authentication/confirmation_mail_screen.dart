import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/router.dart';

class ConfirmationMailScreen extends StatelessWidget {
  const ConfirmationMailScreen(
      {super.key, required this.userId, required this.secret});

  final String userId;
  final String secret;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation Mail Screen"),
      ),
      body: FutureBuilder(
        future: auth.verifyEmail(
              userId: userId,
              secret: secret,
            ),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.done) {
            if (snapshot.hasError) {
              return const Center(
                child: Text("Expired link. Go back!"),
              );
            } else {
              return Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(
                    Icons.verified,
                    size: 16,
                    color: Colors.green,
                  ),
                  const SizedBox(
                    height: 8,
                  ),
                  const Text(
                    "Email Verified",
                    style: TextStyle(
                      color: Colors.green,
                    ),
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go(AppRouteConstants.signInScreen);
                    },
                    child: const Text("Go to Login"),
                  ),
                ],
              );
            }
          } else {
            return const Center(
              child: CircularProgressIndicator(),
            );
          }
        },
      ),
    );
  }
}
