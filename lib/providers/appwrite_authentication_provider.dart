import 'package:appwrite/appwrite.dart';
import 'package:appwrite/models.dart';
import 'package:project_haajar/providers/appwrite_client.dart';
import 'package:riverpod_annotation/riverpod_annotation.dart';

part 'appwrite_authentication_provider.g.dart';

@riverpod
class AppwriteAuthentication extends _$AppwriteAuthentication {
  @override
  Future<User> build() async {
    final account = ref.read(appwriteProvider);
    return await account.get();
  }

  Future<User> registerUser(String email, String password, String name) async {
    final account = ref.read(appwriteProvider);
    return await account.create(
      userId: ID.unique(),
      email: email,
      password: password,
      name: name,
    );
  }

  Future<Session> loginUser(String email, String password) async {
    final account = ref.read(appwriteProvider);
    return await account.createEmailSession(
      email: email,
      password: password,
    );
  }

  Future<void> logoutUser() async {
    final account = ref.read(appwriteProvider);
    return await account.deleteSession(sessionId: 'current');
  }
}
