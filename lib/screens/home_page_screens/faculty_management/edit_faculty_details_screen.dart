import 'package:flutter/material.dart';

class EditFacultyDetailsScreen extends StatefulWidget {
  const EditFacultyDetailsScreen({super.key});

  @override
  State<EditFacultyDetailsScreen> createState() =>
      _EditFacultyDetailsScreenState();
}

class _EditFacultyDetailsScreenState extends State<EditFacultyDetailsScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Faculty Management Details"),
      ),
    );
  }
}
