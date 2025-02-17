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

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penya_business/models/product.dart';

class OrdersModel {
  final String orderId;
  final String customerId;
  final List<String> productIds;
  final List<Product> products; // Add products list
  final String totalAmount;
  final String status;

  OrdersModel({
    required this.orderId,
    required this.customerId,
    required this.productIds,
    this.products = const [], // Default to empty list
    required this.totalAmount,
    required this.status,
  });

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'productIds': productIds,
      'totalAmount': totalAmount,
      'status': status,
    };
  }

  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderId: map['orderId'],
      customerId: map['customerId'],
      productIds: List<String>.from(map['productIds'] ?? []),
      totalAmount: map['totalAmount'],
      status: map['status'] ?? '',
    );
  }

  // Fetch products from Firestore
  Future<List<Product>> fetchProducts(FirebaseFirestore firestore) async {
    if (productIds.isEmpty) return [];

    List<Product> products = [];
    for (String productId in productIds) {
      DocumentSnapshot doc = await firestore.collection('products').doc(productId).get();
      if (doc.exists) {
        products.add(Product.fromFirestore(doc));
      }
    }
    return products;
  }

  // CopyWith method to attach products
  OrdersModel copyWith({
    List<Product>? products,
  }) {
    return OrdersModel(
      orderId: orderId,
      customerId: customerId,
      productIds: productIds,
      products: products ?? this.products,
      totalAmount: totalAmount,
      status: status,
    );
  }
}
