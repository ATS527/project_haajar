import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project_haajar/config/database_config.dart';
import '../models/timetable.dart';

class TimeTableManagement {
  Future<void> createTimeTable(List<TimeTable> timeTableList) async {
    try {
      List<TimeTable> _4cs = [];
      List<TimeTable> _3cs = [];
      List<TimeTable> _2ai = [];
      List<TimeTable> _2cs = [];
      List<TimeTable> _1csa = [];
      List<TimeTable> _1csb = [];
      List<TimeTable> _1ai = [];

      Map<String, List<TimeTable>> timeTableDays = {
        "Monday": [],
        "Tuesday": [],
        "Wednesday": [],
        "Thursday": [],
        "Friday": [],
      };

      for (var timeTable in timeTableList) {
        timeTableDays[timeTable.day]?.add(timeTable);
      }

      timeTableDays["Monday"]?.sort((a, b) => a.hour.compareTo(b.hour));
      timeTableDays["Tuesday"]?.sort((a, b) => a.hour.compareTo(b.hour));
      timeTableDays["Wednesday"]?.sort((a, b) => a.hour.compareTo(b.hour));
      timeTableDays["Thursday"]?.sort((a, b) => a.hour.compareTo(b.hour));
      timeTableDays["Friday"]?.sort((a, b) => a.hour.compareTo(b.hour));

      for (var day in timeTableDays.keys) {
        for (var timeTable in timeTableDays[day]!) {
          if (timeTable.yearWithClass == "4CS") {
            _4cs.add(timeTable);
          } else if (timeTable.yearWithClass == "3CS") {
            _3cs.add(timeTable);
          } else if (timeTable.yearWithClass == "2AI") {
            _2ai.add(timeTable);
          } else if (timeTable.yearWithClass == "2CS") {
            _2cs.add(timeTable);
          } else if (timeTable.yearWithClass == "1CSA") {
            _1csa.add(timeTable);
          } else if (timeTable.yearWithClass == "1CSB") {
            _1csb.add(timeTable);
          } else if (timeTable.yearWithClass == "1AI") {
            _1ai.add(timeTable);
          }
        }
      }
      List _4csHours = [];
      List _4csSubjects = [];
      List _4csDays = [];
      List _4csTeachers = [];
      for (var hour in _4cs) {
        _4csHours.add(hour.hour);
        _4csSubjects.add(hour.subject);
        _4csDays.add(hour.day);
        _4csTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "4CS",
          "hours": _4csHours,
          "subjects": _4csSubjects,
          "teachers": _4csTeachers,
          "days": _4csDays
        },
      );

      List _3csHours = [];
      List _3csSubjects = [];
      List _3csDays = [];
      List _3csTeachers = [];
      for (var hour in _3cs) {
        _3csHours.add(hour.hour);
        _3csSubjects.add(hour.subject);
        _3csDays.add(hour.day);
        _3csTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "3CS",
          "hours": _3csHours,
          "subjects": _3csSubjects,
          "teachers": _3csTeachers,
          "days": _3csDays
        },
      );

      List _2aiHours = [];
      List _2aiSubjects = [];
      List _2aiDays = [];
      List _2aiTeachers = [];
      for (var hour in _2ai) {
        _2aiHours.add(hour.hour);
        _2aiSubjects.add(hour.subject);
        _2aiDays.add(hour.day);
        _2aiTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "2AI",
          "hours": _2aiHours,
          "subjects": _2aiSubjects,
          "teachers": _2aiTeachers,
          "days": _2aiDays
        },
      );

      List _2csHours = [];
      List _2csSubjects = [];
      List _2csDays = [];
      List _2csTeachers = [];
      for (var hour in _2cs) {
        _2csHours.add(hour.hour);
        _2csSubjects.add(hour.subject);
        _2csDays.add(hour.day);
        _2csTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "2CS",
          "hours": _2csHours,
          "subjects": _2csSubjects,
          "teachers": _2csTeachers,
          "days": _2csDays
        },
      );

      List _1csaHours = [];
      List _1csaSubjects = [];
      List _1csaDays = [];
      List _1csaTeachers = [];
      for (var hour in _1csa) {
        _1csaHours.add(hour.hour);
        _1csaSubjects.add(hour.subject);
        _1csaDays.add(hour.day);
        _1csaTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "1CSA",
          "hours": _1csaHours,
          "subjects": _1csaSubjects,
          "teachers": _1csaTeachers,
          "days": _1csaDays
        },
      );

      List _1csbHours = [];
      List _1csbSubjects = [];
      List _1csbDays = [];
      List _1csbTeachers = [];
      for (var hour in _1csb) {
        _1csbHours.add(hour.hour);
        _1csbSubjects.add(hour.subject);
        _1csbDays.add(hour.day);
        _1csbTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "1CSB",
          "hours": _1csbHours,
          "subjects": _1csbSubjects,
          "teachers": _1csbTeachers,
          "days": _1csbDays
        },
      );

      List _1aiHours = [];
      List _1aiSubjects = [];
      List _1aiDays = [];
      List _1aiTeachers = [];
      for (var hour in _1ai) {
        _1aiHours.add(hour.hour);
        _1aiSubjects.add(hour.subject);
        _1aiDays.add(hour.day);
        _1aiTeachers.add(hour.teacher);
      }

      await databaseClient.value.createDocument(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: "65d5ba163ebf01cfc313",
        documentId: ID.unique(),
        data: {
          "yearWithClass": "1AI",
          "hours": _1aiHours,
          "subjects": _1aiSubjects,
          "teachers": _1aiTeachers,
          "days": _1aiDays
        },
      );
    } catch (_) {
      rethrow;
    }
  }

  Future<DocumentList> getAllFaculties() async {
    try {
      final document = await databaseClient.value.listDocuments(
        databaseId: 'faculty',
        collectionId: 'faculty_details',
      );
      print(document.documents[0].data);
      return document;
    } catch (err) {
      rethrow;
    }
  }

  Future<Document> editFaculty({
    required String id,
    required String name,
    required String mail,
    required String department,
    required List<String> subjects,
    required String qualification,
    required String experience,
  }) async {
    try {
      final document = databaseClient.value.updateDocument(
          databaseId: 'faculty',
          collectionId: 'faculty_details',
          documentId: id,
          data: {
            "name": name,
            "faculty_mail": mail,
            "department": department,
            "subjects": subjects,
            "qualification": qualification,
            "experience": double.parse(experience),
          });
      return document;
    } catch (_) {
      rethrow;
    }
  }

  Future deleteFaculty({
    required String id,
  }) async {
    try {
      await databaseClient.value.deleteDocument(
        databaseId: 'faculty',
        collectionId: 'faculty_details',
        documentId: id,
      );
    } catch (_) {
      rethrow;
    }
  }
}

final timeTableManagement = TimeTableManagement();
