import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:go_router/go_router.dart';
import 'package:penya_business/Screens/business_registration.dart';
import 'package:penya_business/Screens/sign_in.dart';
import 'package:penya_business/Screens/sign_up.dart';
import 'package:penya_business/models/user_model.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/providers/deep_link_provider.dart';

import 'Screens/store.dart';
import 'Screens/homepage.dart';
import 'Screens/new_product.dart';
import 'Screens/order_details.dart';
import 'Screens/orders.dart';
import 'Screens/product_details.dart';

final overlayProvider = StateProvider<OverlayEntry?>((ref) => null);
final storeOverlayProvider = StateProvider<OverlayEntry?>((ref) => null);

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  FirebaseFirestore.instance.settings = const Settings(
    persistenceEnabled: true,
  );
  runApp(ProviderScope(child: MyApp()));
}

class MyApp extends ConsumerStatefulWidget {

  const MyApp({super.key});

  @override
  ConsumerState<MyApp> createState() => _MyAppState();
}

class _MyAppState extends ConsumerState<MyApp> {
  @override
  void initState(){
    super.initState();
    ref.read(deepLinkProvider).handleDeepLinks((String link) {
      final productId = extractProductId(link);
      if (productId != null) {
        GoRouter.of(context).go('/product_details/$productId');
      }
    });
  }
  String? extractProductId(String link) {
    Uri uri = Uri.parse(link);
    return uri.queryParameters['id'];
  }
  GoRouter _router(AsyncValue<UserModel?> authState){
    return GoRouter(
      initialLocation: '/',
      routes: [
    GoRoute(
      path: '/',
      redirect: (context, state){
        if(authState.value == null){
          return '/signin';
        }
        return '/store';
      }
    ),
    GoRoute(
      path: '/signin',
      builder: (context, state) => Signin(),
    ),
    GoRoute(
      path: '/signup',
      builder: (context, state) => Signup(),
    ),
    GoRoute(
      path: '/business_registration',
      builder: (context, state) => BusinessRegistration(),
    ),
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
      path: '/product',
      builder: (context, state) => NewProduct(productId: ''),
    ),
    GoRoute(
      path: '/product_details/:id',
      builder: (context, state) {
        final String productId = state.pathParameters['id']!;
        return ProductDetails(productId: productId);
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
  ]

    );
  }
  // final GoRouter _router = GoRouter(
  //   routes: [
  //   GoRoute(
  //     path: '/',
  //     builder: (context, state) => Dashboard(),
  //   ),
  //   GoRoute(
  //     path: '/business_registration',
  //     builder: (context, state) => BusinessRegistration(),
  //   ),
  //   GoRoute(
  //     path: '/store',
  //     builder: (context, state) => Store(),
  //   ),
  //   GoRoute(
  //     path: '/orders',
  //     builder: (context, state) => OrdersDash(),
  //   ),
  //   GoRoute(
  //     path: '/orders/:id',
  //     builder: (context, state) {
  //       final String orderId = state.pathParameters['id']!;
  //       return OrderDetails(orderId: orderId);
  //     },
  //   ),
  //   GoRoute(
  //     path: '/product',
  //     builder: (context, state) => NewProduct(productId: ''),
  //   ),
  //   GoRoute(
  //     path: '/product_details/:id',
  //     builder: (context, state) {
  //       final String productId = state.pathParameters['id']!;
  //       return ProductDetails(productId: productId);
  //     },
  //   ),
  //   GoRoute(
  //     path: '/product/:id',
  //     builder: (context, state) {
  //       final String productId = state.pathParameters['id']!;
  //       return NewProduct(
  //         productId: productId,
  //       );
  //     },
  //   ),
  // ]);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {

    final authState = ref.watch(authProvider);
    return MaterialApp.router(
      routerConfig: _router(authState),
      debugShowCheckedModeBanner: false,
    );
  }
}
