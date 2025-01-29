import 'package:flutter_riverpod/flutter_riverpod.dart';

import 'order_provider.dart';

final ordersStatsProvider = Provider<OrdersStats>((ref) {
  final orders = ref.watch(ordersProvider);


  return OrdersStats(
      pendingOrders: orders.where((order) => order.status == 'pending').length,
      deliveredOrders: orders.where((order) => order.status == 'delivered').length,
      canceledOrders: orders.where((order) => order.status == 'cancelled').length,
      totalOrders: orders.length,
  );
});

class OrdersStats{
  final int pendingOrders;
  final int deliveredOrders;
  final int canceledOrders;
  final int totalOrders;

  OrdersStats({
      required this.pendingOrders,
      required this.totalOrders,
      required this.deliveredOrders,
      required this.canceledOrders,
  });
}