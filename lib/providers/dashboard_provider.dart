import 'package:flutter_riverpod/flutter_riverpod.dart';
// import 'package:penya_business/models/product.dart';
import 'package:penya_business/providers/order_provider.dart';
import 'package:penya_business/providers/product_provider.dart';

// import '../models/orders_model.dart';

final dashboardStatsProvider = Provider<DashboardStats>((ref) {
  final productsAsync = ref.watch(productsProvider);
  final orders = ref.watch(ordersProvider);
  double totalIncome = productsAsync.when(
    data: (products) => products.fold(
        0, (sum, product) => sum + (product.price * product.checkedOut)),
    error: (error, stackTrace) => 0,
    loading: () => 0,
  );
  // products.fold(0, (sum, product) => sum + (product.price * product.stock));
  int totalStock = productsAsync.when(
    data: (products) => products.fold(0, (sum, product) => sum + product.stock),
    error: (error, stackTrace) => 0,
    loading: () => 0,
  );
  // products.fold(0, (sum, product) => sum + product.stock);
  double conversionRateCalculator() {
    if (productsAsync.value == null) return 0.0;
    double totalConversionRate = productsAsync.when(
      data: (product) =>
          product.fold(0.0, (sum, product) => sum + product.conversionRate),
      error: (error, stackTrace) => 0.0,
      loading: () => 0.0,
    );
    // productsAsync.value!
    //     .fold(0.0, (sum, product) => sum + product.conversionRate);
    if (productsAsync.value!.isEmpty) return 0.0;
    return totalConversionRate / productsAsync.value!.length;
    // if (productz.isEmpty) return 0.0;
    // double totalConversionRate =
    //     productz.fold(0.0, (sum, product) => sum + product.conversionRate);
    // return totalConversionRate / productz.length;
  }

  double conversionRate = conversionRateCalculator();

  // double totalIncomeCalculator(List<OrdersModel> orderz){
  //   if(orders.isEmpty) return 0.0;
  //   double totalIncome = orderz.fold(0.0, (sum, product) => sum + product.products.);
  //   return totalIncome;
  // }

  return DashboardStats(
    totalIncome: totalIncome,
    totalStock: totalStock,
    outOfStock: productsAsync.when(
      data: (product) => product.where((product) => product.stock == 0).length,
      error: (error, stacktrace) => 0,
      loading: () => 0,
    ),
    // productsAsync.value!.where((product) => product.stock == 0).length,
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

  DashboardStats({
    required this.totalIncome,
    required this.conversionRate,
    required this.pendingOrders,
    required this.totalStock,
    required this.outOfStock,
  });
}
