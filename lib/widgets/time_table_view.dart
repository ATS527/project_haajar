import 'package:flutter/material.dart';
import 'package:project_haajar/models/timetable.dart';

class TimeTableView extends StatelessWidget {
  TimeTableView({super.key, required this.timeTableList});

  List<TimeTable> timeTableList;

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Table(
        border: TableBorder.all(),
        columnWidths: const <int, TableColumnWidth>{
          0: FlexColumnWidth(2),
          1: FlexColumnWidth(1),
          2: FlexColumnWidth(1),
          3: FlexColumnWidth(1),
          4: FlexColumnWidth(1),
          5: FlexColumnWidth(1),
          6: FlexColumnWidth(1),
          7: FlexColumnWidth(1),
          8: FlexColumnWidth(1),
          9: FlexColumnWidth(1),
          10: FlexColumnWidth(1),
          11: FlexColumnWidth(1),
          12: FlexColumnWidth(1),
          13: FlexColumnWidth(1),
          14: FlexColumnWidth(1),
          15: FlexColumnWidth(1),
          16: FlexColumnWidth(1),
          17: FlexColumnWidth(1),
          18: FlexColumnWidth(1),
          19: FlexColumnWidth(1),
          20: FlexColumnWidth(1),
          21: FlexColumnWidth(1),
          22: FlexColumnWidth(1),
          23: FlexColumnWidth(1),
          24: FlexColumnWidth(1),
          25: FlexColumnWidth(1),
          26: FlexColumnWidth(1),
          27: FlexColumnWidth(1),
          28: FlexColumnWidth(1),
          29: FlexColumnWidth(1),
          30: FlexColumnWidth(1),
          31: FlexColumnWidth(1),
          32: FlexColumnWidth(1),
          33: FlexColumnWidth(1),
          34: FlexColumnWidth(1),
          35: FlexColumnWidth(1),
          36: FlexColumnWidth(1),
          37: FlexColumnWidth(1),
          38: FlexColumnWidth(1),
        },
        defaultVerticalAlignment: TableCellVerticalAlignment.middle,
        children: const [
          TableRow(
            children: [
              TableCell(
                child: Text("Class"),
              ),
              TableCell(
                child: Text("Monday"),
              ),
              TableCell(
                child: Text("Tuesday"),
              ),
              TableCell(
                child: Text("Wednesday"),
              ),
              TableCell(
                child: Text("Thursday"),
              ),
              TableCell(
                child: Text("Friday"),
              ),
            ],
          ),
          TableRow(
            children: [
              
            ],
          )
        ],
      ),
    );
  }
}
