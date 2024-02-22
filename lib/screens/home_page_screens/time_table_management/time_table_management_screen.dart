import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/controllers/faculty_management_controller.dart';
import 'package:project_haajar/router.dart';
import 'package:project_haajar/widgets/time_table.dart';

class TimeTableManagementScreen extends StatefulWidget {
  const TimeTableManagementScreen({super.key});

  @override
  State<TimeTableManagementScreen> createState() =>
      _TimeTableManagementScreenState();
}

class _TimeTableManagementScreenState extends State<TimeTableManagementScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          context.push(AppRouteConstants.addTimeTableScreen).then((value) {
            setState(() {});
          });
        },
        child: const Icon(Icons.add),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
          child: Column(
            children: [
              const Text(
                "Create and Manage TimeTables here",
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
                    return Timetable();
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
    );
  }
}
