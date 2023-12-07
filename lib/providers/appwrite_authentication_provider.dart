import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_authentication_provider.g.dart';

@riverpod
class AppwriteAuthentication extends _$AppwriteAuthentication {
  late final Account _account;
  @override
  Future<User> build() async {
    _account = ref.watch(appwriteProvider);
    return await _account.get();
  }

  Future<User> getCurrentlyLoggedInUser() {
    return _account.get();
  }

  Future<Token> registerUser({
    required String email,
    required String password,
    required String name,
  }) async {
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
  }

  Future<Session> loginUser({
    required String email,
    required String password,
  }) async {
    return await _account.createEmailSession(
      email: email,
      password: password,
    );
  }

  Future<void> logoutUser() async {
    return await _account.deleteSession(sessionId: 'current');
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
