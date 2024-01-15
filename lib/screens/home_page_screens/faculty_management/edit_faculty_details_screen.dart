import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:project_haajar/constants.dart';
import 'package:project_haajar/controllers/faculty_management_controller.dart';
import 'package:project_haajar/widgets/text_input_widget.dart';
import 'package:signals/signals.dart';
import 'package:signals/signals_flutter.dart';

class EditFacultyDetailsScreen extends StatefulWidget {
  const EditFacultyDetailsScreen(
      {super.key,
      required this.name,
      required this.facultyMail,
      required this.department,
      required this.subjects,
      required this.qualification,
      required this.experience,
      required this.id});

  final String id;
  final String name;
  final String facultyMail;
  final String department;
  final List<String> subjects;
  final String qualification;
  final double experience;

  @override
  State<EditFacultyDetailsScreen> createState() =>
      _EditFacultyDetailsScreenState();
}

class _EditFacultyDetailsScreenState extends State<EditFacultyDetailsScreen> {
  late TextEditingController nameController;
  late TextEditingController mailController;
  late TextEditingController qualificationController;
  late TextEditingController experienceController;

  late final departmentSelected = signal(widget.department);
  late List<String> subjectsSelected = widget.subjects;

  late final facultySubjects = computed(() {
    if (departmentSelected.value == Department.computerScience.name) {
      return ComputerScience.values;
    } else if (departmentSelected.value == Department.electronics.name) {
      return Electronics.values;
    } else if (departmentSelected.value == Department.electrical.name) {
      return Electrical.values;
    } else {
      return General.values;
    }
  });

  @override
  void initState() {
    nameController = TextEditingController();
    nameController.value = TextEditingValue(text: widget.name);
    mailController = TextEditingController();
    mailController.value = TextEditingValue(text: widget.facultyMail);
    qualificationController = TextEditingController();
    qualificationController.value =
        TextEditingValue(text: widget.qualification);
    experienceController = TextEditingController();
    experienceController.value =
        TextEditingValue(text: widget.experience.toString());
    super.initState();
  }

  @override
  void dispose() {
    nameController.dispose();
    mailController.dispose();
    qualificationController.dispose();
    experienceController.dispose();
    super.dispose();
  }

  final _isLoading = signal(false);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Edit Faculty"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16),
          child: Watch((context) {
            if (_isLoading.value) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else {
              return editingWidget();
            }
          }),
        ),
      ),
    );
  }

  Widget editingWidget() {
    return SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(height: 20),
          const Text(
            "Edit Faculty Details Here",
            style: TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.bold,
            ),
          ),
          TextInputWidget(
              controller: nameController,
              textName: "Faculty Name",
              hintText: "Enter Faculty Name"),
          TextInputWidget(
              controller: mailController,
              textName: "Faculty Mail",
              hintText: "Enter Faculty Mail"),
          const SizedBox(height: 20),
          const Text(
            "Faculty Department",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          SizedBox(
            width: double.infinity,
            child: SegmentedButton<String>(
                segments: [
                  ButtonSegment(
                    value: Department.computerScience.name,
                    label: const Text("CS"),
                    icon: const Icon(Icons.computer),
                  ),
                  ButtonSegment(
                    value: Department.electronics.name,
                    label: const Text("EC"),
                    icon: const Icon(Icons.cable),
                  ),
                  ButtonSegment(
                    value: Department.electrical.name,
                    label: const Text("EEE"),
                    icon: const Icon(Icons.bolt),
                  ),
                  ButtonSegment(
                    value: Department.general.name,
                    label: const Text("General"),
                    icon: const Icon(Icons.public),
                  ),
                ],
                selected: <String>{
                  departmentSelected.value
                },
                onSelectionChanged: (Set<String> newSelection) {
                  setState(() {
                    departmentSelected.value = newSelection.first;
                  });
                }),
          ),
          const SizedBox(height: 20),
          const Text(
            "Faculty Subjects",
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          Wrap(
            spacing: 5.0,
            children: facultySubjects.value
                .map((subject) => Padding(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 4, vertical: 8),
                      child: FilterChip(
                        label: Text(subject.name),
                        selected: subjectsSelected.contains(subject.name),
                        onSelected: (bool selected) {
                          if (selected) {
                            setState(() {
                              subjectsSelected.add(subject.name);
                            });
                          } else {
                            setState(() {
                              subjectsSelected.remove(subject.name);
                            });
                          }
                        },
                      ),
                    ))
                .toList(),
          ),
          TextInputWidget(
              controller: qualificationController,
              textName: "Faculty Qualification",
              hintText: "Enter Faculty Qualification"),
          TextInputWidget(
              controller: experienceController,
              textName: "Faculty Experience",
              hintText: "Enter Faculty Experience"),
          const SizedBox(
            height: 40,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: editFaculty,
              child: const Text(
                "Edit Faculty",
                style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          SizedBox(
            width: double.infinity,
            height: 60,
            child: ElevatedButton(
              onPressed: deleteFaculty,
              child: const Text(
                "Delete Faculty",
                style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.bold,
                    color: Colors.red),
              ),
            ),
          ),
          const SizedBox(
            height: 40,
          ),
        ],
      ),
    );
  }

  void editFaculty() async {
    _isLoading.value = true;
    await facultyManagement
        .editFaculty(
            id: widget.id,
            name: nameController.text,
            mail: mailController.text,
            department: departmentSelected.value,
            subjects: subjectsSelected,
            qualification: qualificationController.text,
            experience: experienceController.text)
        .then((value) {
      _isLoading.value = false;
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Faculty Edited Successfully"),
        ),
      );
    }).catchError((err) {
      _isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
        ),
      );
    });
  }

  void deleteFaculty() async {
    _isLoading.value = true;
    await facultyManagement
        .deleteFaculty(
      id: widget.id,
    )
        .then((value) {
      _isLoading.value = false;
      context.pop();
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Faculty Deleted Successfully"),
        ),
      );
    }).catchError((err) {
      _isLoading.value = false;
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(err),
        ),
      );
    });
  }
}
