import 'package:authmodule/authservices/loginscreen.dart';
import 'package:authmodule/authservices/signupscreen.dart';
import 'package:authmodule/getstaretedScreen.dart';
import 'package:authmodule/homescreen.dart';
import 'package:authmodule/providers/auth.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

void main() {
  // Provider.debugCheckInvalidValueType = null;
  runApp(const HomeApp());
}

class HomeApp extends StatefulWidget {
  const HomeApp({super.key});

  @override
  State<HomeApp> createState() => _HomeAppState();
}

class _HomeAppState extends State<HomeApp> {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [ChangeNotifierProvider.value(value: Auth())],
        child: MaterialApp(
          routes: {
            LogInScreen.routName: ((context) {
              return const LogInScreen();
            }),
            SignUpScreen.routName: ((context) {
              return const SignUpScreen();
            })
          },
          home: Consumer<Auth>(builder: (context, auth, child) {
            if (kDebugMode) {
              print(auth.isAuth);
            }
            return auth.isAuth ? const HomeScreen() : const GetStartedScreen();
          }),
        ));
  }
}
