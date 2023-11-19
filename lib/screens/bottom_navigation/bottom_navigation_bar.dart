import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:project_haajar/screens/authentication/splash_screen.dart';
import 'package:project_haajar/screens/bottom_navigation/assignments_view.dart';
import 'package:project_haajar/screens/bottom_navigation/dashboard_view.dart';
import 'package:project_haajar/screens/bottom_navigation/notifications_view.dart';
import 'package:project_haajar/screens/bottom_navigation/settings_view.dart';

class BottomNavigationBarCustom extends ConsumerStatefulWidget {
  const BottomNavigationBarCustom({super.key});

  @override
  ConsumerState<BottomNavigationBarCustom> createState() =>
      _BottomNavigationBarCustomState();
}

class _BottomNavigationBarCustomState
    extends ConsumerState<BottomNavigationBarCustom> {
  int _selectedIndex = 0;

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
        return "Dashboard";
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.teal,
      appBar: AppBar(
        title: Text(
          titleView(_selectedIndex),
        ),
        foregroundColor: Colors.white,
        backgroundColor: Colors.black,
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () async {
              final account = ref.read(appwriteProvider);
              account.deleteSession(sessionId: "current").then((value) {
                Navigator.of(context).pushReplacement(
                  MaterialPageRoute(
                    builder: (ctx) => const SplashScreen(),
                  ),
                );
              });
            },
          ),
        ],
      ),
      body: bottomNavigationView(_selectedIndex),
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
