import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/firstpage.dart';
import 'package:grocery/homepage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: const FirebaseOptions(
      apiKey: "AIzaSyDKTxXp5aqVMcKbNWpS5vs6qF6RDyB5Dhw",
      authDomain: "assignmentgroceryproject.firebaseapp.com",
      projectId: "assignmentgroceryproject",
      storageBucket: "assignmentgroceryproject.appspot.com",
      messagingSenderId: "297501466821",
      appId: "1:297501466821:android:a3cd97291f48e5a77b50ac",
    ),
  );
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: StreamBuilder<User?>(
        stream: FirebaseAuth.instance.authStateChanges(),
        builder: (context, snapshot) {
          if (snapshot.hasData) {
            return HomePage();
          } else {
            return FirstPage();
          }
        },
      ),
    );
  }
}
