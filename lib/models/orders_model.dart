// import 'package:penya_business/models/product.dart';

// class OrdersModel {
//   final String orderId;
//   final String customerId;
//   final List<Product> products;
//   final String totalAmount;
//   final String status;

//   OrdersModel({required this.orderId,required this.customerId,required this.products,required this.totalAmount,required this.status});

//   Map<String, dynamic> toMap() {
//     return {
//       'orderId': orderId,
//       'customerId': customerId,
//       'products': products.map((product) => product.toMap()).toList(),
//       'totalAmount': totalAmount,
//     };
//   }
//   factory OrdersModel.fromMap(Map<String, dynamic> map) {
//     return OrdersModel(
//       orderId: map['orderId'],
//       customerId: map['customerId'],
//       products: List<Product>.from(map['products'].map((x) => Product.fromFirestore(x))),
//       totalAmount: map['totalAmount'],
//       status: '',
//     );
//   }
// }

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:penya_business/models/product.dart';

// class OrdersModel {
//   final String orderId;
//   final String customerId;
//   final List<String> productIds;
//   final List<Product> products; // Add products list
//   final String totalAmount;
//   final DateTime createdAt;
//   final String status;

//   OrdersModel({
//     required this.orderId,
//     required this.createdAt,
//     required this.customerId,
//     required this.productIds,
//     this.products = const [], // Default to empty list
//     required this.totalAmount,
//     required this.status,
//   });

//   Map<String, dynamic> toMap() {
//     return {
//       'orderId': orderId,
//       'customerId': customerId,
//       'productIds': productIds,
//       'totalAmount': totalAmount,
//       'createdAt': createdAt,
//       'status': status,
//     };
//   }

//   factory OrdersModel.fromMap(Map<String, dynamic> map) {
//     return OrdersModel(
//       orderId: map['orderId'],
//       customerId: map['customerId'],
//       productIds: List<String>.from(map['productIds'] ?? []),
//       createdAt: (map['createdAt'] as Timestamp).toDate(),
//       totalAmount: map['totalAmount'],
//       status: map['status'] ?? '',
//     );
//   }

//   // Fetch products from Firestore
//   Future<List<Product>> fetchProducts(FirebaseFirestore firestore) async {
//     if (productIds.isEmpty) return [];

//     List<Product> products = [];
//     for (String productId in productIds) {
//       DocumentSnapshot doc = await firestore.collection('products').doc(productId).get();
//       if (doc.exists) {
//         products.add(Product.fromFirestore(doc));
//       }
//     }
//     return products;
//   }

//   // CopyWith method to attach products
//   OrdersModel copyWith({
//     List<Product>? products,
//   }) {
//     return OrdersModel(
//       orderId: orderId,
//       customerId: customerId,
//       productIds: productIds,
//       products: products ?? this.products,
//       totalAmount: totalAmount,
//       status: status,
//       createdAt: createdAt,
//     );
//   }
// }
import 'dart:math';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penya_business/models/product.dart';

class OrdersModel {
  final String orderId;
  final String customerId;
  final List<Map<String, dynamic>> products; // [{'product_id': '123', 'quantity': 2}]
  final String totalAmount;
  final DateTime createdAt;
  final String status;

  OrdersModel({
    required this.orderId,
    required this.customerId,
    required this.products,
    required this.totalAmount,
    required this.createdAt,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'products': products, // Store product list with quantities
      'totalAmount': totalAmount,
      'createdAt': createdAt,
      'status': status,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderId: map['orderId'],
      customerId: map['customerId'],
      products: List<Map<String, dynamic>>.from(map['products'] ?? []),
      totalAmount: map['totalAmount'],
      createdAt: (map['createdAt'] as Timestamp).toDate(),
      status: map['status'] ?? '',
    );
  }

  // Fetch product details from Firestore and attach quantity
  Future<List<ProductWithQuantity>> fetchProducts(FirebaseFirestore firestore) async {
    if (products.isEmpty) return [];

    List<ProductWithQuantity> productList = [];

    for (var productMap in products) {
      String productId = productMap['product_id'];
      int quantity = productMap['quantity'];

      DocumentSnapshot doc = await firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        Product product = Product.fromFirestore(doc);
        productList.add(ProductWithQuantity(product: product, quantity: quantity));
      }
    }
    return productList;
  }

  // CopyWith method for updating products
  OrdersModel copyWith({
    List<Map<String, dynamic>>? products,
  }) {
    return OrdersModel(
      orderId: orderId,
      customerId: customerId,
      products: products ?? this.products,
      totalAmount: totalAmount,
      createdAt: createdAt,
      status: status,
    );
  }
}

// Wrapper class to attach quantity to Product
class ProductWithQuantity {
  final Product product;
  final int quantity;

  ProductWithQuantity({required this.product, required this.quantity});
}

// Function to generate random date within a given range
DateTime getRandomDate(DateTime start, DateTime end) {
  final random = Random();
  int daysBetween = end.difference(start).inDays;
  return start.add(Duration(days: random.nextInt(daysBetween + 1)));
}

// Function to generate fake orders with well-distributed dates
List<OrdersModel> generateFakeOrders() {
  List<OrdersModel> fakeOrders = [];

  // Generate orders for today
  for (int i = 0; i < 40; i++) {
    fakeOrders.add(generateFakeOrder(DateTime.now()));
  }

  // Generate orders for the current week (excluding today)
  DateTime startOfWeek = DateTime.now().subtract(Duration(days: DateTime.now().weekday - 1));
  for (int i = 0; i < 30; i++) {
    fakeOrders.add(generateFakeOrder(getRandomDate(startOfWeek, DateTime.now().subtract(Duration(days: 1)))));
  }

  // Generate orders for the current month (excluding current week)
  DateTime startOfMonth = DateTime(DateTime.now().year, DateTime.now().month, 1);
  for (int i = 0; i < 25; i++) {
    fakeOrders.add(generateFakeOrder(getRandomDate(startOfMonth, startOfWeek.subtract(Duration(days: 1)))));
  }

  // Generate orders for the previous month
  DateTime prevMonthStart = DateTime(DateTime.now().year, DateTime.now().month - 1, 1);
  DateTime prevMonthEnd = DateTime(DateTime.now().year, DateTime.now().month, 0);
  for (int i = 0; i < 20; i++) {
    fakeOrders.add(generateFakeOrder(getRandomDate(prevMonthStart, prevMonthEnd)));
  }

  // Generate orders from two months ago
  DateTime twoMonthsAgoStart = DateTime(DateTime.now().year, DateTime.now().month - 2, 1);
  DateTime twoMonthsAgoEnd = DateTime(DateTime.now().year, DateTime.now().month - 1, 0);
  for (int i = 0; i < 15; i++) {
    fakeOrders.add(generateFakeOrder(getRandomDate(twoMonthsAgoStart, twoMonthsAgoEnd)));
  }

  // Generate orders from 3 to 6 months ago
  for (int i = 0; i < 10; i++) {
    DateTime randomDate = DateTime.now().subtract(Duration(days: Random().nextInt(90) + 90)); // Between 3–6 months ago
    fakeOrders.add(generateFakeOrder(randomDate));
  }

  // Generate orders from 6 months to 1 year ago
  for (int i = 0; i < 10; i++) {
    DateTime randomDate = DateTime.now().subtract(Duration(days: Random().nextInt(180) + 180)); // Between 6–12 months ago
    fakeOrders.add(generateFakeOrder(randomDate));
  }

  return fakeOrders;
}

// Function to generate a single fake order
OrdersModel generateFakeOrder(DateTime date) {
  Random random = Random();
  List<String> statuses = ['pending', 'cancelled', 'delivered'];
  List<String> productIds = ['dcb9e63d-8853-45c8-88c9-78e7aff46c93', 'f5d8b700-9b4b-400d-8092-764948e3f797', 'f6f362d6-6556-4042-9536-08d6d6c4b06c'];
  List<String> customerIds = ['C001', 'C002', 'C003', 'C004', 'C005'];

  return OrdersModel(
    orderId: 'ORD${random.nextInt(99999)}',
    customerId: customerIds[random.nextInt(customerIds.length)],
    products: List.generate(
      random.nextInt(3) + 1, // 1 to 3 products
      (index) => {
        'product_id': productIds[random.nextInt(productIds.length)],
        'quantity': random.nextInt(5) + 1,
      },
    ),
    totalAmount: (random.nextDouble() * 1000).toStringAsFixed(2),
    createdAt: date,
    status: statuses[random.nextInt(statuses.length)],
  );
}

