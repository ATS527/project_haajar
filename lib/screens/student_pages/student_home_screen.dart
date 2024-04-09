import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';
import 'package:haajar_final/screens/student_pages/announcement_student_screen.dart';
import 'package:haajar_final/screens/student_pages/attendence_student_screen.dart';
import 'package:haajar_final/screens/student_pages/time_table_student_screen.dart';

class StudentHomeScreen extends StatefulWidget {
  const StudentHomeScreen({super.key});

  @override
  State<StudentHomeScreen> createState() => _StudentHomeScreenState();
}

class _StudentHomeScreenState extends State<StudentHomeScreen> {
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
            onPressed: () {
              auth.signOut().then((value) {});
            },
            icon: const Icon(Icons.logout),
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
                  return const AttendenceStudentScreen();
                }));
              },
              child: const Text("Attendence Screen"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const TimeTableStudentScreen();
                }));
              },
              child: const Text("Time Table Screen"),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) {
                  return const AnnouncementStudentScreen();
                }));
              },
              child: const Text("Announcement Screen"),
            ),
          ],
        ),
      ),
    );
  }
}
