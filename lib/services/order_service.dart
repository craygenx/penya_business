import 'package:penya_business/models/orders_model.dart';

import '../models/data.dart';

class OrderService {
  final List<OrdersModel> _orders = orders;
  List<OrdersModel> fetchProducts() {
    return _orders;
  }

  void addProduct(OrdersModel order) {
    _orders.add(order);
  }

  void updateProduct(String id, OrdersModel updatedOrder) {
    final index = _orders.indexWhere((p) => p.orderId == id);
    if (index != -1) _orders[index] = updatedOrder;
  }

  void deleteProduct(String id) {
    _orders.removeWhere((p) => p.orderId == id);
  }
}
