import 'package:go_router/go_router.dart';
import 'package:project_haajar/screens/authentication/confirmation_mail_screen.dart';
import 'package:project_haajar/screens/authentication/forgot_password_prompt.dart';
import 'package:project_haajar/screens/authentication/forgot_password_screen.dart';
import 'package:project_haajar/screens/authentication/sign_in_screen.dart';
import 'package:project_haajar/screens/authentication/sign_up_screen.dart';
import 'package:project_haajar/screens/authentication/splash_screen.dart';
import 'package:project_haajar/screens/bottom_navigation/bottom_navigation_bar.dart';

class CustomRouter {
  static GoRouter routerFunction() {
    return GoRouter(
      routes: [
        GoRoute(
          path: '/',
          builder: (context, state) => const SplashScreen(),
        ),
        GoRoute(
          path: '/forgot-password',
          builder: (context, state) => ForgotPasswordScreen(
            secret: state.uri.queryParameters['secret']!,
            userId: state.uri.queryParameters['userId']!,
          ),
        ),
        GoRoute(
          path: '/sign-in',
          builder: (context, state) => const SignInScreen(),
        ),
        GoRoute(
          path: '/sign-up',
          builder: (context, state) => const SignUpScreen(),
        ),
        GoRoute(
          path: '/bottom-navigation-bar',
          builder: (context, state) => const BottomNavigationBarCustom(),
        ),
        GoRoute(
          path: '/forgot-password-prompt',
          builder: (context, state) => const ForgotPasswordPrompt(),
        ),
        GoRoute(
          path: '/confirmation-mail-screen',
          builder: (context, state) => ConfirmationMailScreen(
            secret: state.uri.queryParameters['secret']!,
            userId: state.uri.queryParameters['userId']!,
          ),
        ),
      ],
    );
  }
}

class AppRouteConstants {
  static const String splashScreen = "/";
  static const String forgotPasswordScreen = "/forgot-password";
  static const String signInScreen = "/sign-in";
  static const String signUpScreen = "/sign-up";
  static const String bottomNavigationBar = "/bottom-navigation-bar";
  static const String forgotPasswordPrompt = "/forgot-password-prompt";
  static const String confirmationMailScreen = "/confirmation-mail-screen";
}
