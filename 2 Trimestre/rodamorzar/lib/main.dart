import 'package:flutter/material.dart';
import 'package:rodamorzar/screens/HomeScreen.dart';
import 'package:rodamorzar/screens/LoginScreen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      initialRoute: '/',
      routes: {
        '/':(context)=> HomeScreen(),
        '/login':(context)=> LoginScreen(),
      },
    );
  }
}
