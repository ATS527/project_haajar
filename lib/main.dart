import 'package:flutter/material.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:project_haajar/router.dart';
import 'package:project_haajar/screens/authentication/splash_screen.dart';
import 'package:project_haajar/utils/provider_debug.dart';

Future main() async {
  await dotenv.load(fileName: ".env");
  runApp(
    ProviderScope(
      observers: [
        MyObserver(),
      ],
      child: _EagerInitialisation(
        child: MaterialApp.router(
          routerConfig: CustomRouter.routerFunction(),
          theme: ThemeData(
            colorScheme: ColorScheme.fromSeed(
              seedColor: const Color.fromARGB(255, 69, 189, 157),
            ),
          ),
          debugShowCheckedModeBanner: false,
        ),
      ),
    ),
  );
}

class _EagerInitialisation extends ConsumerWidget {
  final Widget child;
  const _EagerInitialisation({required this.child});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    ref.watch(appwriteProvider);
    return child;
  }
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return const SplashScreen();
  }
}
