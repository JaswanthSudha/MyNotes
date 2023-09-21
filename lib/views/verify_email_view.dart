import 'package:flutter/material.dart';
import 'package:my_app/constants/routes.dart';
import 'package:my_app/services/auth/auth_service.dart';

class VerifyEmailView extends StatefulWidget {
  const VerifyEmailView({super.key});

  @override
  State<VerifyEmailView> createState() => _VerifyEmailViewState();
}

class _VerifyEmailViewState extends State<VerifyEmailView> {
  @override
  Widget build(BuildContext context) {
    final user = AuthService.firebase().currentUser;
    print(user?.isEmailVerified);
    return Scaffold(
      appBar: AppBar(title: Text("Verify Email")),
      body: Column(
        children: [
          Text("We have sent a verification Email please check it"),
          Text("Please click below if mail is not generated"),
          TextButton(
              onPressed: () async {
                try {
                  AuthService.firebase().sendEmailVerification();
                } catch (e) {
                  print("Email verification failed");
                  print(e);
                }
              },
              child: Text("Send Email Verification")),
          TextButton(
              onPressed: () async {
                AuthService.firebase().logOut();
                // ignore: use_build_context_synchronously
                Navigator.of(context).pushNamedAndRemoveUntil(
                  registerRoute,
                  (route) => false,
                );
              },
              child: const Text("Restart"))
        ],
      ),
    );
  }
}
