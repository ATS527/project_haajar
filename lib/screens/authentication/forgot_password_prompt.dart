import 'package:flutter/material.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';

class ForgotPasswordPrompt extends StatefulWidget {
  const ForgotPasswordPrompt({super.key});

  @override
  State<ForgotPasswordPrompt> createState() => _ForgotPasswordPromptState();
}

class _ForgotPasswordPromptState extends State<ForgotPasswordPrompt> {
  final _emailController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    _emailController.dispose();
    super.dispose();
  }

  void forgotPasswordCreate() async {
    auth.createPasswordRecovery(email: _emailController.value.text).then(
      (value) {
        showDialog(
          context: context,
          builder: (ctx) {
            return AlertDialog(
              title: const Text("Success"),
              content: const Text("Check your email for the reset link"),
              actions: [
                TextButton(
                  onPressed: () {
                    Navigator.of(context).pop();
                  },
                  child: const Text("OK"),
                ),
              ],
            );
          },
        );
      },
    ).catchError((e) {
      showDialog(
        context: context,
        builder: (ctx) {
          return AlertDialog(
            title: const Text("Error"),
            content: const Text("Something went wrong"),
            actions: [
              TextButton(
                onPressed: () {
                  Navigator.of(context).pop();
                },
                child: const Text("OK"),
              )
            ],
          );
        },
      );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Forgot Password Prompt"),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: TextFormField(
                keyboardType: TextInputType.emailAddress,
                controller: _emailController,
                decoration: const InputDecoration(
                  hintText: "College Email",
                ),
                validator: (value) {
                  if (value!.isEmpty ||
                      !RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$')
                          .hasMatch(value)) {
                    return "Enter the correct Email Address";
                  } else {
                    return null;
                  }
                },
              ),
            ),
            const SizedBox(
              height: 50,
            ),
            ElevatedButton(
              onPressed: () {
                if (_formKey.currentState!.validate()) {
                  forgotPasswordCreate();
                }
              },
              child: const Padding(
                padding: EdgeInsets.all(16.0),
                child: Text("Submit Request"),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
