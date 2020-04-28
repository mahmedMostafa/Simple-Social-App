import 'package:flutter/material.dart';
import 'package:my_social/sceens/auth/login_screen.dart';
import 'package:my_social/sceens/auth/register_screen.dart';
import 'package:my_social/sceens/home/home.dart';

void main() => runApp(MyApp());

class MyApp extends StatefulWidget {
  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: LoginScreen.id,
      routes: {
        LoginScreen.id :(context) =>  LoginScreen(),
        RegisterScreen.id : (context) => RegisterScreen(),
        Home.id : (context) => Home()
      },
    );
  }
}
