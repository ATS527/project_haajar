import 'package:flutter/material.dart';
import 'package:haajar_final/controllers/timetable_controller.dart';
import 'package:haajar_final/models/assigned_faculty.dart';
import 'package:haajar_final/models/timetable_display.dart';
import 'package:haajar_final/screens/admin_pages/timetable/time_table_subject_details_screen.dart';

class TimeTableDisplayScreen extends StatefulWidget {
  const TimeTableDisplayScreen({super.key});

  @override
  State<TimeTableDisplayScreen> createState() => _TimeTableDisplayScreenState();
}

class _TimeTableDisplayScreenState extends State<TimeTableDisplayScreen> {
  String yearSelected = "4CS";
  String daySelected = "Monday";

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Time Table Display Screen"),
      ),
      body: Column(
        children: [
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 16),
              child: Row(
                children: [
                  ActionChip(
                    backgroundColor:
                        yearSelected == "4CS" ? Colors.blue : Colors.white,
                    onPressed: () {
                      setState(() {
                        yearSelected = "4CS";
                      });
                    },
                    label: const Text('4CS'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        yearSelected = "3CS";
                      });
                    },
                    backgroundColor:
                        yearSelected == "3CS" ? Colors.blue : Colors.white,
                    label: const Text('3CS'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        yearSelected = "2AI";
                      });
                    },
                    backgroundColor:
                        yearSelected == "2AI" ? Colors.blue : Colors.white,
                    label: const Text('2AI'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        yearSelected = "2CS";
                      });
                    },
                    backgroundColor:
                        yearSelected == "2CS" ? Colors.blue : Colors.white,
                    label: const Text('2CS'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        yearSelected = "1CSA";
                      });
                    },
                    backgroundColor:
                        yearSelected == "1CSA" ? Colors.blue : Colors.white,
                    label: const Text('1CSA'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        yearSelected = "1CSB";
                      });
                    },
                    backgroundColor:
                        yearSelected == "1CSB" ? Colors.blue : Colors.white,
                    label: const Text('1CSB'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        yearSelected = "1AI";
                      });
                    },
                    backgroundColor:
                        yearSelected == "1AI" ? Colors.blue : Colors.white,
                    label: const Text('1AI'),
                  ),
                ],
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 4),
              child: Row(
                children: [
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        daySelected = "Monday";
                      });
                    },
                    backgroundColor:
                        daySelected == "Monday" ? Colors.blue : Colors.white,
                    label: const Text('Monday'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        daySelected = "Tuesday";
                      });
                    },
                    backgroundColor:
                        daySelected == "Tuesday" ? Colors.blue : Colors.white,
                    label: const Text('Tuesday'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        daySelected = "Wednesday";
                      });
                    },
                    backgroundColor:
                        daySelected == "Wednesday" ? Colors.blue : Colors.white,
                    label: const Text('Wednesday'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        daySelected = "Thursday";
                      });
                    },
                    backgroundColor:
                        daySelected == "Thursday" ? Colors.blue : Colors.white,
                    label: const Text('Thursday'),
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  ActionChip(
                    onPressed: () {
                      setState(() {
                        daySelected = "Friday";
                      });
                    },
                    backgroundColor:
                        daySelected == "Friday" ? Colors.blue : Colors.white,
                    label: const Text('Friday'),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(
            height: 30,
          ),
          Expanded(
            child: FutureBuilder(
                future: timeTableController.fetchAllTimeTable(),
                builder: (_, snapshot) {
                  if (snapshot.hasData) {
                    if (snapshot.data!.isEmpty) {
                      return const Center(
                        child: Text("No Time Table Found"),
                      );
                    } else {
                      return renderCardList(
                          yearSelected, daySelected, snapshot.data!.toList());
                    }
                  } else if (snapshot.hasError) {
                    return Column(
                      children: [
                        IconButton(
                          onPressed: () {
                            setState(() {});
                          },
                          icon: const Icon(Icons.refresh),
                        ),
                        const Center(
                          child: Text("An error occurred"),
                        ),
                      ],
                    );
                  } else {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  }
                }),
          ),
        ],
      ),
    );
  }

  Widget renderCardList(
      String yearWithClass, String day, List<TimeTableDisplay> timeTables) {
    final index = timeTables
        .indexWhere((element) => element.yearWithClass == yearWithClass);

    final hoursOnDay = [];
    final subjectsOnDay = [];
    final teachersOnDay = [];
    final List<AssignedFaculty?> assignedFaculty = [];

    timeTables[index].days.asMap().forEach((i, element) {
      if (element == day) {
        hoursOnDay.add(timeTables[index].hours[i]);
        subjectsOnDay.add(timeTables[index].subjects[i]);
        teachersOnDay.add(timeTables[index].teachers[i]);
        assignedFaculty.add(timeTables[index].assignedFaculty[i]);
      }
    });

    return ListView(
      children: [
        for (var i = 0; i < hoursOnDay.length; i++)
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 3),
            child: Card(
              child: ListTile(
                onTap: () {
                  Navigator.of(context).push(MaterialPageRoute(
                    builder: (context) {
                      return TimeTableSubjectDetailsScreen(
                        day: day,
                        timeTables: timeTables,
                        year: yearWithClass,
                        subjectName: subjectsOnDay[i],
                        facultiesName: teachersOnDay[i],
                        hour: hoursOnDay[i],
                      );
                    },
                  )).then((value) {
                    setState(() {});
                  });
                },
                title: Text("${hoursOnDay[i]}"),
                subtitle: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      "Subject: ${subjectsOnDay[i]}",
                    ),
                    Text(
                      "Teacher: ${teachersOnDay[i]}",
                    ),
                    assignedFaculty[i] == null
                        ? const SizedBox()
                        : Text(
                            "Assigned Teachers are: ${assignedFaculty[i]?.faculty.toString()}",
                          )
                  ],
                ),
              ),
            ),
          ),
      ],
    );
  }
}
