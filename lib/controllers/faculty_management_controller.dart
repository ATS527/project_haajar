import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project_haajar/config/database_config.dart';
import 'package:project_haajar/constants.dart';

class FacultyManagement {
  Future<void> createFaculty({
    required String name,
    required String mail,
    required Department department,
    required List<String> subjects,
    required String qualification,
    required String experience,
  }) {
    try {
      final document = databaseClient.value.createDocument(
        databaseId: 'faculty',
        collectionId: 'faculty_details',
        documentId: ID.unique(),
        data: {
          "name": name,
          "faculty_mail": mail,
          "department": department.name,
          "subjects": subjects,
          "qualification": qualification,
          "experience": experience == "" ? 0.0 : double.parse(experience),
        },
      );
      return document;
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

final facultyManagement = FacultyManagement();
