import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/announcement_controller.dart';
import 'package:haajar_final/models/announcement.dart';

class AddAnnouncementScreen extends StatefulWidget {
  const AddAnnouncementScreen({super.key});

  @override
  State<AddAnnouncementScreen> createState() => _AddAnnouncementScreenState();
}

class _AddAnnouncementScreenState extends State<AddAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  String? validator(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  bool fileSelected = false;
  bool isLoading = false;
  File? selectedFile;

  @override
  void initState() {
    _titleController = TextEditingController();
    _descriptionController = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _titleController.dispose();
    _descriptionController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Add Announcement'),
      ),
      body: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFormField(
                validator: validator,
                controller: _titleController,
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              TextFormField(
                controller: _descriptionController,
                validator: validator,
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
              ),
              const SizedBox(
                height: 10,
              ),
              fileSelected
                  ? Text(selectedFile!.path.split("/").last)
                  : const SizedBox(),
              ElevatedButton(
                onPressed: () async {
                  FilePickerResult? result =
                      await FilePicker.platform.pickFiles();

                  if (result != null) {
                    selectedFile = File(
                      result.files.single.path!,
                    );
                    setState(() {
                      fileSelected = true;
                    });
                  }
                },
                child: const Text('Select File'),
              ),
              const SizedBox(
                height: 20,
              ),
              ElevatedButton(
                onPressed: () async {
                  if (_formKey.currentState!.validate()) {
                    await announcementController
                        .addAnnouncement(
                      Announcement(
                        title: _titleController.value.text,
                        timestamp: DateTime.now(),
                        description: _descriptionController.value.text,
                        attachment: selectedFile?.path,
                      ),
                    )
                        .then((value) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(
                          content: Text('Announcement added successfully'),
                        ),
                      );
                    }).catchError((err) {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          content: Text(err.toString()),
                        ),
                      );
                    });
                  }
                },
                child: const Text('Submit'),
              ),
            ],
          )),
    );
  }
}
