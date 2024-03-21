import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';
import 'package:haajar_final/screens/attendence_management_screen.dart';
import 'package:haajar_final/screens/time_table_management_screen.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Project Haajar',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout),
            onPressed: () {
              auth.signOut();
            },
          ),
        ],
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AttendenceManagementScreen();
                }));
              },
              child: const Text("Attendence Management"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const TimeTableManagementScreen();
                }));
              },
              child: const Text("Time Table Management"),
            ),
          ],
        ),
      ),
    );
  }
}
