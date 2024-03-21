import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/timetable_controller.dart';

class TimeTableManagementScreen extends StatefulWidget {
  const TimeTableManagementScreen({super.key});

  @override
  State<TimeTableManagementScreen> createState() =>
      _TimeTableManagementScreenState();
}

class _TimeTableManagementScreenState extends State<TimeTableManagementScreen> {
  bool fileSelected = false;
  File? selectedFile;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'TimeTable Management',
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
                FilePickerResult? result = await FilePicker.platform.pickFiles(
                  allowedExtensions: ["csv"],
                  type: FileType.custom,
                );

                if (result != null) {
                  selectedFile = File(
                    result.files.single.path!,
                  );
                  setState(() {
                    fileSelected = true;
                  });
                }
              },
              child: const Text("Import Time Table"),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              fileSelected
                  ? "Selected File: ${selectedFile!.path.split('/').last}"
                  : "No File Selected",
            ),
            const SizedBox(
              height: 25,
            ),
            fileSelected
                ? ElevatedButton(
                    onPressed: () {
                      setState(() {
                        fileSelected = false;
                        selectedFile = null;
                      });
                    },
                    child: const Text("Deselect Time Table"),
                  )
                : const SizedBox(),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                timeTableController.saveTimeTable(selectedFile);
              },
              child: const Text("Save Time Table"),
            ),
          ],
        ),
      ),
    );
  }
}
