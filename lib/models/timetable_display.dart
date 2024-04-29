import 'package:haajar_final/models/assigned_faculty.dart';

class TimeTableDisplay {
  final String yearWithClass;
  final List<String> hours;
  final List<String> subjects;
  final List<String> days;
  final List<String> teachers;
  final List<AssignedFaculty?> assignedFaculty;

  TimeTableDisplay({
    required this.yearWithClass,
    required this.hours,
    required this.subjects,
    required this.days,
    required this.teachers,
    required this.assignedFaculty,
  });

  toList() {}
}