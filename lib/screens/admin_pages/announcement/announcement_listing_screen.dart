import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/announcement_controller.dart';
import 'package:haajar_final/models/announcement.dart';
import 'package:haajar_final/screens/admin_pages/announcement/add_announcement_screen.dart';
import 'package:haajar_final/screens/admin_pages/announcement/edit_announcement_screen.dart';

class AnnouncementListingScreen extends StatefulWidget {
  const AnnouncementListingScreen({super.key});

  @override
  State<AnnouncementListingScreen> createState() =>
      _AnnouncementListingScreenState();
}

class _AnnouncementListingScreenState extends State<AnnouncementListingScreen> {
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
                            return EditAnnouncementScreen(
                              announcement: Announcement(
                                title: item!["title"],
                                timestamp: DateTime.parse(item["timestamp"]),
                                description: item["description"],
                                attachment: item["attachment"],
                              ),
                              documentID: snapshot.data![index].$id,
                            );
                          },
                        ),
                      );
                    },
                    title: Text(snapshot.data?[index].data['title']),
                    subtitle: Text(snapshot.data?[index].data['description']),
                    trailing: IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () async {
                        await announcementController
                            .deleteAnnouncement(
                          snapshot.data![index].$id,
                          snapshot.data![index].data["attachment"],
                        )
                            .then((value) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            const SnackBar(
                              content: Text("Announcement Deleted"),
                            ),
                          );
                          setState(() {});
                        }).catchError((err) {
                          ScaffoldMessenger.of(context).showSnackBar(
                            SnackBar(
                              content: Text(err.toString()),
                            ),
                          );
                        });
                      },
                    ),
                  );
                },
              );
            }
          }),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) {
                return const AddAnnouncementScreen();
              },
            ),
          ).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
    );
  }
}
