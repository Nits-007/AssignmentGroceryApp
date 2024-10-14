import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/login-signup/mainpage.dart';
import 'package:grocery/login-signup/resetpasswordpage.dart';

class LoginPage extends StatefulWidget {
  final VoidCallback signinpage;
  const LoginPage({
    Key? key,
    required this.signinpage,
  }) : super(key: key);

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  var _emailController = TextEditingController();
  var _passwordController = TextEditingController();

  Future LogIn() async {
    try {
      await FirebaseAuth.instance.signInWithEmailAndPassword(
        email: _emailController.text.trim(),
        password: _passwordController.text.trim(),
      );

      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => MainPage()),
      );
    } on FirebaseAuthException catch (e) {
      showDialog(
          context: context,
          builder: (context) {
            return AlertDialog(
              content: Text(e.message.toString()),
            );
          });
    }
  }

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: Stack(
      children: [
        Container(
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/images/img4.jpg'),
              fit: BoxFit.cover,
            ),
          ),
        ),
        Center(
          child: SingleChildScrollView(
            child: Card(
              elevation: 10,
              child: Column(
                children: [
                  const Text(
                    'LogIn Page',
                    style: TextStyle(
                        fontSize: 24,
                        fontWeight: FontWeight.w800,
                        color: Color.fromARGB(255, 0, 73, 7)),
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  Container(
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: _emailController,
                      decoration: InputDecoration(
                        hintText: 'Enter your Email',
                        prefixIcon: Icon(Icons.mail),
                        border: OutlineInputBorder(
                            borderRadius: BorderRadius.circular(12)),
                        focusColor: const Color.fromARGB(255, 0, 73, 7),
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Container(
                    height: 120,
                    width: 300,
                    child: Column(
                      children: [
                        TextField(
                          controller: _passwordController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Enter your Password',
                            prefixIcon: const Icon(Icons.password),
                            border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(12)),
                            focusColor: const Color.fromARGB(255, 0, 73, 7),
                          ),
                        ),
                        const SizedBox(
                          height: 10,
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            const Text('Does not have account ? '),
                            InkWell(
                                onTap: widget.signinpage,
                                child: const Text(
                                  'Sign Up',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.start,
                          children: [
                            InkWell(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              PasswordresetPage()));
                                },
                                child: const Text('Forgot Password',
                                    style: TextStyle(color: Colors.blue))),
                          ],
                        )
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      LogIn();
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      color: const Color.fromARGB(255, 0, 73, 7),
                      child: const Center(
                          child: Text(
                        'LogIn',
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      )),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ],
    ));
  }
}
