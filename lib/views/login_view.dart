import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/firebase_options.dart';

class LoginView extends StatefulWidget {
  const LoginView({super.key});

  @override
  State<LoginView> createState() => _LoginViewState();
}

class _LoginViewState extends State<LoginView> {
  //TextEditingController
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
        title: Text("Note App"),
        backgroundColor: Colors.amber,
      ),
      body: Center(
        child: FutureBuilder(
          future: Firebase.initializeApp(
            options: DefaultFirebaseOptions.currentPlatform,
          ),
          builder: (context, snapshot) {
            switch (snapshot.connectionState)
            {
              case ConnectionState.done:
                return Column(
                  children: [

                    TextField(
                      controller: _email,
                      keyboardType: TextInputType.emailAddress,
                      decoration: const InputDecoration(
                        hintText: "Your email:",
                      ),
                    ),
                    TextField(
                      controller: _password,
                      obscureText: true,
                      enableSuggestions: false,
                      autocorrect: false,
                      decoration: const InputDecoration(
                        hintText: "Your password:",
                      ),
                    ),
                    TextButton(
                      onPressed: () async
                      {
                        try{


                        final email= _email.text;
                        final password = _password.text;
                        final userCredential = await FirebaseAuth.instance.signInWithEmailAndPassword(email: email, password: password);
                        print(userCredential);
                        }
                        on FirebaseAuthException catch (e){
                          if(e.code == "user-not-found")
                            print("User can not found. Try again");
                          else if(e.code == "weak-password")
                            print("Weak password. Try a different password.");
                          else if(e.code == "email-already-in-use")
                            print("Email is in use.");
                          else if(e.code == "invalid-email")
                            print("Invalid email.");
                        }
                      },
                      child: Text("Login"),
                    ),
                  ],
                );
              default:
                return const Text("Connecting...");
            }
          },
        ),
      ),
    );
  }
}