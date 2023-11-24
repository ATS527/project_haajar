import 'package:appwrite/appwrite.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:project_haajar/router.dart';

class SignUpScreen extends ConsumerStatefulWidget {
  const SignUpScreen({super.key});

  @override
  ConsumerState<SignUpScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends ConsumerState<SignUpScreen> {
  final _formKey = GlobalKey<FormState>();

  final _nameController = TextEditingController();
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  late Account account;

  @override
  void initState() {
    account = ref.read(appwriteProvider);
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    _nameController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          "Sign up Screen",
        ),
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
                    controller: _nameController,
                    decoration: const InputDecoration(
                      hintText: "Username",
                    ),
                    validator: (value) {
                      if (value!.isEmpty) {
                        return "Enter a valid name";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  TextFormField(
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
                      } else if (!value.contains("@ceattingal.ac.in")) {
                        return "Enter the correct College Email Address";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  TextFormField(
                    obscureText: true,
                    controller: _passwordController,
                    decoration: const InputDecoration(
                      hintText: "Password",
                    ),
                    validator: (value) {
                      if (value!.isEmpty || value.length < 8) {
                        return "Enter a valid password";
                      } else {
                        return null;
                      }
                    },
                  ),
                  const SizedBox(
                    height: 34,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                content: Text("Signing Up..."),
                                duration: Duration(seconds: 1),
                              ),
                            );

                            try {
                              account
                                  .create(
                                      userId: ID.unique(),
                                      email: _emailController.value.text,
                                      password: _passwordController.value.text)
                                  .then((value) {
                                account
                                    .createEmailSession(
                                        email: _emailController.value.text,
                                        password:
                                            _passwordController.value.text)
                                    .then((value) {
                                  account
                                      .createVerification(
                                          url:
                                              "https://haajar-app.govindsr.me/confirmation-mail-screen")
                                      .then((value) {
                                    showDialog(
                                        context: context,
                                        builder: (ctx) {
                                          return AlertDialog(
                                            title: const Text(
                                                "Verification Mail sent"),
                                            content: const Text(
                                              "Please verify your email by clicking the url in the mail from appwrite",
                                            ),
                                            actions: [
                                              ElevatedButton(
                                                onPressed: () {
                                                  context.pop();
                                                },
                                                child: const Text("Ok"),
                                              ),
                                            ],
                                          );
                                        });
                                  });
                                });
                              });
                            } catch (err) {
                              ScaffoldMessenger.of(context).showSnackBar(
                                SnackBar(
                                  content: Text(err.toString()),
                                ),
                              );
                            }
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Sign Up",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          context.go(AppRouteConstants.signInScreen);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12),
                          child: Text("Go Back to Sign in"),
                        ),
                      )
                    ],
                  ),
                  const SizedBox(
                    height: 24,
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
