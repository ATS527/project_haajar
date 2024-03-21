import 'dart:io';

import 'package:csv/csv.dart';
import 'package:haajar_final/models/timetable.dart';

class TimeTableController {
  List<TimeTable> timetableList = [];

  Future<void> saveTimeTable(File? timeTableFile) async {
    Future<String> futureContent = timeTableFile!.readAsString();
    futureContent.then((csv) async {
      List<List<dynamic>> rowsAsListOfValues = const CsvToListConverter(
        eol: '\n',
      ).convert(csv).toList();
      rowsAsListOfValues.removeAt(0);
      for (var row in rowsAsListOfValues) {
        timetableList.add(
          TimeTable.fromlist(row),
        );
      }
    });
  }
}

final timeTableController = TimeTableController();
