// import 'package:penya_business/models/product.dart';
//
// class OrdersModel {
//   final String orderId;
//   final String customerId;
//   final List<Product> products;
//   final String totalAmount;
//   final String status;
//
//   OrdersModel({required this.orderId,required this.customerId,required this.products,required this.totalAmount,required this.status});
//
//   OrdersModel copyWith({
//     String? orderId,
//     String? customerId,
//     List<Product>? products,
//     String? totalAmount,
//     String? status,
//   }) {
//     return OrdersModel(
//         orderId: orderId ?? this.orderId,
//         customerId: customerId ?? this.customerId,
//         products: products ?? this.products,
//         totalAmount: totalAmount ?? this.totalAmount,
//         status: status ?? this.status);
//   }
// }
import 'package:penya_business/models/product.dart';

class OrdersModel {
  final String orderId;
  final String customerId;
  final List<Product> products;
  final String totalAmount;
  final String status;

  OrdersModel({required this.orderId,required this.customerId,required this.products,required this.totalAmount,required this.status});

  Map<String, dynamic> toMap() {
    return {
      'orderId': orderId,
      'customerId': customerId,
      'products': products.map((product) => product.toMap()).toList(),
      'totalAmount': totalAmount,
    };
  }
  factory OrdersModel.fromMap(Map<String, dynamic> map) {
    return OrdersModel(
      orderId: map['orderId'],
      customerId: map['customerId'],
      products: List<Product>.from(map['products'].map((x) => Product.fromFirestore(x))),
      totalAmount: map['totalAmount'],
      status: '',
    );
  }
}