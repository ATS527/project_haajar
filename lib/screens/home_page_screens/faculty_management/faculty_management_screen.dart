import 'package:appwrite/models.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/faculty_management_controller.dart';
import 'package:project_haajar/router.dart';

class FacultyManagementScreen extends StatefulWidget {
  const FacultyManagementScreen({super.key});

  @override
  State<FacultyManagementScreen> createState() =>
      _FacultyManagementScreenState();
}

class _FacultyManagementScreenState extends State<FacultyManagementScreen> {
  late DocumentList? facultyList;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Create and Manage Faculties here",
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(
                height: 14,
              ),
              FutureBuilder(
                future: facultyManagement.getAllFaculties(),
                builder: (context, snapshot) {
                  if (snapshot.hasData) {
                    return Expanded(
                      child: ListView.builder(
                        shrinkWrap: true,
                        itemCount: snapshot.data?.documents.length ?? 0,
                        itemBuilder: (context, index) {
                          return Card(
                            child: ListTile(
                              contentPadding: const EdgeInsets.symmetric(
                                  vertical: 24, horizontal: 16),
                              title: Text(
                                  snapshot.data?.documents[index].data["name"]),
                              trailing: IconButton(
                                onPressed: () {
                                  context
                                      .push(
                                          "/home-screen/faculty-management/edit-faculty?name=${snapshot.data?.documents[index].data["name"]}&faculty_mail=${snapshot.data?.documents[index].data["faculty_mail"]}&department=${snapshot.data?.documents[index].data["department"]}&subjects=${snapshot.data?.documents[index].data["subjects"]?.join(",")}&qualification=${snapshot.data?.documents[index].data["qualification"]}&experience=${snapshot.data?.documents[index].data["experience"]}&id=${snapshot.data?.documents[index].data["\$id"]}")
                                      .then((_) {
                                    setState(() {});
                                  });
                                },
                                icon: const Icon(
                                  Icons.edit,
                                ),
                              ),
                            ),
                          );
                        },
                      ),
                    );
                  } else if (snapshot.hasError) {
                    return Expanded(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Text("There is some error fetching faculties"),
                          const SizedBox(
                            height: 30,
                          ),
                          SizedBox(
                            height: 60,
                            child: ElevatedButton.icon(
                              icon: const Icon(Icons.refresh),
                              onPressed: () {
                                setState(() {});
                              },
                              label: const Text("Refresh"),
                            ),
                          ),
                        ],
                      ),
                    );
                  } else {
                    return const Expanded(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    );
                  }
                },
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(AppRouteConstants.addFacultyScreen).then((value) {
              setState(() {});
            });
          },
          child: const Icon(Icons.add)),
    );
  }
}
