import 'package:flutter/material.dart';
import 'package:my_app/constants/routes.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:my_app/views/login_view.dart';
import 'package:my_app/views/notes_view.dart';
import 'package:my_app/views/register_view.dart';
import 'package:my_app/views/verify_email_view.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(
    MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: HomePage(),
      routes: {
        loginRoute: (context) => const LoginView(),
        registerRoute: (context) => const RegisterView(),
        notesRoute: (context) => const NotesView(),
        verifyEmailRoute: (context) => const VerifyEmailView()
      },
    ),
  );
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
        future: AuthService.firebase().intialization(),
        builder: ((context, snapshot) {
          switch (snapshot.connectionState) {
            case ConnectionState.done:
              final user = AuthService.firebase().currentUser;
              print(user);
              final isEmailVerfied = user?.isEmailVerified ?? false;
              if (user != null) {
                if (isEmailVerfied) {
                  return const NotesView();
                } else {
                  return const VerifyEmailView();
                }
              } else {
                return const LoginView();
              }

            default:
              return CircularProgressIndicator();
          }
        }));
  }
}
