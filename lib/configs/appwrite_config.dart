import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  static const databaseId = "65d5a5cd5f8582b0a955";
  static const collectionId = "65d5ba163ebf01cfc313";
  Client client = Client()
      .setEndpoint(
        "https://haajar.govindsr.me/v1",
      )
      .setProject(
        "655313f7aab496eee7ba",
      );
  late Account account = Account(client);
  late Databases db = Databases(client);
}

final appwrite = AppwriteConfig();
