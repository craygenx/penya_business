import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/orders_model.dart';

import '../services/order_service.dart';

final orderServiceProvider = Provider((ref) => OrderService());
final ordersProvider =
StateNotifierProvider<OrderNotifier, List<OrdersModel>>((ref) {
  final OrderService = ref.read(orderServiceProvider);
  return OrderNotifier(OrderService);
});

class OrderNotifier extends StateNotifier<List<OrdersModel>>{
  final OrderService _orderService;
  OrderNotifier(this._orderService) : super([]) {
    loadOrders();
  }

  void loadOrders() {
    state = _orderService.fetchProducts();
  }

  // void addProducts(OrdersModel order) {
  //   _orderService.addProduct(order);
  //   loadOrders();
  // }

  // void updateProducts(String id, OrdersModel order) {
  //   _orderService.updateProduct(id, updatedOrder);
  //   loadOrders();
  // }

  // void deleteProduct(String id) {
  //   _orderService.deleteProduct(id);
  //   loadOrders();
  // }
}
// final ordersProvider = StateNotifierProvider<OrderNotifier, List<OrdersModel>>((ref){
//   return OrderNotifier();
// });
// class OrderNotifier extends StateNotifier<List<OrdersModel>>{
//   OrderNotifier():super([]);
//   void addOrder(OrdersModel orderModel) {
//     state = [...state, orderModel];
//   }
//
//   void updateOrder(String id, OrdersModel updatedOrdersModel) {
//     state = [
//       for (final order in state)
//         if(order.orderId == id) updatedOrdersModel else order,
//     ];
//   }
//
//   void deleteOrder(String id){
//     state = state.where((order)=> order.orderId != id).toList();
//   }
// }