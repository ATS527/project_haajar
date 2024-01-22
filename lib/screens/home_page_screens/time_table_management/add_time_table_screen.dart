import 'dart:convert';
import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:project_haajar/widgets/text_input_widget.dart';
import 'package:xml2json/xml2json.dart';

class AddTimeTableScreen extends StatelessWidget {
  const AddTimeTableScreen({super.key});

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
                        allowedExtensions: ['xml'],
                      );

                      if (result != null) {
                        File file = File(result.files.single.path!);
                        Future<String> futureContent = file.readAsString();
                        futureContent.then((xml) {
                          final xml2json = Xml2Json();
                          xml2json.parse(xml);
                          final jsonString = xml2json.toParker();
                          final jsonObject = json.decode(jsonString);
                          
                        });
                      } else {
                        // User canceled the picker
                        print("cancelled");
                      }
                    },
                    icon: const Icon(Icons.upload_file),
                    label: const Text("Upload xml file"),
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
