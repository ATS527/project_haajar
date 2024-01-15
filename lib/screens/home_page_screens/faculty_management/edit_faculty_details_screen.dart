import 'package:flutter/material.dart';

class EditFacultyDetailsScreen extends StatefulWidget {
  const EditFacultyDetailsScreen(
      {super.key,
      required this.name,
      required this.facultyMail,
      required this.department,
      required this.subjects,
      required this.qualification,
      required this.experience});

  final String name;
  final String facultyMail;
  final String department;
  final List<String> subjects;
  final String qualification;
  final double experience;

  @override
  State<EditFacultyDetailsScreen> createState() =>
      _EditFacultyDetailsScreenState();
}

class _EditFacultyDetailsScreenState extends State<EditFacultyDetailsScreen> {
  @override
  void initState() {
    // TODO: implement initState
    print(widget.name);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty Management Details"),
      ),
    );
  }
}
