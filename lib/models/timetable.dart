import 'package:project_haajar/models/subject_with_faculty.dart';

class TimeTable {
  final String day;
  final List<SubjectWithFaculty> subjects;

  TimeTable({required this.day, required this.subjects});
}