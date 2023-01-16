import './authservices/loginscreen.dart';
import 'package:flutter/material.dart';

class GetStartedScreen extends StatelessWidget {
  const GetStartedScreen({super.key});

  @override
  Widget build(BuildContext context) {
    var mdq = MediaQuery.of(context).size;

    return Scaffold(
      backgroundColor: const Color.fromARGB(255, 8, 135, 238),
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            const Padding(
              padding: EdgeInsets.all(25),
              child: Text(
                'Find Your Gadgets',
                softWrap: true,
                textAlign: TextAlign.center,
                style: TextStyle(
                    color: Color.fromARGB(255, 240, 240, 240),
                    fontSize: 40,
                    fontWeight: FontWeight.bold),
              ),
            ),
            InkWell(
              onTap: () {
                Navigator.of(context).pushAndRemoveUntil(
                    MaterialPageRoute(builder: (context) {
                  return const LogInScreen();
                }), (route) => false);
              },
              child: Container(
                width: mdq.width * 0.7,
                height: 60,
                decoration: const BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: const Center(
                    child: Text(
                  'Get Started',
                  style: TextStyle(
                      color: Color.fromARGB(255, 32, 53, 241),
                      fontWeight: FontWeight.bold),
                )),
              ),
            )
          ],
        ),
      ),
    );
  }
}
