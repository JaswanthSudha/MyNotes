import 'package:flutter/material.dart';
import 'package:my_app/constants/routes.dart';
import 'package:my_app/services/auth/auth_exceptions.dart';
import 'package:my_app/services/auth/auth_service.dart';

import 'package:my_app/utilities/show_error_dialog.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  late final TextEditingController _email;
  late final TextEditingController _password;
  @override
  void initState() {
    _email = TextEditingController();
    _password = TextEditingController();
    super.initState();
  }

  @override
  void dispose() {
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Login"),
      ),
      body: Column(
        children: [
          TextField(
            autocorrect: false,
            enableSuggestions: false,
            keyboardType: TextInputType.emailAddress,
            controller: _email,
            decoration: InputDecoration(hintText: "Please Enter your Email"),
          ),
          TextField(
            controller: _password,
            obscureText: true,
            enableSuggestions: false,
            autocorrect: false,
            decoration:
                InputDecoration(hintText: "Please Enter your  Password"),
          ),
          TextButton(
              onPressed: () async {
                final email = _email.text;
                final password = _password.text;
                try {
                  AuthService.firebase().logIn(mail: email, password: password);
                  final user = AuthService.firebase().currentUser;
                  final emailVerified = user?.isEmailVerified ?? false;
                  if (emailVerified) {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context)
                        .pushNamedAndRemoveUntil(notesRoute, (route) => false);
                  } else {
                    // ignore: use_build_context_synchronously
                    Navigator.of(context).pushNamedAndRemoveUntil(
                        verifyEmailRoute, (route) => false);
                  }
                } on GenericAuthException catch (_) {
                  // ignore: use_build_context_synchronously
                  await showErrorDialog(context, "Error");
                }
              },
              child: Text("Login")),
          TextButton(
              onPressed: () {
                Navigator.of(context)
                    .pushNamedAndRemoveUntil(registerRoute, (route) => false);
              },
              child: Text("Not Registered yet? Register here"))
        ],
      ),
    );
  }
}
