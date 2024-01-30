class TimeTable {
  int id;
  String day;
  String hour;
  String yearWithClass;
  String subject;
  String teacher;

  TimeTable(this.id, this.day, this.hour, this.yearWithClass, this.subject,
      this.teacher);

  TimeTable.fromlist(List<dynamic> items)
      : this(int.parse(items[0]), items[1], items[2], items[3], items[4],
            items[5]);

  @override
  String toString() {
    return 'timetable id: $id, day: $day, hour: $hour, yearWithClass: $yearWithClass, subject: $subject, teacher: $teacher';
  }
}
