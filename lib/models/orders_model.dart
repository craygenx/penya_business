import 'package:penya_business/models/product.dart';

class OrdersModel {
  final String orderId;
  final String customerId;
  final List<Product> products;
  final String totalAmount;
  final String status;

  OrdersModel({required this.orderId,required this.customerId,required this.products,required this.totalAmount,required this.status});

  OrdersModel copyWith({
    String? orderId,
    String? customerId,
    List<Product>? products,
    String? totalAmount,
    String? status,
  }) {
    return OrdersModel(
        orderId: orderId ?? this.orderId,
        customerId: customerId ?? this.customerId,
        products: products ?? this.products,
        totalAmount: totalAmount ?? this.totalAmount,
        status: status ?? this.status);
  }
}