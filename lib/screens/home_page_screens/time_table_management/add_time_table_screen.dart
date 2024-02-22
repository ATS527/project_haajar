import 'dart:io';
import 'package:csv/csv.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_haajar/controllers/timetable_controller.dart';
import 'package:project_haajar/models/timetable.dart';

class AddTimeTableScreen extends StatefulWidget {
  const AddTimeTableScreen({super.key});

  @override
  State<AddTimeTableScreen> createState() => _AddTimeTableScreenState();
}

class _AddTimeTableScreenState extends State<AddTimeTableScreen> {
  final List<TimeTable> timeTableList = [];

  bool isLoading = false;

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
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const SizedBox(height: 20),
              const Text(
                "Add a Time Table File Here",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 40),
              SizedBox(
                height: 50,
                child: !isLoading
                    ? ElevatedButton.icon(
                        onPressed: () async {
                          FilePickerResult? result =
                              await FilePicker.platform.pickFiles(
                            type: FileType.custom,
                            allowedExtensions: ['csv'],
                          );
                          if (result != null) {
                            File file = File(result.files.single.path!);
                            Future<String> futureContent = file.readAsString();
                            futureContent.then((csv) async {
                              List<List<dynamic>> rowsAsListOfValues =
                                  const CsvToListConverter(
                                eol: '\n',
                              ).convert(csv).toList();
                              rowsAsListOfValues.removeAt(0);
                              for (var row in rowsAsListOfValues) {
                                timeTableList.add(TimeTable.fromlist(row));
                              }
                              setState(() {
                                isLoading = true;
                              });
                              await timeTableManagement
                                  .createTimeTable(timeTableList)
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  const SnackBar(
                                    content:
                                        Text("Time Table Added Successfully"),
                                  ),
                                );
                              }).catchError((err) {
                                setState(() {
                                  isLoading = false;
                                });
                                ScaffoldMessenger.of(context).showSnackBar(
                                  SnackBar(
                                    content: Text(err.toString()),
                                  ),
                                );
                              });
                            });
                          } else {}
                        },
                        icon: const Icon(Icons.upload_file),
                        label: const Text("Upload csv file"),
                      )
                    : const CircularProgressIndicator(),
              ),
              const SizedBox(height: 30),
            ],
          ),
        ),
      ),
    );
  }
}
