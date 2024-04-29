import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  Client client = Client()
      .setEndpoint(
        "https://haajar.govindsr.me/v1",
      )
      .setProject(
        "655313f7aab496eee7ba",
      );
  late Account account = Account(client);
  late Databases db = Databases(client);
  late Storage storage = Storage(client);
}

final appwrite = AppwriteConfig();
