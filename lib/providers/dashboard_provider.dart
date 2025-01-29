import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/product.dart';
import 'package:penya_business/providers/order_provider.dart';
import 'package:penya_business/providers/product_provider.dart';

import '../models/orders_model.dart';

final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  final products = ref.watch(productsProvider);
  final orders = ref.watch(ordersProvider);
  double totalIncome =
      products.fold(0, (sum, product) => sum + (product.price * product.stock));
  int totalStock = products.fold(0, (sum, product) => sum + product.stock);
  double conversionRateCalculator(List<Product> productz){
    if(productz.isEmpty) return 0.0;
    double totalConversionRate = productz.fold(0.0, (sum, product) => sum + product.conversionRate);
    return totalConversionRate / productz.length;
  }
  double conversionRate = conversionRateCalculator(products);

  // double totalIncomeCalculator(List<OrdersModel> orderz){
  //   if(orders.isEmpty) return 0.0;
  //   double totalIncome = orderz.fold(0.0, (sum, product) => sum + product.products.);
  //   return totalIncome;
  // }

  return DashboardStats(
    totalIncome: totalIncome,
    totalStock: totalStock,
    outOfStock: products.where((product) => product.stock == 0).length,
    pendingOrders: orders.where((order) => order.status == 'pending').length,
    conversionRate: conversionRate,
  );
});

class DashboardStats {
  final double totalIncome;
  final int totalStock;
  final int pendingOrders;
  final double conversionRate;
  final int outOfStock;

  DashboardStats(
      {
        required this.totalIncome,
        required this.conversionRate,
        required this.pendingOrders,
        required this.totalStock,
        required this.outOfStock,
      });
}
