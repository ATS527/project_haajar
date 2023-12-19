import 'package:flutter/material.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';
import 'package:project_haajar/screens/bottom_navigation/assignments_view.dart';
import 'package:project_haajar/screens/bottom_navigation/dashboard_view.dart';
import 'package:project_haajar/screens/bottom_navigation/notifications_view.dart';
import 'package:project_haajar/screens/bottom_navigation/settings_view.dart';

class BottomNavigationBarCustom extends StatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  State<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState extends State<BottomNavigationBarCustom> {
  int _selectedIndex = 0;
  bool _isLoading = false;

  Widget bottomNavigationView(index) {
    switch (index) {
      case 0:
        return const DashboardView();
      case 1:
        return const NotificationsView();
      case 2:
        return const AssignmentsView();
      case 3:
        return const SettingsView();
      default:
        return const Center(
          child: CircularProgressIndicator(),
        );
    }
  }

  String titleView(index) {
    switch (index) {
      case 0:
        return "Welcome ${auth.currentUserName.value}";
      case 1:
        return "Notifications";
      case 2:
        return "Assignments";
      case 3:
        return "Settings";
      default:
        return "Unknown Screen";
    }
  }

  void logout() async {
    setState(() {
      _isLoading = true;
    });
    await auth.logoutUser().catchError((err) {
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
      backgroundColor: Theme.of(context).primaryColorLight,
      appBar: AppBar(
        title: Text(
          titleView(_selectedIndex),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              logout();
            },
          ),
        ],
      ),
      body: !_isLoading
          ? bottomNavigationView(_selectedIndex)
          : const Center(
              child: CircularProgressIndicator(),
            ),
      bottomNavigationBar: BottomNavigationBar(
        onTap: (index) {
          setState(() {
            _selectedIndex = index;
          });
        },
        currentIndex: _selectedIndex,
        items: const [
          BottomNavigationBarItem(
            icon: Icon(Icons.dashboard),
            label: "Dashboard",
            backgroundColor: Colors.black,
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.notification_important),
            label: "Notifications",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.assignment),
            label: "Assignments",
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.settings),
            label: "Settings",
          ),
        ],
      ),
    );
  }
}
