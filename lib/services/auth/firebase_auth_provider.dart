import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:my_app/firebase_options.dart';
import "package:my_app/services/auth/auth_provider.dart";
import "package:my_app/services/auth/auth_user.dart";
import 'package:my_app/services/auth/auth_exceptions.dart';
import 'package:firebase_auth/firebase_auth.dart'
    show FirebaseAuth, FirebaseAuthException;

class FirebaseAuthProvider implements AuthProvider {
  @override
  Future<AuthUser?> createUser({
    required String mail,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .createUserWithEmailAndPassword(email: mail, password: password);
      final user = currentUser;

      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'weak-password') {
        throw WeakPasswordAuthException();
      } else if (e.code == "email-already-in-user") {
        throw EmailAlreadyInUsedAuthException();
      } else if (e.code == "invalid-email") {
        throw InvalidEmailAuthException();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  AuthUser? get currentUser {
    final user = FirebaseAuth.instance.currentUser;
    // ignore: non_constant_identifier_names, constant_identifier_names
    if (user != null) {
      return AuthUser.fromFirebase(user);
    } else {
      return null;
    }
  }

  @override
  Future<AuthUser?> logIn({
    required String mail,
    required String password,
  }) async {
    try {
      await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: mail, password: password);
      final user = currentUser;
      if (user != null) {
        return user;
      } else {
        throw UserNotLoggedInAuthException();
      }
    } on FirebaseAuthException catch (e) {
      if (e.code == 'user-not-found') {
        throw UserNotFoundAuthException();
      } else if (e.code == 'wrong-password') {
        throw WrongPasswordAuthExcepton();
      } else {
        throw GenericAuthException();
      }
    } catch (_) {
      throw GenericAuthException();
    }
  }

  @override
  Future<void> logOut() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await FirebaseAuth.instance.signOut();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> sendEmailVerification() async {
    final user = FirebaseAuth.instance.currentUser;
    if (user != null) {
      await user.sendEmailVerification();
    } else {
      throw UserNotLoggedInAuthException();
    }
  }

  @override
  Future<void> intialization() async {
    await Firebase.initializeApp(
      options: DefaultFirebaseOptions.currentPlatform,
    );
  }
}
