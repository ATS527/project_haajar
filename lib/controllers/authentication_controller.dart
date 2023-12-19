import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project_haajar/config/appwrite_config.dart';
import 'package:signals/signals.dart';

class AuthenticationController {
  final _account = appwriteAccount.value;

  final currentUser = signal<User?>(null);

  late final isLoggedIn = computed(() => currentUser() != null);

  late final currentUserName = computed(() => currentUser()?.name ?? 'N/A');

  Future<User> getCurrentlyLoggedInUser() {
    return _account.get();
  }

  Future<void> initialiseUser() async {
    try {
      final user = await _account.get();
      currentUser.value = user;
    } catch (err) {
      currentUser.value = null;
    }
  }

  Future<Token> registerUser({
    required String email,
    required String password,
    required String name,
    required String role,
  }) async {
    try {
      await _account.create(
        userId: ID.unique(),
        email: email,
        password: password,
        name: name,
      );
      await _account.createEmailSession(
        email: email,
        password: password,
      );
      return await _account.createVerification(
        url: "https://haajar-app.govindsr.me/confirmation-mail-screen",
      );
    } catch (err) {
      rethrow;
    }
  }

  Future<Session> login({
    required String email,
    required String password,
  }) async {
    try {
      final Session session = await _account.createEmailSession(
        email: email,
        password: password,
      );
      currentUser.value = await _account.get();
      return session;
    } catch (err) {
      rethrow;
    }
  }

  Future<void> logoutUser() async {
    try {
      final session = await _account.deleteSession(sessionId: 'current');
      currentUser.value = null;
      return session;
    } catch (err) {
      rethrow;
    }
  }

  Future<Token> verifyEmail({
    required String userId,
    required String secret,
  }) async {
    return await _account.updateVerification(
      userId: userId,
      secret: secret,
    );
  }

  Future<Token> createPasswordRecovery({required String email}) async {
    return await _account.createRecovery(
      email: email,
      url: "https://haajar-app.govindsr.me/forgot-password",
    );
  }

  Future<Token> confirmPasswordRecovery({
    required String userId,
    required String secret,
    required String password,
    required String passwordAgain,
  }) async {
    return await _account.updateRecovery(
      userId: userId,
      secret: secret,
      password: password,
      passwordAgain: passwordAgain,
    );
  }
}

final auth = AuthenticationController();
