import 'package:appwrite/appwrite.dart';
import 'package:project_haajar/config/appwrite_config.dart';
import 'package:project_haajar/controllers/authentication_controller.dart';

class RealtimeLogs {
  final realtime = Realtime(appwriteClient.peek());
  late final RealtimeSubscription subscription;

  void subscribeRealtime() {
    subscription = realtime.subscribe(['account', "files", "documents"]);
    subscription.stream.listen((response) {
      if (response.events[2] == "users.*.sessions.*.create" ||
          response.events[2] == "users.*.sessions.*.delete") {
        auth.initialiseUser();
      }
    });
  }

  void dispose() {
    subscription.close();
  }
}

final realtimeLogs = RealtimeLogs();
