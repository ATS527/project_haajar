import 'dart:convert';

import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:haajar_final/models/assigned_faculty.dart';
import 'package:http/http.dart' as http;

class PushNotificationsController {
  Future<void> sendAssignedFacultyPushNotification(
      AssignedFaculty assignedFaculty) async {
    try {
      var url = Uri.https(
          dotenv.env["SERVER_URL"]!, "sendAssignedFacultyNotification");

      var body = {
        'year_with_class': assignedFaculty.yearWithClass,
        'day': assignedFaculty.day,
        'hour': assignedFaculty.hour,
        'subject': assignedFaculty.subject,
        'faculty': assignedFaculty.faculty,
      };

      await http.post(
        url,
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "api": dotenv.env["API_KEY"]!,
        },
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<void> sendGeneralPushNotification(
      String title, String description) async {
    try {
      var url = Uri.https(dotenv.env["SERVER_URL"]!, "sendGeneralNotification");

      var body = {
        'title': title,
        'description': description,
      };

      await http.post(
        url,
        body: json.encode(body),
        headers: {
          "Content-Type": "application/json",
          "api": dotenv.env["API_KEY"]!,
        },
      );
    } catch (err) {
      rethrow;
    }
  }
}

final pushNotificationController = PushNotificationsController();
