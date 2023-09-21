import "package:firebase_core/firebase_core.dart";
import "package:my_app/firebase_options.dart";
import "package:my_app/services/auth/auth_provider.dart";
import "package:my_app/services/auth/auth_user.dart";
import "package:my_app/services/auth/firebase_auth_provider.dart";

class AuthService implements AuthProvider {
  final AuthProvider provider;
  const AuthService(this.provider);
  factory AuthService.firebase() => AuthService(FirebaseAuthProvider());

  @override
  Future<AuthUser?> createUser(
      {required String mail, required String password}) {
    return provider.createUser(mail: mail, password: password);
  }

  @override
  AuthUser? get currentUser => provider.currentUser;

  @override
  Future<AuthUser?> logIn({required String mail, required String password}) {
    return provider.logIn(mail: mail, password: password);
  }

  @override
  Future<void> logOut() async {
    provider.logOut();
  }

  @override
  Future<void> sendEmailVerification() async {
    provider.sendEmailVerification();
  }

  @override
  Future<void> intialization() => provider.intialization();
}
