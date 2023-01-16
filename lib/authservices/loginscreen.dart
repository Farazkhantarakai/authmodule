import 'package:authmodule/authservices/signupscreen.dart';
import 'package:authmodule/providers/auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  static const routName = 'login';

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController _emailController = TextEditingController();

  final TextEditingController _passwordController = TextEditingController();
  bool? isloading = false;
  var formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    var mdq = MediaQuery.of(context).size;
    var auth = Provider.of<Auth>(context);
    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 88, 104, 245),
      body: SafeArea(
          child: Column(
        children: [
          //welcome back portion
          Expanded(
            flex: 1,
            child: Container(
              width: double.infinity,
              height: mdq.height * 0.3,
              decoration: const BoxDecoration(),
              child: Stack(children: [
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: const [
                    Center(
                      child: Text(
                        'Welcome back',
                        style: TextStyle(
                            fontSize: 35,
                            fontWeight: FontWeight.bold,
                            color: Colors.white),
                      ),
                    ),
                  ],
                ),
                Positioned(
                    top: -30,
                    right: 50,
                    child: Stack(
                      children: [
                        Container(
                          width: 80,
                          height: 80,
                          decoration: const BoxDecoration(
                            shape: BoxShape.circle,
                            color: Color.fromARGB(255, 245, 192, 151),
                          ),
                          child: ShaderMask(
                            shaderCallback: (rect) {
                              return const LinearGradient(
                                  begin: Alignment.topCenter,
                                  end: Alignment.bottomCenter,
                                  colors: [
                                    Color.fromARGB(255, 18, 71, 247),
                                    Color.fromARGB(206, 43, 111, 236)
                                  ]).createShader(
                                  Rect.fromLTRB(0, 0, rect.width, rect.height));
                            },
                            blendMode: BlendMode.dstIn,
                            // child: e,
                          ),
                        ),
                      ],
                    ))
              ]),
            ),
          ),

          //login screen
          Expanded(
            flex: 2,
            child: Container(
              padding: const EdgeInsets.all(10),
              decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                      topLeft: Radius.circular(20),
                      topRight: Radius.circular(20))),
              child: Padding(
                padding: const EdgeInsets.all(20),
                child: Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      const Text(
                        'Login',
                        style: TextStyle(
                            color: Colors.black, fontWeight: FontWeight.bold),
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
                                } else if (!value.endsWith('@gmail.com')) {
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
                                  contentPadding: EdgeInsets.only(left: 2),
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
                      const Text(
                        'Forgot Password?',
                        style: TextStyle(color: Colors.blue),
                      ),
                      Center(
                        child: InkWell(
                          onTap: () {
                            print('i am pressed');
                            if (formKey.currentState!.validate()) {
                              return;
                            }

                            formKey.currentState!.save();
                            setState(() {});

                            auth.signInUser(_emailController.text,
                                _passwordController.text);
                          },
                          child: Container(
                            width: mdq.width * 0.6,
                            height: 60,
                            decoration: const BoxDecoration(
                                color: Color.fromARGB(255, 88, 104, 245),
                                borderRadius:
                                    BorderRadius.all(Radius.circular(20))),
                            child: const Center(
                                child: Text(
                              'LogIn',
                              style: TextStyle(color: Colors.white),
                            )),
                          ),
                        ),
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, SignUpScreen.routName);
                        },
                        child: const Center(
                          child: Text(
                            'Create Account',
                            style: TextStyle(color: Colors.blue),
                          ),
                        ),
                      )
                    ],
                  ),
                ),
              ),
            ),
          )
        ],
      )),
    );
  }
}
