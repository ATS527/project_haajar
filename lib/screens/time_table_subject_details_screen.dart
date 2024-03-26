import 'package:flutter/material.dart';
import 'package:haajar_final/models/timetableDisplay.dart';

class TimeTableSubjectDetailsScreen extends StatefulWidget {
  const TimeTableSubjectDetailsScreen({
    super.key,
    required this.subjectName,
    required this.facultiesName,
    required this.hour,
    required this.year,
    required this.timeTables,
    required this.day,
  });

  final String subjectName;
  final String year;
  final String facultiesName;
  final String hour;
  final String day;
  final List<TimeTableDisplay> timeTables;

  @override
  State<TimeTableSubjectDetailsScreen> createState() =>
      _TimeTableSubjectDetailsScreenState();
}

class _TimeTableSubjectDetailsScreenState
    extends State<TimeTableSubjectDetailsScreen> {
  List<String> teachersActive = [];
  List<String> teachersAvaiable = [];
  List<String> teachersFree = [];

  @override
  void initState() {
    // TODO: implement initState
    for (var i = 0; i < widget.timeTables.length; i++) {
      widget.timeTables[i].days.asMap().forEach((index, element) {
        if (element == widget.day &&
            widget.timeTables[i].hours[index] == widget.hour) {
          if (widget.timeTables[i].teachers[index].contains("+")) {
            teachersActive.addAll(
                widget.timeTables[i].teachers[index].split("+").toList());
          } else {
            teachersActive.add(widget.timeTables[i].teachers[index]);
          }
        }
      });
    }

    for (var i = 0; i < widget.timeTables.length; i++) {
      widget.timeTables[i].days.asMap().forEach((index, element) {
        if (widget.timeTables[i].teachers[index].contains("+")) {
          teachersAvaiable
              .addAll(widget.timeTables[i].teachers[index].split("+").toList());
        } else {
          teachersAvaiable.add(widget.timeTables[i].teachers[index]);
        }
      });
    }

    //delete duplicates in teachersAvailable
    teachersAvaiable = teachersAvaiable.toSet().toList();

    for (var teacher in teachersAvaiable) {
      if (!teachersActive.contains(teacher)) {
        teachersFree.add(teacher);
      }
    }
    print(teachersActive);
    print(teachersAvaiable);
    print(teachersFree);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Subject Allocation"),
      ),
      body: Column(
        children: [
          Card(
            child: ListTile(
              title: Text("Subject: ${widget.subjectName}"),
              subtitle: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text("Faculty: ${widget.facultiesName}"),
                  Text("Hour: ${widget.hour}"),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 10,
          ),
          const Text("Assign Free Teachers: "),
          Expanded(
            child: ListView(
              children: [
                for (var teacher in teachersFree)
                  Card(
                    child: ListTile(
                      title: Text(teacher),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
