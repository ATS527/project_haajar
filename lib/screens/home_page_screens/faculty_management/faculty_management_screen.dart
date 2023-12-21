import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/router.dart';

class FacultyManagementScreen extends StatelessWidget {
  const FacultyManagementScreen({super.key});

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
              ),
              const SizedBox(
                height: 14,
              ),
              Expanded(
                child: ListView.builder(
                  shrinkWrap: true,
                  itemCount: 10,
                  itemBuilder: (context, index) {
                    return Card(
                      child: ListTile(
                        contentPadding: const EdgeInsets.symmetric(
                            vertical: 24, horizontal: 16),
                        title: Text("Faculty $index"),
                        trailing: IconButton(
                          onPressed: () {
                            context.push(
                                AppRouteConstants.editFacultyDetailsScreen);
                          },
                          icon: const Icon(
                            Icons.edit,
                          ),
                        ),
                      ),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
          onPressed: () {
            context.push(AppRouteConstants.addFacultyScreen);
          },
          child: const Icon(Icons.add)),
    );
  }
}
