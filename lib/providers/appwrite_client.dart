import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:appwrite/appwrite.dart';

final appwriteProvider = Provider<Account>(
  (ref) {
    Client client = Client();
    client
        .setEndpoint(
          dotenv.env["appwrite_endpoint"] ?? "",
        )
        .setProject(
          dotenv.env["project_id"] ?? "",
        );

    final account = Account(client);
    return account;
  },
);
