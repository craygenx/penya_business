import 'package:flutter/material.dart';
import 'package:penya_business/Screens/sign_up.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penya business',
      home: const Signup(),
    );
  }
}
