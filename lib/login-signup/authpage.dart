import 'package:flutter/material.dart';
import 'package:grocery/login-signup/loginpage.dart';
import 'package:grocery/login-signup/signinpage.dart';

class AuthPage extends StatefulWidget {
  const AuthPage({super.key});

  @override
  State<AuthPage> createState() => AuthPageState();
}

class AuthPageState extends State<AuthPage> {
  bool loginpage = true;

  void toggleScreen() {
    setState(() {
      loginpage = !loginpage;
    });
  }

  @override
  Widget build(BuildContext context) {
    if (loginpage) {
      return LoginPage(signinpage: toggleScreen);
    } else {
      return SigninPage(loginpage: toggleScreen);
    }
  }
}
