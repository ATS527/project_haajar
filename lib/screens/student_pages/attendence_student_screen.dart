import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/attendence_controller.dart';
import 'package:haajar_final/controllers/authentication_controller.dart';

class AttendenceStudentScreen extends StatefulWidget {
  const AttendenceStudentScreen({super.key});

  @override
  State<AttendenceStudentScreen> createState() =>
      _AttendenceStudentScreenState();
}

class _AttendenceStudentScreenState extends State<AttendenceStudentScreen> {
  @override
  void dispose() {
    // TODO: implement dispose
    attendenceController.disposeAdvertiser();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Attendence Screen'),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () {
                attendenceController
                    .startAdvertising(
                  auth.currentlyLoggedInUser.value?.displayName,
                )
                    .then((value) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Attendence Given",
                      ),
                    ),
                  );
                }).catchError((err) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        err.toString(),
                      ),
                    ),
                  );
                });
              },
              child: const Text("Give Attendence"),
            ),
            const SizedBox(
              height: 20,
            ),
            const Text(
              "(Please do continue on this screen till the Faculty completes the attendence Process)",
              textAlign: TextAlign.center,
            )
          ],
        ),
      ),
    );
  }
}
