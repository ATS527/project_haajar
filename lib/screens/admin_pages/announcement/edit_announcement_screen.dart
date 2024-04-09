import 'dart:io';

import 'package:file_picker/file_picker.dart';
import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/announcement_controller.dart';
import 'package:haajar_final/models/announcement.dart';
import 'package:haajar_final/screens/admin_pages/announcement/pdf_viewer_screen.dart';

class EditAnnouncementScreen extends StatefulWidget {
  const EditAnnouncementScreen(
      {super.key, required this.announcement, required this.documentID});

  final Announcement announcement;
  final String documentID;

  @override
  State<EditAnnouncementScreen> createState() => _EditAnnouncementScreenState();
}

class _EditAnnouncementScreenState extends State<EditAnnouncementScreen> {
  final _formKey = GlobalKey<FormState>();

  bool fileSelected = false;
  bool isLoading = false;
  File? selectedFile;

  late TextEditingController _titleController;
  late TextEditingController _descriptionController;

  String? validator(value) {
    if (value == null || value.isEmpty) {
      return 'Please enter some text';
    }
    return null;
  }

  @override
  void initState() {
    _titleController = TextEditingController(text: widget.announcement.title);
    _descriptionController =
        TextEditingController(text: widget.announcement.description);

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
        title: const Text('Edit Announcement'),
      ),
      body: Form(
        key: _formKey,
        child: Column(
          children: [
            TextFormField(
              controller: _titleController,
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Enter the title',
              ),
            ),
            TextFormField(
              controller: _descriptionController,
              validator: validator,
              decoration: const InputDecoration(
                labelText: 'Enter the description',
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            ElevatedButton(
              onPressed: () async {
                if (widget.announcement.attachment != null) {
                  print("worked here");
                  await announcementController
                      .getAnnouncementAttachment(
                          widget.announcement.attachment!)
                      .then((value) {
                    Navigator.of(context)
                        .push(MaterialPageRoute(builder: (context) {
                      return PdfViewerScreen(pdfFile: value);
                    }));
                  }).catchError((err) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                          err.toString(),
                        ),
                      ),
                    );
                  });
                }
              },
              child: const Text("Open Attachment"),
            ),
            const SizedBox(
              height: 20,
            ),
            fileSelected
                ? Text("Attachment: ${selectedFile?.path.split('/').last}")
                : const Text("No Attachments Selected"),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      fileSelected = false;
                      selectedFile = null;
                    });
                  },
                  child: const Text("Remove Attachment"),
                ),
                const SizedBox(
                  width: 20,
                ),
                ElevatedButton(
                  child: const Text("Upload New Attachment"),
                  onPressed: () async {
                    FilePickerResult? result =
                        await FilePicker.platform.pickFiles(
                      allowedExtensions: ["pdf"],
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
                ),
              ],
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                if (_formKey.currentState!.validate()) {
                  // Save the announcement
                  isLoading = true;
                  await announcementController
                      .editAnnouncement(
                    documentID: widget.documentID,
                    title: _titleController.text,
                    fileId: widget.announcement.attachment,
                    description: _descriptionController.text,
                    attachment: selectedFile,
                  )
                      .then((value) {
                    isLoading = false;
                    ScaffoldMessenger.of(context).showSnackBar(
                      const SnackBar(
                        content: Text(
                          "Announcement Updated",
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
                }
              },
              child: isLoading
                  ? const Center(
                      child: CircularProgressIndicator(),
                    )
                  : const Text('Send Announcement'),
            ),
          ],
        ),
      ),
    );
  }
}
