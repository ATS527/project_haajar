import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/timetable_controller.dart';
import 'package:haajar_final/screens/admin_pages/timetable/time_table_display_screen.dart';

class TimeTableManagementScreen extends StatefulWidget {
  const TimeTableManagementScreen({super.key});

  @override
  State<TimeTableManagementScreen> createState() =>
      _TimeTableManagementScreenState();
}

class _TimeTableManagementScreenState extends State<TimeTableManagementScreen> {
  bool fileSelected = false;
  File? selectedFile;
  bool isLoading = false;
  bool isLoading2 = false;

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
            !isLoading
                ? Text(
                    fileSelected
                        ? "Selected File: ${selectedFile!.path.split('/').last}"
                        : "No File Selected",
                  )
                : const CircularProgressIndicator(),
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
                setState(() {
                  isLoading = true;
                });
                timeTableController.saveTimeTable(selectedFile).then((value) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text(
                        "Time Table Saved",
                      ),
                    ),
                  );
                }).catchError((err) {
                  setState(() {
                    isLoading = false;
                  });
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text(
                        err.toString(),
                      ),
                    ),
                  );
                });
              },
              child: const Text("Save Time Table"),
            ),
            const SizedBox(
              height: 25,
            ),
            ElevatedButton(
              onPressed: () {
                Navigator.of(context).push(MaterialPageRoute(
                  builder: (context) {
                    return const TimeTableDisplayScreen();
                  },
                )).then((value) {
                  setState(
                    () {},
                  );
                });
              },
              child: const Text("Get Time Table"),
            ),
            const SizedBox(
              height: 30,
            ),
            !isLoading2
                ? ElevatedButton(
                    onPressed: () async {
                      setState(() {
                        isLoading2 = true;
                      });
                      timeTableController.deleteAllTimeTable().then((value) {
                        setState(() {
                          isLoading2 = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          const SnackBar(
                            content: Text(
                              "Time Table Deleted",
                            ),
                          ),
                        );
                      }).catchError((err) {
                        setState(() {
                          isLoading2 = false;
                        });
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            content: Text(
                              err.toString(),
                            ),
                          ),
                        );
                      });
                    },
                    child: const Text("Delete All Time Table"),
                  )
                : const CircularProgressIndicator(),
          ],
        ),
      ),
    );
  }
}
