import 'package:appwrite/appwrite.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:signals/signals.dart';

final appwriteClient = signal(
  Client()
      .setEndpoint(
        dotenv.env["appwrite_endpoint"] ?? "",
      )
      .setProject(
        dotenv.env["project_id"] ?? "",
      ),
);

final appwriteAccount = signal(Account(appwriteClient()));
