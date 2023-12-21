import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/screens/authentication/confirmation_mail_screen.dart';
import 'package:project_haajar/screens/authentication/forgot_password_prompt.dart';
import 'package:project_haajar/screens/authentication/forgot_password_screen.dart';
import 'package:project_haajar/screens/authentication/sign_in_screen.dart';
import 'package:project_haajar/screens/authentication/sign_up_screen.dart';
import 'package:project_haajar/screens/authentication/splash_screen.dart';
import 'package:project_haajar/screens/home_page_screens/dashboard_screen.dart';
import 'package:project_haajar/screens/home_page_screens/faculty_management/add_faculty_screen.dart';
import 'package:project_haajar/screens/home_page_screens/faculty_management/edit_faculty_details_screen.dart';
import 'package:project_haajar/screens/home_page_screens/faculty_management/faculty_management_screen.dart';
import 'package:project_haajar/screens/home_page_screens/home_screen.dart';
import 'package:project_haajar/screens/home_page_screens/settings_screen.dart';
import 'package:signals/signals_flutter.dart';

class CustomRouter {
  static GoRouter routerFunction() {
    return GoRouter(
      refreshListenable: auth.isLoggedIn.toValueListenable(),
      routes: <RouteBase>[
        GoRoute(
            path: '/',
            redirect: (context, state) {
              if (auth.currentUser.peek() == null) {
                return AppRouteConstants.signInScreen;
              }
              return null;
            },
            builder: (context, state) => const SplashScreen(),
            routes: [
              GoRoute(
                  path: 'home-screen',
                  builder: (context, state) => HomeScreen(),
                  routes: [
                    GoRoute(
                      path: 'dashboard',
                      builder: (context, state) => const DashboardScreen(),
                    ),
                    GoRoute(
                        path: 'faculty-management',
                        builder: (context, state) =>
                            const FacultyManagementScreen(),
                        routes: [
                          GoRoute(
                            path: 'add-faculty',
                            builder: (context, state) =>
                                const AddFacultyScreen(),
                          ),
                          GoRoute(
                            path: 'edit-faculty',
                            builder: (context, state) =>
                                const EditFacultyDetailsScreen(),
                          ),
                        ]),
                    GoRoute(
                      path: 'settings',
                      builder: (context, state) => const SettingsScreen(),
                    ),
                  ]),
            ]),
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
  static const String homeScreen = "/home-screen";
  static const String forgotPasswordPrompt = "/forgot-password-prompt";
  static const String confirmationMailScreen = "/confirmation-mail-screen";
  static const String dashboardScreen = "/home-screen/dashboard";
  static const String facultyManagementScreen =
      "/home-screen/faculty-management";
  static const String settingsScreen = "/home-screen/settings";
  static const String addFacultyScreen =
      "/home-screen/faculty-management/add-faculty";
  static const String editFacultyDetailsScreen =
      "/home-screen/faculty-management/edit-faculty";
}
