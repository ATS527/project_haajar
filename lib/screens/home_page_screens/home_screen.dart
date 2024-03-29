import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/screens/home_page_screens/attendence_management/attendence_dashboard.dart';
import 'package:project_haajar/screens/home_page_screens/dashboard_screen.dart';
import 'package:project_haajar/screens/home_page_screens/faculty_management/faculty_management_screen.dart';
import 'package:project_haajar/screens/home_page_screens/settings_screen.dart';
import 'package:project_haajar/screens/home_page_screens/time_table_management/time_table_management_screen.dart';
import 'package:signals/signals_flutter.dart';

final drawerIndex = signal(0);

class HomeScreen extends StatelessWidget {
  HomeScreen({super.key});

  final List<Widget> drawableWidgets = [
    const DashboardScreen(),
    const FacultyManagementScreen(),
    const TimeTableManagementScreen(),
    const AttendenceDashboard(),
    const SettingsScreen(),
  ];

  final List<String> drawerTitles = [
    "Welcome ${auth.currentUserName.peek()}", //dashboard
    "Faculty Management",
    "Time Table Management",
    "Attendence Management",
    "Settings",
  ];

  @override
  Widget build(BuildContext context) {
    return Watch(
      (context) => Scaffold(
        appBar: AppBar(
          title: Text(drawerTitles.elementAt(drawerIndex.value)),
        ),
        drawer: Drawer(
          child: ListView(
            padding: EdgeInsets.zero,
            children: [
              DrawerHeader(
                decoration: BoxDecoration(
                  color: Theme.of(context).primaryColor,
                ),
                child: const Text('Project Haajar'),
              ),
              ListTile(
                title: const Text('Dashboard'),
                selected: drawerIndex.peek() == 0,
                onTap: () {
                  drawerIndex.value = 0;
                  context.pop();
                },
              ),
              ListTile(
                title: const Text('Faculty Management'),
                selected: drawerIndex.peek() == 1,
                onTap: () {
                  drawerIndex.value = 1;
                  context.pop();
                },
              ),
              ListTile(
                title: const Text('Time Table Management'),
                selected: drawerIndex.peek() == 2,
                onTap: () {
                  drawerIndex.value = 2;
                  context.pop();
                },
              ),
              ListTile(
                title: const Text('Attendence Management'),
                selected: drawerIndex.peek() == 3,
                onTap: () {
                  drawerIndex.value = 3;
                  context.pop();
                },
              ),
              ListTile(
                title: const Text('Settings'),
                selected: drawerIndex.peek() == 4,
                onTap: () {
                  drawerIndex.value = 4;
                  context.pop();
                },
              ),
            ],
          ),
        ),
        body: drawableWidgets.elementAt(drawerIndex.value),
      ),
    );
  }
}
