import 'dart:io';

import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_haajar/models/timetable.dart';

class AddTimeTableScreen extends StatelessWidget {
  AddTimeTableScreen({super.key});

  List<TimeTable> timeTableList = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Time Table"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(height: 20),
                const Text(
                  "Add a Time Table File Here",
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const SizedBox(height: 30),
                SizedBox(
                  height: 50,
                  child: ElevatedButton.icon(
                    onPressed: () async {
                      FilePickerResult? result =
                          await FilePicker.platform.pickFiles(
                        type: FileType.custom,
                        allowedExtensions: ['csv'],
                      );

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        Future<String> futureContent = file.readAsString();
                        futureContent.then((csv) {
                          List<List<dynamic>> rowsAsListOfValues =
                              const CsvToListConverter(
                            eol: '\n',
                          ).convert(csv).toList();
                          rowsAsListOfValues.removeAt(0);
                          for (var row in rowsAsListOfValues) {
                            timeTableList.add(TimeTable.fromlist(row));
                          }
                          print(timeTableList[0]);
                        });
                      } else {
                        print("cancelled");
                      }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload csv file"),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
