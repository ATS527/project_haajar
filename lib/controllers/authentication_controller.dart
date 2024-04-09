import 'dart:convert';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haajar_final/configs/push_notification_config.dart';
import 'package:signals/signals.dart';
import 'package:http/http.dart' as http;

class AuthController {
  final currentlyLoggedInUser = signal<User?>(null);

  late final isLoggedIn = computed(() => currentlyLoggedInUser() != null);

  late final isAdmin = signal<bool>(false);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void listenToAuthChanges() {
    _auth.userChanges().listen((User? user) async {
      if (user == null) {
        currentlyLoggedInUser.value = null;
        await PushNotifications.firebaseMessaging
            .unsubscribeFromTopic("assignedFaculty");
        await PushNotifications.firebaseMessaging
            .unsubscribeFromTopic("generalAnnouncements");
      } else {
        currentlyLoggedInUser.value = user;
        await PushNotifications.firebaseMessaging
            .subscribeToTopic("assignedFaculty");
        await PushNotifications.firebaseMessaging
            .subscribeToTopic("generalAnnouncements");
      }
    });
  }

  Future<void> handleGoogleSignin() async {
    try {
      //web
      // GoogleAuthProvider googleAuthProvider = GoogleAuthProvider();
      // googleAuthProvider
      //     .addScope("https://www.googleapis.com/auth/userinfo.profile")
      //     .addScope("https://www.googleapis.com/auth/userinfo.email");
      // await _auth.signInWithProvider(
      //   googleAuthProvider,
      // );

      GoogleSignIn googleSignIn = GoogleSignIn();
      GoogleSignInAccount? googleSignInAccount = await googleSignIn.signIn();
      if (googleSignInAccount == null) {
        throw Exception();
      }

      GoogleSignInAuthentication googleSignInAuthentication =
          await googleSignInAccount.authentication;
      AuthCredential credential = GoogleAuthProvider.credential(
        idToken: googleSignInAuthentication.idToken,
        accessToken: googleSignInAuthentication.accessToken,
      );

      var result = (await _auth.signInWithCredential(credential));
      currentlyLoggedInUser.value = result.user;
      currentlyLoggedInUser.value
          ?.updateDisplayName(googleSignInAccount.displayName!);

      List<dynamic> admins = await getAdmins();

      print(admins);

      if (admins.contains(googleSignInAccount.email)) {
        isAdmin.value = true;
        print("worked");
      } else {
        isAdmin.value = false;
      }
    } catch (err, stacktrace) {
      throw stacktrace;
      // rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }

  Future<List<dynamic>> getAdmins() async {
    try {
      var url = Uri.https(dotenv.env["SERVER_URL"]!, "/get-admins");

      final response = await http.get(
        url,
        headers: {
          "Content-Type": "application/json",
          "api": dotenv.env["API_KEY"]!,
        },
      );

      var data = json.decode(response.body);

      if (data["success"] = true) {
        return data["admins"];
      } else if (data == "Unauthorized") {
        throw Exception("Unauthorized (Invalid SERVER_API_KEY)");
      } else {
        return [];
      }
    } catch (err) {
      rethrow;
    }
  }
}

final auth = AuthController();
