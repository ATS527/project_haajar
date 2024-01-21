import 'package:flutter/material.dart';
import 'package:project_haajar/constants.dart';
import 'package:project_haajar/controllers/faculty_management_controller.dart';
import 'package:project_haajar/widgets/text_input_widget.dart';
import 'package:signals/signals.dart';

class AddFacultyScreen extends StatefulWidget {
  const AddFacultyScreen({super.key});

  @override
  State<AddFacultyScreen> createState() => _AddFacultyScreenState();
}

class _AddFacultyScreenState extends State<AddFacultyScreen> {
  final departmentSelected = signal(Department.computerScience);

  late final facultySubjects = computed(() {
    if (departmentSelected.value == Department.computerScience) {
      return ComputerScience.values;
    } else if (departmentSelected.value == Department.electronics) {
      return Electronics.values;
    } else if (departmentSelected.value == Department.electrical) {
      return Electrical.values;
    } else {
      return General.values;
    }
  });

  late TextEditingController nameController;
  late TextEditingController mailController;
  late TextEditingController qualificationController;
  late TextEditingController experienceController;

  List<String> subjectsSelected = [];

  @override
  void initState() {
    nameController = TextEditingController();
    mailController = TextEditingController();
    qualificationController = TextEditingController();
    experienceController = TextEditingController();
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Add Faculty"),
      ),
      body: SizedBox(
        width: double.infinity,
        child: LayoutBuilder(
          builder: (context, constraints) {
            if (constraints.maxWidth > 1200) {
              return desktopView();
            } else {
              return mobileView();
            }
          },
        ),
      ),
    );
  }

  Widget desktopView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 200),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Add Faculty Details Here",
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
              child: SegmentedButton<Department>(
                  segments: const [
                    ButtonSegment(
                      value: Department.computerScience,
                      label: Text("CS"),
                      icon: Icon(Icons.computer),
                    ),
                    ButtonSegment(
                      value: Department.electronics,
                      label: Text("EC"),
                      icon: Icon(Icons.cable),
                    ),
                    ButtonSegment(
                      value: Department.electrical,
                      label: Text("EEE"),
                      icon: Icon(Icons.bolt),
                    ),
                    ButtonSegment(
                      value: Department.general,
                      label: Text("General"),
                      icon: Icon(Icons.public),
                    ),
                  ],
                  selected: <Department>{
                    departmentSelected.value
                  },
                  onSelectionChanged: (Set<Department> newSelection) {
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
                onPressed: addFaculty,
                child: const Text(
                  "Add Faculty",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  Widget mobileView() {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 16),
      child: SingleChildScrollView(
        child: Column(
          children: [
            const SizedBox(height: 20),
            const Text(
              "Add Faculty Details Here",
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
              child: SegmentedButton<Department>(
                  segments: const [
                    ButtonSegment(
                      value: Department.computerScience,
                      label: Text("CS"),
                      icon: Icon(Icons.computer),
                    ),
                    ButtonSegment(
                      value: Department.electronics,
                      label: Text("EC"),
                      icon: Icon(Icons.cable),
                    ),
                    ButtonSegment(
                      value: Department.electrical,
                      label: Text("EEE"),
                      icon: Icon(Icons.bolt),
                    ),
                    ButtonSegment(
                      value: Department.general,
                      label: Text("General"),
                      icon: Icon(Icons.public),
                    ),
                  ],
                  selected: <Department>{
                    departmentSelected.value
                  },
                  onSelectionChanged: (Set<Department> newSelection) {
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
                onPressed: addFaculty,
                child: const Text(
                  "Add Faculty",
                  style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                ),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
          ],
        ),
      ),
    );
  }

  void addFaculty() {
    facultyManagement
        .createFaculty(
      name: nameController.text,
      mail: mailController.text,
      department: departmentSelected.value,
      subjects: subjectsSelected,
      qualification: qualificationController.text,
      experience: experienceController.text,
    )
        .then((value) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text("Faculty Added Successfully"),
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
}
