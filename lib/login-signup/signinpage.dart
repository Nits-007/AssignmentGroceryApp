import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:grocery/login-signup/mainpage.dart';

class SigninPage extends StatefulWidget {
  final VoidCallback loginpage;
  const SigninPage({
    Key? key,
    required this.loginpage,
  }) : super(key: key);

  @override
  State<SigninPage> createState() => _SigninPageState();
}

class _SigninPageState extends State<SigninPage> {
  var _emailnewController = TextEditingController();
  var _passwordnewController = TextEditingController();
  var _firstnameController = TextEditingController();
  var _lastnameController = TextEditingController();
  var _ageController = TextEditingController();
  var _phoneController = TextEditingController();

  Future SignUp() async {
    try {
      await FirebaseAuth.instance.createUserWithEmailAndPassword(
        email: _emailnewController.text.trim(),
        password: _passwordnewController.text.trim(),
      );
      await SaveInfo(
        _firstnameController.text.trim(),
        _lastnameController.text.trim(),
        _emailnewController.text.trim(),
        int.parse(_ageController.text.trim()),
        int.parse(_phoneController.text.trim()),
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

  Future SaveInfo(String firstName, String lastName, String email, int age,
      int phone) async {
    await FirebaseFirestore.instance.collection('users').add({
      'first name': firstName,
      'last name': lastName,
      'email id': email,
      'age': age,
      'phone': phone,
    });
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
                    'Sign In Page',
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
                      controller: _firstnameController,
                      decoration: InputDecoration(
                        hintText: 'First Name : ',
                        prefixIcon: const Icon(Icons.text_rotation_none),
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
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: _lastnameController,
                      decoration: InputDecoration(
                        hintText: 'Last Name : ',
                        prefixIcon: const Icon(Icons.text_rotation_none),
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
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: _phoneController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Phone No. : ',
                        prefixIcon: const Icon(Icons.numbers),
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
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: _ageController,
                      keyboardType: TextInputType.number,
                      decoration: InputDecoration(
                        hintText: 'Age : ',
                        prefixIcon: const Icon(Icons.numbers),
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
                    height: 50,
                    width: 300,
                    child: TextField(
                      controller: _emailnewController,
                      decoration: InputDecoration(
                        hintText: 'Email',
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
                    height: 90,
                    width: 300,
                    child: Column(
                      children: [
                        TextField(
                          controller: _passwordnewController,
                          obscureText: true,
                          decoration: InputDecoration(
                            hintText: 'Password',
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
                            const Text('Already have an account ?'),
                            InkWell(
                                onTap: widget.loginpage,
                                child: const Text(
                                  'Log In',
                                  style: TextStyle(color: Colors.blue),
                                )),
                          ],
                        ),
                      ],
                    ),
                  ),
                  const SizedBox(
                    height: 30,
                  ),
                  InkWell(
                    onTap: () {
                      SignUp();
                    },
                    child: Container(
                      height: 50,
                      width: 300,
                      color: const Color.fromARGB(255, 0, 73, 7),
                      child: const Center(
                          child: Text(
                        'SignUp',
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
