import 'dart:io';
import 'dart:typed_data';

import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:haajar_final/configs/appwrite_config.dart';
import 'package:haajar_final/controllers/push_notifications_controller.dart';
import 'package:haajar_final/models/announcement.dart';
import 'dart:io' as io;

import 'package:uuid/uuid.dart';

class AnnouncementController {
  var uuid = const Uuid();

  Future<List<Document>> getAllAnnouncements() async {
    try {
      final result = await appwrite.db.listDocuments(
          databaseId: "660d615ce0e16c125164",
          collectionId: "660d62d13db053085175");
      //sort according to decreasing timestamp
      result.documents.sort((a, b) {
        return DateTime.parse(b.data["timestamp"])
            .compareTo(DateTime.parse(a.data["timestamp"]));
      });
      return result.documents;
    } catch (err) {
      rethrow;
    }
  }

  Future<Document> addAnnouncement(Announcement announcement) async {
    try {
      late String? fileId;

      await pushNotificationController.sendGeneralPushNotification(
          announcement.title, announcement.description);

      if (announcement.attachment != null) {
        fileId = uuid.v1();
        await appwrite.storage.createFile(
          bucketId: "660cd9bfda6da4ef88b4",
          fileId: fileId,
          file: InputFile.fromPath(path: announcement.attachment!),
        );
      }

      final result = await appwrite.db.createDocument(
        databaseId: "660d615ce0e16c125164",
        collectionId: "660d62d13db053085175",
        documentId: ID.unique(),
        data: {
          "title": announcement.title,
          "description": announcement.description,
          "attachment": fileId,
          "timestamp": announcement.timestamp.toIso8601String(),
        },
      );

      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<Document> editAnnouncement({
    String? title,
    String? description,
    String? fileId,
    io.File? attachment,
    required String documentID,
  }) async {
    try {
      String? newFileId = uuid.v1();

      await pushNotificationController.sendGeneralPushNotification(
        title ?? "Updated",
        description ?? "Some announcement got updated!",
      );

      if (fileId != null) {
        if (attachment != null) {
          await appwrite.storage.deleteFile(
            bucketId: "660cd9bfda6da4ef88b4",
            fileId: fileId,
          );
          await appwrite.storage.createFile(
            bucketId: "660cd9bfda6da4ef88b4",
            fileId: newFileId,
            file: InputFile.fromPath(path: attachment.path),
          );
        }
      } else {
        await appwrite.storage.createFile(
          bucketId: "660cd9bfda6da4ef88b4",
          fileId: newFileId,
          file: InputFile.fromPath(path: attachment!.path),
        );
      }

      final result = await appwrite.db.updateDocument(
        databaseId: "660d615ce0e16c125164",
        collectionId: "660d62d13db053085175",
        documentId: documentID,
        data: {
          "title": title,
          "description": description,
          "attachment": attachment != null ? newFileId : null,
          "timestamp": DateTime.now().toIso8601String(),
        },
      );

      return result;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> deleteAnnouncement(String documentID, String? fileId) async {
    try {
      if (fileId != null) {
        await appwrite.storage.deleteFile(
          bucketId: "660cd9bfda6da4ef88b4",
          fileId: fileId,
        );
      }
      await appwrite.db.deleteDocument(
        databaseId: "660d615ce0e16c125164",
        collectionId: "660d62d13db053085175",
        documentId: documentID,
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<io.File> getAnnouncementAttachment(
    String fileId,
  ) async {
    try {
      final response = await appwrite.storage.getFileView(
        fileId: fileId,
        bucketId: "660cd9bfda6da4ef88b4",
      );

      final Uint8List data = response;
      //current path irrespective of platform
      final io.File file = io.File("${Directory.systemTemp.path}/$fileId.pdf");
      file.writeAsBytesSync(data);

      print("worked");
      return file;
    } catch (err) {
      rethrow;
    }
  }
}

final announcementController = AnnouncementController();
