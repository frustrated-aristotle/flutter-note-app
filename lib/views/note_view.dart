import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

enum MenuAction { logout }

class NoteView extends StatefulWidget {
  const NoteView({super.key});

  @override
  State<NoteView> createState() => _NoteViewState();
}

class _NoteViewState extends State<NoteView> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Notes"), actions: [
        PopupMenuButton(
          onSelected: (value) async {
            switch(value){

              case MenuAction.logout:
                final shouldLogOut = await showLogOutDialog(context);
                if(shouldLogOut)
                  {
                    await FirebaseAuth.instance.signOut();
                    Navigator.of(context).pushNamedAndRemoveUntil('/login/', (_) => false);
                  }
            }
          },
          itemBuilder: (context) {
            return const [
              PopupMenuItem<MenuAction>(
                value: MenuAction.logout,
                child: Text("Logout"),
              ),
            ];
          },
        )
      ]),
      body: Center(
        child: Text("Main UI"),
      ),
    );
  }
}

Future<bool> showLogOutDialog(BuildContext context) {
  return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: const Text("Sign Out"),
          content: const Text("Do you want to sign out?"),
          actions: [
            TextButton(onPressed: () {
              Navigator.of(context).pop(false);
            }, child: const Text(("Cancel"))),
            TextButton(onPressed: () {
              Navigator.of(context).pop(true);
            }, child: const Text(("Sign Out"))),
          ],
        );
      },
  ).then((value) => value ?? false);
}
