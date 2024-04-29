import 'package:flutter/material.dart';
import 'package:haajar_final/screens/admin_pages/attendence/attendence_listing_screen.dart';

class AttendenceManagementScreen extends StatefulWidget {
  const AttendenceManagementScreen({super.key});

  @override
  State<AttendenceManagementScreen> createState() =>
      _AttendenceManagementScreenState();
}

class _AttendenceManagementScreenState
    extends State<AttendenceManagementScreen> {
  bool isInitiatedAttendence = false;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Attendence Management',
          style: TextStyle(
            fontWeight: FontWeight.w900,
          ),
        ),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            ElevatedButton(
              onPressed: () async {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AttendenceListingScreen();
                }));
              },
              child: const Text(
                "Start Attendence",
              ),
            ),
            const SizedBox(
              height: 20,
            ),
          ],
        ),
      ),
    );
  }
}
