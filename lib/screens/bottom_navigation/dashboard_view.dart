import 'package:flutter/material.dart';

class DashboardView extends StatefulWidget {
  const DashboardView({super.key});

  @override
  State<DashboardView> createState() => _DashboardViewState();
}

class _DashboardViewState extends State<DashboardView> {
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
  // void initState() {
  //   setState(() {
  //     timeTable = ref.read(timeTableLogicProvider.notifier).generateTimeTable();
  //   });
  //   super.initState();
  // }

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}
