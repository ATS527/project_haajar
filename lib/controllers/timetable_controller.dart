import 'dart:io';

import 'package:appwrite/appwrite.dart';
import 'package:csv/csv.dart';
import 'package:haajar_final/configs/appwrite_config.dart';
import 'package:haajar_final/controllers/push_notifications_controller.dart';
import 'package:haajar_final/models/assigned_faculty.dart';
import 'package:haajar_final/models/timetable.dart';
import 'package:haajar_final/models/timetable_display.dart';

class TimeTableController {
  Future<void> saveTimeTable(File? timeTableFile) async {
    try {
      final result = await fetchAllTimeTable();
      if (result.isEmpty) {
        List<TimeTable> timetableList = [];
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
          saveTimeTableToAppwrite(timetableList);
        });
      } else {
        throw "One Time Table Already exists in DB";
      }
    } catch (err) {
      rethrow;
    }
  }

  Future<List<TimeTableDisplay>> fetchAllTimeTable() async {
    try {
      final document = await appwrite.db.listDocuments(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: '65d5ba163ebf01cfc313',
      );

      final assignedFaculties = await appwrite.db.listDocuments(
        databaseId: '65d5a5cd5f8582b0a955',
        collectionId: '66028dc46a32162167af',
      );

      List<TimeTableDisplay> timeTableDisplay = document.documents.map(
        (e) {
          return TimeTableDisplay(
            yearWithClass: e.data['yearWithClass'],
            hours: e.data['hours'].map<String>((e) => e.toString()).toList(),
            subjects:
                e.data['subjects'].map<String>((e) => e.toString()).toList(),
            days: e.data['days'].map<String>((e) => e.toString()).toList(),
            teachers:
                e.data['teachers'].map<String>((e) => e.toString()).toList(),
            assignedFaculty: List.generate(
              e.data['hours'].length,
              (index) => null,
            ),
          );
        },
      ).toList();

      for (var j = 0; j < assignedFaculties.documents.length; j++) {
        for (var k = 0; k < timeTableDisplay.length; k++) {
          for (var i = 0; i < timeTableDisplay[k].days.length; i++) {
            if (timeTableDisplay[k].yearWithClass ==
                    assignedFaculties.documents[j].data['yearWithClass'] &&
                timeTableDisplay[k].days[i] ==
                    assignedFaculties.documents[j].data['day'] &&
                timeTableDisplay[k].hours[i] ==
                    assignedFaculties.documents[j].data['hour']) {
              timeTableDisplay[k].assignedFaculty[i] = AssignedFaculty(
                faculty: assignedFaculties.documents[j].data['faculty'],
                subject: timeTableDisplay[k].subjects[i],
                yearWithClass: timeTableDisplay[k].yearWithClass,
                day: timeTableDisplay[k].days[i],
                hour: timeTableDisplay[k].hours[i],
              );
            }
          }
        }
      }

      return timeTableDisplay;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> saveTimeTableToAppwrite(List<TimeTable> timetableList) async {
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

      for (var timeTable in timetableList) {
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

      await appwrite.db.createDocument(
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

      await appwrite.db.createDocument(
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

      await appwrite.db.createDocument(
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

      await appwrite.db.createDocument(
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

      await appwrite.db.createDocument(
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

      await appwrite.db.createDocument(
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

      await appwrite.db.createDocument(
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

      print("save done");
    } catch (err) {
      rethrow;
    }
  }

  Future<void> assignFaculties({
    required assignedFaculty,
  }) async {
    try {
      final result = await appwrite.db.listDocuments(
        databaseId: "65d5a5cd5f8582b0a955",
        collectionId: "66028dc46a32162167af",
      );

      if (result.documents.isEmpty) {
        await appwrite.db.createDocument(
          databaseId: "65d5a5cd5f8582b0a955",
          collectionId: "66028dc46a32162167af",
          documentId: ID.unique(),
          data: {
            "yearWithClass": assignedFaculty.yearWithClass,
            "day": assignedFaculty.day,
            "hour": assignedFaculty.hour,
            "subject": assignedFaculty.subject,
            "faculty": assignedFaculty.faculty,
          },
        );

        await pushNotificationController
            .sendAssignedFacultyPushNotification(assignedFaculty);
        return;
      }

      for (var doc in result.documents) {
        if (doc.data['yearWithClass'] == assignedFaculty.yearWithClass &&
            doc.data['day'] == assignedFaculty.day &&
            doc.data['hour'] == assignedFaculty.hour) {
          throw "Already assigned";
        } else {
          await appwrite.db.createDocument(
            databaseId: "65d5a5cd5f8582b0a955",
            collectionId: "66028dc46a32162167af",
            documentId: ID.unique(),
            data: {
              "yearWithClass": assignedFaculty.yearWithClass,
              "day": assignedFaculty.day,
              "hour": assignedFaculty.hour,
              "subject": assignedFaculty.subject,
              "faculty": assignedFaculty.faculty,
            },
          );
          await pushNotificationController
              .sendAssignedFacultyPushNotification(assignedFaculty);
              
          break;
        }
      }
    } catch (err) {
      rethrow;
    }
  }
}

final timeTableController = TimeTableController();
