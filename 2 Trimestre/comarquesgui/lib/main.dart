import 'package:comarquesgui/screens/provincies_screen.dart';
import 'package:comarquesgui/themes/tema_comarques.dart';
import 'package:flutter/material.dart';

void main() => runApp(const MyApp());

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Les nostres comarques',
      debugShowCheckedModeBanner: false,
      theme: temaComarques,
      home: const Scaffold(
        body: ProvinciesScreen(),
      ),
    );
  }
}
