import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:project_haajar/providers/time_table_logic_provider.dart';

class DashboardView extends ConsumerStatefulWidget {
  const DashboardView({super.key});

  @override
  ConsumerState<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends ConsumerState<DashboardView> {
  Widget headerContainer(String text) {
    return Container(
      height: 100,
      width: 900,
      //add a border
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget departmentContainer(String text) {
    return Container(
      height: 100,
      width: 100,
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget departmentSubContainer(String text) {
    return Container(
      height: 160,
      width: 100,
      //add a border
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Center(child: Text(text)),
    );
  }

  Widget subjectContainer({required String subject, required String faculty}) {
    return Container(
      height: 160,
      width: 150,
      //add a border
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.black,
          width: 1,
        ),
      ),
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          Center(
            child: Text(
              subject,
              style: const TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              textAlign: TextAlign.center,
            ),
          ),
          const SizedBox(
            height: 15,
          ),
          Center(
            child: Text(
              faculty,
              textAlign: TextAlign.center,
            ),
          ),
        ],
      ),
    );
  }

  List timeTable = [];

  @override
  void initState() {
    setState(() {
      timeTable = ref.read(timeTableLogicProvider.notifier).generateTimeTable();
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        children: [
          const SizedBox(
            height: 15,
          ),
          const Text(
            "Time Table Generation",
            style: TextStyle(fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    departmentContainer("Department"),
                    headerContainer("Monday"),
                    headerContainer("Tuesday"),
                    headerContainer("Wednesday"),
                    headerContainer("Thursday"),
                    headerContainer("Friday"),
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    departmentSubContainer("S7 CS"),
                    for (int i = 0; i < 5; i++)
                      for (int j = 0; j < 6; j++)
                        subjectContainer(
                            subject: timeTable[i]["subjectsS7"][j]["subject"],
                            faculty: timeTable[i]["subjectsS7"][j]["faculty"])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    departmentSubContainer("S5 CS"),
                    for (int i = 0; i < 5; i++)
                      for (int j = 0; j < 6; j++)
                        subjectContainer(
                            subject: timeTable[i]["subjectsS5"][j]["subject"],
                            faculty: timeTable[i]["subjectsS5"][j]["faculty"])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    departmentSubContainer("S3 CS"),
                    for (int i = 0; i < 5; i++)
                      for (int j = 0; j < 6; j++)
                        subjectContainer(
                            subject: timeTable[i]["subjectsS3CS"][j]["subject"],
                            faculty: timeTable[i]["subjectsS3CS"][j]["faculty"])
                  ],
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    departmentSubContainer("S3 AI"),
                    for (int i = 0; i < 5; i++)
                      for (int j = 0; j < 6; j++)
                        subjectContainer(
                            subject: timeTable[i]["subjectsS3AI"][j]["subject"],
                            faculty: timeTable[i]["subjectsS3AI"][j]["faculty"])
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
