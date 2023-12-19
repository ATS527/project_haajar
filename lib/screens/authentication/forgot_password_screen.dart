import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/router.dart';

class ForgotPasswordScreen extends StatefulWidget {
  const ForgotPasswordScreen(
      {super.key, required this.userId, required this.secret});

  final String userId;
  final String secret;

  @override
  State<StatefulWidget> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordController = TextEditingController();
  final _confirmPasswordController = TextEditingController();

  @override
  void dispose() {
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  void forgotPassword() async {
    auth
        .confirmPasswordRecovery(
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
                        forgotPassword();
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
