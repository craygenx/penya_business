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

