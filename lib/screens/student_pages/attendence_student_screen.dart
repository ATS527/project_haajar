import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/attendence_controller.dart';

class AttendenceStudentScreen extends StatefulWidget {
  const AttendenceStudentScreen({super.key});

  @override
  State<AttendenceStudentScreen> createState() =>
      _AttendenceStudentScreenState();
}

class _AttendenceStudentScreenState extends State<AttendenceStudentScreen> {
  @override
  void initState() {
    // TODO: implement initState
    attendenceController.init(context, "advertise");
    super.initState();
  }

  @override
  void dispose() {
    // TODO: implement dispose
    attendenceController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text(
            'Attendence',
            style: TextStyle(
              fontWeight: FontWeight.w900,
            ),
          ),
        ),
        body: const Center(
          child: Text("You have given attendence kindly wait in the screen"),
        ));
  }
}
