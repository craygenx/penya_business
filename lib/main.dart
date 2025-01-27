import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import 'Screens/Store.dart';
import 'Screens/homepage.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(
            routes: [
              GoRoute(
                path: '/',
                builder: (context, state) => Dashboard(),
              ),
              GoRoute(
                path: '/store',
                builder: (context, state) => D(),
              ),
              GoRoute(
                path: '/',
                builder: (context, state) => Dashboard(),
              ),
        ]
      );
  const MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Penya business',
      home: Store(),
    );
  }
}
