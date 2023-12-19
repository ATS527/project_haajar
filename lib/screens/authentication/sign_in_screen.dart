import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/router.dart';

class SignInScreen extends StatefulWidget {
  const SignInScreen({super.key});

  @override
  State<SignInScreen> createState() => _SignInScreenState();
}

class _SignInScreenState extends State<SignInScreen> {
  final _formKey = GlobalKey<FormState>();

  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  void signIn() async {
    auth
        .login(
            email: _emailController.value.text,
            password: _passwordController.value.text)
        .then((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Signed In Successfully"),
          duration: Duration(seconds: 1),
        ),
      );
      context.go(AppRouteConstants.splashScreen);
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
        title: const Text(
          "Sign in Screen",
        ),
      ),
      body: Center(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Form(
              key: _formKey,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
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
                    height: 26,
                  ),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      ElevatedButton(
                        onPressed: () async {
                          if (_formKey.currentState!.validate()) {
                            signIn();
                          }
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Sign In",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                      const SizedBox(
                        width: 16,
                      ),
                      ElevatedButton(
                        onPressed: () async {
                          context.push(AppRouteConstants.forgotPasswordPrompt);
                        },
                        child: const Padding(
                          padding: EdgeInsets.all(12.0),
                          child: Text(
                            "Forgot Password",
                            style: TextStyle(fontSize: 15),
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(
                    height: 26,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      context.go(AppRouteConstants.signUpScreen);
                    },
                    child: const Padding(
                      padding: EdgeInsets.all(12.0),
                      child: Text("Sign Up Instead"),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
