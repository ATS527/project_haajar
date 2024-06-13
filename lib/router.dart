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
import 'package:project_haajar/screens/home_page_screens/time_table_management/add_time_table_screen.dart';
import 'package:project_haajar/screens/home_page_screens/time_table_management/edit_time_table_screen.dart';
import 'package:project_haajar/screens/home_page_screens/time_table_management/time_table_management_screen.dart';

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
                        path: 'time-table-management',
                        builder: (context, state) =>
                            const TimeTableManagementScreen(),
                        routes: [
                          GoRoute(
                            path: 'edit-time-table-screen',
                            builder: (context, state) =>
                                const EditTimeTableScreen(),
                          ),
                          GoRoute(
                            path: 'add-time-table-screen',
                            builder: (context, state) => const AddTimeTableScreen(),
                          ),
                        ]),
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
                              builder: (context, state) {
                                final id = state.uri.queryParameters["id"];
                                final name = state.uri.queryParameters["name"];
                                final facultyMail =
                                    state.uri.queryParameters["faculty_mail"];
                                final department =
                                    state.uri.queryParameters["department"];
                                final subjects = state
                                    .uri.queryParameters["subjects"]
                                    ?.split(",");
                                final qualification =
                                    state.uri.queryParameters["qualification"];
                                final experience =
                                    state.uri.queryParameters["experience"] !=
                                            null
                                        ? double.parse(state
                                            .uri.queryParameters["experience"]!)
                                        : 0.0;

                                return EditFacultyDetailsScreen(
                                    name: name ?? "",
                                    facultyMail: facultyMail ?? "",
                                    department: department ?? "",
                                    experience: experience,
                                    qualification: qualification ?? "",
                                    subjects: subjects ?? [],
                                    id: id ?? "");
                              }),
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

  static const String timeTableManagementScreen =
      "/home-screen/time-table-management";

  static const String addTimeTableScreen =
      "/home-screen/time-table-management/add-time-table-screen";

  static const String editTimeTableScreen =
      "/home-screen/time-table-management/edit-time-table-screen";
}
