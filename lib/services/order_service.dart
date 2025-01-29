import 'package:penya_business/models/orders_model.dart';

import '../models/data.dart';

class OrderService {
  final List<OrdersModel> _orders = orders;
  List<OrdersModel> fetchProducts() {
    print(orders);
    return _orders;
  }
}