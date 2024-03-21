import 'package:appwrite/appwrite.dart';

class AppwriteConfig {
  Client client = Client()
      .setEndpoint(
        "https://haajar.govindsr.me/v1",
      )
      .setProject(
        "65e84d6491a221f5c58d",
      );
  late Account account = Account(client);
  late Databases db = Databases(client);
}

final appwrite = AppwriteConfig();
