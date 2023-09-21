import "package:my_app/services/auth/auth_user.dart";

abstract class AuthProvider {
  AuthUser? get currentUser;
  Future<AuthUser?> logIn({
    required String mail,
    required String password,
  });
  Future<AuthUser?> createUser({
    required String mail,
    required String password,
  });
  Future<void> logOut();
  Future<void> sendEmailVerification();
  Future<void> intialization();
}
