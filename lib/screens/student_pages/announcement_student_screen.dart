import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/announcement_controller.dart';

import 'package:haajar_final/screens/student_pages/announcement_details_student_screen.dart';

class AnnouncementStudentScreen extends StatefulWidget {
  const AnnouncementStudentScreen({super.key});

  @override
  State<AnnouncementStudentScreen> createState() =>
      _AnnouncementStudentScreenState();
}

class _AnnouncementStudentScreenState extends State<AnnouncementStudentScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Announcement Listing'),
      ),
      body: FutureBuilder(
          future: announcementController.getAllAnnouncements(),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.hasError) {
              return Center(
                child: Text(snapshot.error.toString()),
              );
            } else {
              if (snapshot.data!.isEmpty) {
                return const Center(
                  child: Text("No Announcements Found"),
                );
              }
              return ListView.builder(
                itemCount: snapshot.data?.length,
                itemBuilder: (context, index) {
                  final item = snapshot.data?[index].data;
                  return ListTile(
                    onTap: () {
                      Navigator.of(context).push(
                        MaterialPageRoute(
                          builder: (context) {
                            return AnnouncementDetailsStudentScreen(
                              announcement: item,
                            );
                          },
                        ),
                      );
                    },
                    title: Text(snapshot.data?[index].data['title']),
                    subtitle: Text(snapshot.data?[index].data['description']),
                    trailing: Text(
                      "${DateTime.parse(snapshot.data?[index].data['timestamp']).day}/${DateTime.parse(snapshot.data?[index].data['timestamp']).month}/${DateTime.parse(snapshot.data?[index].data['timestamp']).year}",
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}
