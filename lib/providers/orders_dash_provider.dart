// import 'package:flutter_riverpod/flutter_riverpod.dart';

// import 'order_provider.dart';

// final ordersStatsProvider = Provider<OrdersStats>((ref) {
//   final orders = ref.watch(ordersProvider);


//   return OrdersStats(
//       pendingOrders: orders.where((order) => order.status == 'pending').length,
//       deliveredOrders: orders.where((order) => order.status == 'delivered').length,
//       canceledOrders: orders.where((order) => order.status == 'cancelled').length,
//       totalOrders: orders.length,
//   );
// });

// class OrdersStats{
//   final int pendingOrders;
//   final int deliveredOrders;
//   final int canceledOrders;
//   final int totalOrders;

//   OrdersStats({
//       required this.pendingOrders,
//       required this.totalOrders,
//       required this.deliveredOrders,
//       required this.canceledOrders,
//   });
// }

import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/orders_model.dart';
import 'order_provider.dart';

final ordersStatsProvider = Provider<OrdersStats>((ref) {
  final orders = ref.watch(ordersProvider);

  final now = DateTime.now();
  final currentMonthStart = DateTime(now.year, now.month, 1);
  final previousMonthStart = DateTime(now.year, now.month - 1, 1);
  final previousMonthEnd = DateTime(now.year, now.month, 0); 

  List<OrdersModel> filterOrdersByMonth(List<OrdersModel> orders, DateTime start, DateTime end) {
    return orders.where((order) {
      final orderDate = order.createdAt; 
      return orderDate.isAfter(start) && orderDate.isBefore(end);
    }).toList();
  }

  final currentMonthOrders = filterOrdersByMonth(orders, currentMonthStart, now);
  final previousMonthOrders = filterOrdersByMonth(orders, previousMonthStart, previousMonthEnd);

  Map<String, int> getOrderCounts(List<OrdersModel> orders) {
    return {
      'pending': orders.where((o) => o.status == 'pending').length,
      'delivered': orders.where((o) => o.status == 'delivered').length,
      'canceled': orders.where((o) => o.status == 'cancelled').length,
      'total': orders.length,
    };
  }

  final currentStats = getOrderCounts(currentMonthOrders);
  final previousStats = getOrderCounts(previousMonthOrders);

  double calculatePercentageChange(double current, double previous) {
    if (previous == 0) return current > 0 ? 100.0 : 0.0;
    return ((current - previous) / previous) * 100;
  }

  double calculateRatio(int numerator, int denominator) {
    if (denominator == 0) return numerator > 0 ? 100.0 : 0.0;
    return (numerator / denominator) * 100;
  }

  return OrdersStats(
    pendingOrders: currentStats['pending']!,
    totalOrders: currentStats['total']!,
    deliveredOrders: currentStats['delivered']!,
    canceledOrders: currentStats['canceled']!,

    previousMonthPending: previousStats['pending']!,
    previousMonthTotal: previousStats['total']!,
    previousMonthDelivered: previousStats['delivered']!,
    previousMonthCanceled: previousStats['canceled']!,

    pendingVsTotal: calculateRatio(currentStats['pending']!, currentStats['total']!),
    pendingVsDelivered: calculateRatio(currentStats['pending']!, currentStats['delivered']!),
    pendingVsCanceled: calculateRatio(currentStats['pending']!, currentStats['canceled']!),

    pendingPercentageChange: calculatePercentageChange(currentStats['pending']!.toDouble() , previousStats['pending']!.toDouble()),
    pendingVsTotalChange: calculatePercentageChange(
        calculateRatio(currentStats['pending']!, currentStats['total']!),
        calculateRatio(previousStats['pending']!, previousStats['total']!)
    ),
    pendingVsDeliveredChange: calculatePercentageChange(
        calculateRatio(currentStats['pending']!, currentStats['delivered']!),
        calculateRatio(previousStats['pending']!, previousStats['delivered']!)
    ),
    pendingVsCanceledChange: calculatePercentageChange(
        calculateRatio(currentStats['pending']!, currentStats['canceled']!),
        calculateRatio(previousStats['pending']!, previousStats['canceled']!)
    ),
  );
});

class OrdersStats {
  final int pendingOrders;
  final int totalOrders;
  final int deliveredOrders;
  final int canceledOrders;

  final int previousMonthPending;
  final int previousMonthTotal;
  final int previousMonthDelivered;
  final int previousMonthCanceled;

  final double pendingVsTotal;
  final double pendingVsDelivered;
  final double pendingVsCanceled;

  final double pendingPercentageChange;
  final double pendingVsTotalChange;
  final double pendingVsDeliveredChange;
  final double pendingVsCanceledChange;

  OrdersStats({
    required this.pendingOrders,
    required this.totalOrders,
    required this.deliveredOrders,
    required this.canceledOrders,
    required this.previousMonthPending,
    required this.previousMonthTotal,
    required this.previousMonthDelivered,
    required this.previousMonthCanceled,
    required this.pendingVsTotal,
    required this.pendingVsDelivered,
    required this.pendingVsCanceled,
    required this.pendingPercentageChange,
    required this.pendingVsTotalChange,
    required this.pendingVsDeliveredChange,
    required this.pendingVsCanceledChange,
  });
}

