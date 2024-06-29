import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class VerifyView extends StatelessWidget {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Verify Email"),
        centerTitle: true,
      ),
      body: Center(
        child: Column(
          children: [
            Text("Please verify your email."),
            TextButton(
                onPressed: () async {
                  final user = FirebaseAuth.instance.currentUser;
                  await user?.sendEmailVerification();
                },
                child: Text("Send registration mail."))
          ],
        ),
      ),
    );
  }
}
