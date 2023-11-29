import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:appwrite/appwrite.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_client.g.dart';

@Riverpod(keepAlive: true)
Account appwrite(AppwriteRef ref) {
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
}
