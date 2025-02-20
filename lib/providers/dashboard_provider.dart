// import 'package:flutter_riverpod/flutter_riverpod.dart';
// // import 'package:penya_business/models/product.dart';
// import 'package:penya_business/providers/order_provider.dart';
// import 'package:penya_business/providers/product_provider.dart';

// // import '../models/orders_model.dart';

// final dashboardStatsProvider = Provider<DashboardStats>((ref) {
//   final productsAsync = ref.watch(productsProvider);
//   final orders = ref.watch(ordersProvider);
//   double totalIncome = productsAsync.when(
//     data: (products) => products.fold(
//         0, (sum, product) => sum + (product.price * product.checkedOut)),
//     error: (error, stackTrace) => 0,
//     loading: () => 0,
//   );
//   // products.fold(0, (sum, product) => sum + (product.price * product.stock));
//   int totalStock = productsAsync.when(
//     data: (products) => products.fold(0, (sum, product) => sum + product.stock),
//     error: (error, stackTrace) => 0,
//     loading: () => 0,
//   );
//   // products.fold(0, (sum, product) => sum + product.stock);
//   double conversionRateCalculator() {
//     if (productsAsync.value == null) return 0.0;
//     double totalConversionRate = productsAsync.when(
//       data: (product) =>
//           product.fold(0.0, (sum, product) => sum + product.conversionRate),
//       error: (error, stackTrace) => 0.0,
//       loading: () => 0.0,
//     );
//     // productsAsync.value!
//     //     .fold(0.0, (sum, product) => sum + product.conversionRate);
//     if (productsAsync.value!.isEmpty) return 0.0;
//     return totalConversionRate / productsAsync.value!.length;
//     // if (productz.isEmpty) return 0.0;
//     // double totalConversionRate =
//     //     productz.fold(0.0, (sum, product) => sum + product.conversionRate);
//     // return totalConversionRate / productz.length;
//   }

//   double conversionRate = conversionRateCalculator();

//   // double totalIncomeCalculator(List<OrdersModel> orderz){
//   //   if(orders.isEmpty) return 0.0;
//   //   double totalIncome = orderz.fold(0.0, (sum, product) => sum + product.products.);
//   //   return totalIncome;
//   // }

//   return DashboardStats(
//     totalIncome: totalIncome,
//     totalStock: totalStock,
//     outOfStock: productsAsync.when(
//       data: (product) => product.where((product) => product.stock == 0).length,
//       error: (error, stacktrace) => 0,
//       loading: () => 0,
//     ),
//     // productsAsync.value!.where((product) => product.stock == 0).length,
//     pendingOrders: orders.where((order) => order.status == 'pending').length,
//     conversionRate: conversionRate,
//   );
// });

// class DashboardStats {
//   final double totalIncome;
//   final int totalStock;
//   final int pendingOrders;
//   final double conversionRate;
//   final int outOfStock;

//   DashboardStats({
//     required this.totalIncome,
//     required this.conversionRate,
//     required this.pendingOrders,
//     required this.totalStock,
//     required this.outOfStock,
//   });
// }
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/orders_model.dart';
import 'package:penya_business/providers/order_provider.dart';

enum DashboardFilter { daily, weekly, sixMonths, yearly }

final dashboardFilterProvider =
    StateProvider<DashboardFilter>((ref) => DashboardFilter.daily);

final dashboardStatsProvider = FutureProvider<DashboardStats>((ref) {
  final orders = ref.watch(ordersProvider);
  final filter = ref.watch(dashboardFilterProvider);

  return calculateDashboardStats(orders, filter);
});

class DashboardStats {
  final double totalIncome;
  final double totalProfit;
  final List<FlSpot> incomeChartData;
  final List<FlSpot> profitChartData;

  DashboardStats({
    required this.totalIncome,
    required this.totalProfit,
    required this.incomeChartData,
    required this.profitChartData,
  });
}

Future<DashboardStats> calculateDashboardStats(
    List<OrdersModel> orders, DashboardFilter filter) async {
  DateTime now = DateTime.now();
  DateTime startDate;
  int totalIntervals; // Number of time intervals for chart


  int getTimeFrameIndex(DateTime orderDate, DateTime now, DashboardFilter filter) {
  switch (filter) {
    case DashboardFilter.daily:
      return now.difference(orderDate).inDays;
    case DashboardFilter.weekly:
      return (now.difference(orderDate).inDays / 7).floor();
    case DashboardFilter.sixMonths:
      return now.month - orderDate.month;
    case DashboardFilter.yearly:
      return now.month - orderDate.month;
  }
}


  switch (filter) {
    case DashboardFilter.daily:
      startDate = now.subtract(Duration(days: 6));
      totalIntervals = 7;
      break;
    case DashboardFilter.weekly:
      startDate = now.subtract(Duration(days: 28));
      totalIntervals = 4;
      break;
    case DashboardFilter.sixMonths:
      startDate = DateTime(now.year, now.month - 5, 1);
      totalIntervals = 6;
      break;
    case DashboardFilter.yearly:
      startDate = DateTime(now.year - 1, now.month, 1);
      totalIntervals = 12;
      break;
  }

  // Filter orders based on timeframe
  List<OrdersModel> filteredOrders = orders.where((order) {
    DateTime orderDate = DateTime.parse(order.createdAt.toString());
    return orderDate.isAfter(startDate);
  }).toList();

  double totalIncome = 0;
  double totalProfit = 0;

  // Map for accumulating data per interval
  Map<int, double> incomeData = {};
  Map<int, double> profitData = {};

  // Initialize map with zero values for each interval
  for (int i = 0; i < totalIntervals; i++) {
    incomeData[i] = 0;
    profitData[i] = 0;
  }

  for (var order in filteredOrders) {
  final firestore = FirebaseFirestore.instance;
  DateTime orderDate = DateTime.parse(order.createdAt.toString());
  int index = getTimeFrameIndex(orderDate, now, filter);

  // Fetch products with details before processing
  List<ProductWithQuantity> productList = await order.fetchProducts(firestore);

  for (var productWithQuantity in productList) {
    double income = productWithQuantity.product.retailPrice * productWithQuantity.quantity;
    double profit = (productWithQuantity.product.retailPrice - productWithQuantity.product.basePrice) * productWithQuantity.quantity;

    incomeData[index] = (incomeData[index] ?? 0) + income;
    profitData[index] = (profitData[index] ?? 0) + profit;

    totalIncome += income;
    totalProfit += profit;
  }
}


  // Convert to `FlSpot` for chart
  List<FlSpot> incomeChartData = incomeData.entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();
  List<FlSpot> profitChartData = profitData.entries.map((e) => FlSpot(e.key.toDouble(), e.value)).toList();

  return DashboardStats(
    totalIncome: totalIncome,
    totalProfit: totalProfit,
    incomeChartData: incomeChartData,
    profitChartData: profitChartData,
  );
}
