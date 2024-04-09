import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/announcement_controller.dart';
import 'package:haajar_final/screens/admin_pages/announcement/pdf_viewer_screen.dart';

class AnnouncementDetailsStudentScreen extends StatelessWidget {
  const AnnouncementDetailsStudentScreen(
      {super.key, required this.announcement});

  final Map<String, dynamic>? announcement;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Announcement Details"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const SizedBox(
              height: 30,
            ),
            Text(
              announcement?['title'] ?? "",
              style: const TextStyle(
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              announcement?['description'] ?? "",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Posted On:${DateTime.parse(announcement?['timestamp'] ?? "").day}/${DateTime.parse(announcement?['timestamp'] ?? "").month}/${DateTime.parse(announcement?['timestamp'] ?? "").year} ${DateTime.parse(announcement?['timestamp'] ?? "").hour}:${DateTime.parse(announcement?['timestamp'] ?? "").minute}:${DateTime.parse(announcement?['timestamp'] ?? "").second}",
              style: const TextStyle(
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            ElevatedButton(
              onPressed: () async {
                await announcementController
                    .getAnnouncementAttachment(
                        announcement?['attachment'] ?? "")
                    .then((value) {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) {
                    return PdfViewerScreen(
                      pdfFile: value,
                    );
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
              },
              child: const Text("Open Attachment"),
            ),
          ],
        ),
      ),
    );
  }
}
