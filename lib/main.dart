import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:noteapp/views/login_view.dart';
import 'firebase_options.dart';

void main() {
  runApp(MaterialApp(
    title: 'Flutter Demo',
    theme: ThemeData(
      colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepPurple),
      useMaterial3: true,
    ),
    home: const HomePage(),
  ));
}

class HomePage extends StatelessWidget {
  const HomePage({super.key});

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
                final user = FirebaseAuth.instance.currentUser;
                print(user);
                if(user?.emailVerified ?? false)
                {
                  print("Verified");
                }
                else
                {
                  //Navigator.of(context).push(MaterialPageRoute(builder: (context)=> const VerifyView()));
                  return const VerifyView();
                  print("Non Verified");
                }
                  
                return const Text("Done!");
              default:
                return const Text("Connecting...");
            }
          },
        ),
      ),
    );
  }
}

class VerifyView extends StatelessWidget {
  const VerifyView({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Text("Please verify your email."),
        TextButton(onPressed: () async {
            final user = FirebaseAuth.instance.currentUser;
            await user?.sendEmailVerification();
        }, child: Text("Send registration mail."))
      ],
    );
  }
}

/*
class _MyHomePageState extends State<MyHomePage> {
  int _counter = 0;

  void _incrementCounter() {
    setState(() {
      _counter++;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: Text(widget.title),
      ),
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: <Widget>[
            const Text(
              'You have pushed the button this many times:',
            ),
            Text(
              '$_counter',
              style: Theme.of(context).textTheme.headlineMedium,
            ),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: _incrementCounter,
        tooltip: 'Increment',
        child: const Icon(Icons.add),
      ), // This trailing comma makes auto-formatting nicer for build methods.
    );
  }
}
*/