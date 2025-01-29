import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'Screens/Store.dart';
import 'Screens/homepage.dart';
import 'Screens/order_details.dart';
import 'Screens/orders.dart';

void main() {
  runApp( ProviderScope(child: MyApp()) );
}

class MyApp extends StatelessWidget {
  final GoRouter _router = GoRouter(routes: [
    GoRoute(
      path: '/',
      builder: (context, state) => Dashboard(),
    ),
    GoRoute(
      path: '/store',
      builder: (context, state) => Store(),
    ),
    GoRoute(
      path: '/orders',
      builder: (context, state) => OrdersDash(),
    ),
    GoRoute(
      path: '/orders/:id',
      builder: (context, state){

        final String orderId = state.pathParameters['id']!;
        print(orderId);
        return OrderDetails(orderId: orderId);
      } ,
    ),
  ]);
  MyApp({super.key});

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
      routerConfig: _router,
    );
  }
}
