import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:project_haajar/router.dart';

class ConfirmationMailScreen extends ConsumerWidget {
  const ConfirmationMailScreen(
      {super.key, required this.userId, required this.secret});

  final String userId;
  final String secret;

  Future<Token> verfiyMail(Account account) {
    return account.updateVerification(userId: userId, secret: secret);
  }

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final account = ref.read(appwriteProvider);
    return Scaffold(
      appBar: AppBar(
        title: const Text("Confirmation Mail Screen"),
      ),
      body: FutureBuilder(
        future: verfiyMail(account),
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
