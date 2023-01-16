import 'package:authmodule/authservices/loginscreen.dart';
import 'package:authmodule/model/httpexception.dart';
import 'package:authmodule/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

import 'package:provider/provider.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  static const routName = 'signupscreen';

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();

  bool? isloading = false;

  @override
  Widget build(BuildContext context) {
    var mdq = MediaQuery.of(context).size;
    var auth = Provider.of<Auth>(context, listen: false);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 104, 245),
      body: SafeArea(
          child: isloading == true
              ? const Center(
                  child: CircularProgressIndicator(
                    color: Colors.white,
                    strokeWidth: 30,
                  ),
                )
              : Column(children: [
                  Expanded(
                    flex: 1,
                    child: Container(
                        decoration: const BoxDecoration(),
                        child: SingleChildScrollView(
                          child: Column(
                            crossAxisAlignment: CrossAxisAlignment.center,
                            children: [
                              Row(
                                children: [
                                  IconButton(
                                      onPressed: () {
                                        Navigator.pop(context);
                                      },
                                      icon: const Icon(
                                        Icons.arrow_back,
                                        size: 30,
                                        color: Colors.white,
                                      ))
                                ],
                              ),
                              const SizedBox(
                                height: 40,
                              ),
                              const Center(
                                child: Text(
                                  'SignUp',
                                  style: TextStyle(
                                      color: Colors.white,
                                      fontWeight: FontWeight.bold,
                                      fontSize: 30),
                                ),
                              ),
                            ],
                          ),
                        )),
                  ),
                  Expanded(
                    flex: 3,
                    child: Container(
                      padding: const EdgeInsets.all(20),
                      decoration: const BoxDecoration(
                          color: Colors.white,
                          borderRadius: BorderRadius.only(
                              topLeft: Radius.circular(20),
                              topRight: Radius.circular(20))),
                      child: Form(
                        key: _formKey,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                          children: [
                            const Text(
                              'Create Account',
                              style: TextStyle(
                                  color: Colors.black,
                                  fontWeight: FontWeight.bold),
                            ),
                            Container(
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.email,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Email',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _emailController,
                                    decoration: const InputDecoration(
                                        contentPadding: EdgeInsets.symmetric(
                                            vertical: 2, horizontal: 2)),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'email should not be empty';
                                      } else if (!value
                                          .endsWith('@gmail.com')) {
                                        return 'write @ gmail.com at the end ';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                            Container(
                              margin: const EdgeInsets.only(top: 10),
                              width: double.infinity,
                              decoration: const BoxDecoration(),
                              child: Column(
                                children: [
                                  Row(
                                    children: const [
                                      Icon(
                                        Icons.lock,
                                        color: Colors.grey,
                                      ),
                                      Text(
                                        'Password',
                                        style: TextStyle(color: Colors.grey),
                                      )
                                    ],
                                  ),
                                  TextFormField(
                                    controller: _passwordController,
                                    decoration: const InputDecoration(
                                        contentPadding:
                                            EdgeInsets.only(left: 2),
                                        fillColor: Colors.green),
                                    validator: (value) {
                                      if (value!.isEmpty) {
                                        return 'value cannot be empty';
                                      } else if (value.length < 6) {
                                        return 'it should be more than 6 characters';
                                      }
                                      return null;
                                    },
                                  )
                                ],
                              ),
                            ),
                            Center(
                              child: InkWell(
                                onTap: () async {
                                  if (_formKey.currentState!.validate()) {
                                    _formKey.currentState!.save();
                                    setState(() {
                                      isloading = true;
                                    });
                                    try {
                                      await auth.signUpUser(
                                          _emailController.text,
                                          _passwordController.text);
                                    } on HttpException catch (err) {
                                      print(err);
                                      if (err
                                          .toString()
                                          .contains('EMAIL_EXISTS')) {
                                        Fluttertoast.showToast(
                                            msg:
                                                'Email Already Exists Please try again');
                                      }
                                    }
                                    setState(() {
                                      isloading = false;
                                    });
                                  }
                                },
                                child: Container(
                                  width: mdq.width * 0.6,
                                  height: 60,
                                  decoration: const BoxDecoration(
                                      color: Color.fromARGB(255, 88, 104, 245),
                                      borderRadius: BorderRadius.all(
                                          Radius.circular(20))),
                                  child: const Center(
                                      child: Text(
                                    'Create Account',
                                    style: TextStyle(color: Colors.white),
                                  )),
                                ),
                              ),
                            ),
                            GestureDetector(
                              onTap: () {
                                Navigator.pushNamed(
                                    context, LogInScreen.routName);
                              },
                              child: const Center(
                                child: Text(
                                  'LogIn',
                                  style: TextStyle(color: Colors.blue),
                                ),
                              ),
                            )
                          ],
                        ),
                      ),
                    ),
                  )
                ])),
    );
  }
}
