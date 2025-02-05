import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';

import 'Screens/Store.dart';
import 'Screens/homepage.dart';
import 'Screens/new_product.dart';
import 'Screens/order_details.dart';
import 'Screens/orders.dart';

final overlayProvider = StateProvider<OverlayEntry?>((ref) => null);
final storeOverlayProvider = StateProvider<OverlayEntry?>((ref) => null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initialize();
  runApp(ProviderScope(child: MyApp()));
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
      builder: (context, state) {
        final String orderId = state.pathParameters['id']!;
        return OrderDetails(orderId: orderId);
      },
    ),
    GoRoute(
      path: '/product/:id',
      builder: (context, state) {
        final String productId = state.pathParameters['id']!;
        return NewProduct(
          productId: productId,
        );
      },
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
