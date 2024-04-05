import 'package:firebase_auth/firebase_auth.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:haajar_final/configs/push_notification_config.dart';
import 'package:signals/signals.dart';

class AuthController {
  final currentlyLoggedInUser = signal<User?>(null);

  late final isLoggedIn = computed(() => currentlyLoggedInUser() != null);

  final FirebaseAuth _auth = FirebaseAuth.instance;

  void listenToAuthChanges() {
    _auth.userChanges().listen((User? user) async {
      if (user == null) {
        currentlyLoggedInUser.value = null;
        await PushNotifications.firebaseMessaging
            .unsubscribeFromTopic("placement");
      } else {
        currentlyLoggedInUser.value = user;
        await PushNotifications.firebaseMessaging.subscribeToTopic("placement");
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
    } catch (err) {
      print(err);
      rethrow;
    }
  }

  Future<void> signOut() async {
    await _auth.signOut();
  }
}

final auth = AuthController();
