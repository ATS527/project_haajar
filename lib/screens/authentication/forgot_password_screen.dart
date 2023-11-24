import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:project_haajar/router.dart';

class ForgotPasswordScreen extends ConsumerStatefulWidget {
  const ForgotPasswordScreen(
      {super.key, required this.userId, required this.secret});

  final String userId;
  final String secret;

  @override
  ConsumerState<ConsumerStatefulWidget> createState() =>
      _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends ConsumerState<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  late final Account account;
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void initState() {
    account = ref.read(appwriteProvider);
    super.initState();
  }

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password Screen"),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(16),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  TextFormField(
                    controller: _passwordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty && value.length >= 8) {
                        return "Enter the Password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  TextFormField(
                    controller: _confirmPasswordController,
                    obscureText: true,
                    decoration: const InputDecoration(
                      hintText: "Password Again",
                    ),
                    validator: (value) {
                      if (value!.isEmpty &&
                          value.length >= 8 &&
                          _passwordController.value.text == value) {
                        return "Enter the Password Again";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 50,
                  ),
                  ElevatedButton(
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        final account = ref.read(appwriteProvider);
                        await account
                            .updateRecovery(
                          userId: widget.userId,
                          secret: widget.secret,
                          password: _passwordController.value.text,
                          passwordAgain: _confirmPasswordController.value.text,
                        )
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Password Reset Successfully!"),
                            ),
                          );
                          context.go(AppRouteConstants.signInScreen);
                        }).catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(err.toString()),
                            ),
                          );
                        });
                      }
                    },
                    child: const Text("Reset Password"),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
