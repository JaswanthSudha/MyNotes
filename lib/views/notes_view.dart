import 'package:flutter/material.dart';
import 'package:my_app/constants/routes.dart';
import 'package:my_app/enums/menu_action.dart';
import 'package:my_app/services/auth/auth_service.dart';
import 'package:my_app/services/crud/notes_service.dart';

class NotesView extends StatefulWidget {
  const NotesView({super.key});

  @override
  State<NotesView> createState() => _NotesViewState();
}

class _NotesViewState extends State<NotesView> {
  late final NotesService _notesService2;
  @override
  void initState() {
    _notesService2.open();
    super.initState();
  }

  @override
  void dispose() {
    // _notesService.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Main UI"),
        actions: [
          PopupMenuButton<MenuAction>(onSelected: (value) async {
            switch (value) {
              case MenuAction.logout:
                final shouldLogout = await showLogOutDialog(context);
                if (shouldLogout) {
                  AuthService.firebase().logOut();
                  // ignore: use_build_context_synchronously
                  Navigator.of(context)
                      .pushNamedAndRemoveUntil(loginRoute, (route) => false);
                } else {
                  return;
                }
                break;
            }
          }, itemBuilder: (context) {
            return [
              PopupMenuItem(value: MenuAction.logout, child: Text("Logout"))
            ];
          })
        ],
      ),
      body: Text("done"),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog<bool>(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text("Sign out"),
          content: Text("Are you sure you want to sign out"),
          actions: [
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(false);
                },
                child: Text("Cancel")),
            TextButton(
                onPressed: () {
                  Navigator.of(context).pop(true);
                },
                child: Text("Log out"))
          ],
        );
      }).then((value) => value ?? false);
}
