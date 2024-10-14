import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';

class PasswordresetPage extends StatefulWidget {
  const PasswordresetPage({super.key});

  @override
  State<PasswordresetPage> createState() => _PasswordresetPageState();
}

class _PasswordresetPageState extends State<PasswordresetPage> {
  var _emailresetController = TextEditingController();

  Future ResetPassword() async {
    try {
      await FirebaseAuth.instance
          .sendPasswordResetEmail(email: _emailresetController.text.trim());
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(content: Text(e.message.toString()));
          });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Center(
      child: SingleChildScrollView(
        child: Container(
          height: 200,
          width: 300,
          child: Column(
            children: [
              const Text('Enter your email to reset password'),
              const SizedBox(
                height: 10,
              ),
              TextField(
                controller: _emailresetController,
                decoration: InputDecoration(
                  hintText: 'Enter your Email',
                  prefixIcon: const Icon(Icons.mail),
                  border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(12)),
                  focusColor: const Color.fromARGB(255, 0, 73, 7),
                ),
              ),
              const SizedBox(
                height: 30,
              ),
              InkWell(
                onTap: () {
                  ResetPassword();
                },
                child: Container(
                  height: 50,
                  width: 300,
                  color: const Color.fromARGB(255, 0, 73, 7),
                  child: const Center(
                      child: Text(
                    'Reset',
                    style: TextStyle(fontSize: 16, color: Colors.white),
                  )),
                ),
              )
            ],
          ),
        ),
      ),
    ));
  }
}
