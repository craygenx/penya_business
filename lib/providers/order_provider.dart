import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/orders_model.dart';

import '../services/order_service.dart';

enum OrderStatus { pending, cancelled, delivered, all }

extension OrderStatusExtension on OrderStatus {
  String get value {
    switch (this) {
      case OrderStatus.pending:
        return 'pending';
      case OrderStatus.cancelled:
        return 'cancelled';
      case OrderStatus.delivered:
        return 'delivered';
      case OrderStatus.all:
        return 'all';
    }
  }
}

enum SortOrder { ascending, descending }

final orderFilterProvider =
    StateProvider<OrderStatus>((ref) => OrderStatus.all);
final sortOrderProvider =
    StateProvider<SortOrder>((ref) => SortOrder.descending);
final searchFocusNodeProvider = Provider<FocusNode>((ref) {
  final focusNode = FocusNode();
  ref.onDispose(focusNode.dispose);
  focusNode.addListener(() {
    if (!focusNode.hasFocus) {
      ref.watch(isSearchFocusedProvider.notifier).state = true;
    } else {
      ref.watch(isSearchFocusedProvider.notifier).state = false;
    }
  });
  return focusNode;
});
final isSearchFocusedProvider = StateProvider<bool>((ref) => false);
final searchQueryProvider = StateProvider<String>((ref) => '');
final orderServiceProvider = Provider((ref) => OrderService());
final ordersProvider =
    StateNotifierProvider<OrderNotifier, List<OrdersModel>>((ref) {
  final OrderService = ref.read(orderServiceProvider);
  return OrderNotifier(OrderService, ref.read);
});

class OrderNotifier extends StateNotifier<List<OrdersModel>> {
  final OrderService _orderService;
  final read;
  OrderNotifier(this._orderService, this.read) : super([]) {
    loadOrders();
  }

  void loadOrders() {
    state = _orderService.fetchProducts();
  }

  void addProducts(OrdersModel order) {
    _orderService.addProduct(order);
    loadOrders();
  }

  void updateProducts(String id, OrdersModel order) {
    _orderService.updateProduct(id, order);
    loadOrders();
  }

  void deleteProduct(String id) {
    _orderService.deleteProduct(id);
    loadOrders();
  }

  List<OrdersModel> getFilteredOrders() {
    final orderStatus = read(orderFilterProvider);
    final searchQuery = read(searchQueryProvider)
        .toString()
        .split('.')
        .last
        .trim()
        .toLowerCase();
    // final sortOrder = read(sortOrderProvider);

    List<OrdersModel> filteredOrders = state;
    if (orderStatus != OrderStatus.all) {
      filteredOrders = filteredOrders
          .where(
              (order) => order.status == orderStatus.toString().split('.').last)
          .toList();
    }

    if (searchQuery.isNotEmpty) {
      List<String> searchTerms =
          searchQuery.split('&').map((term) => term.trim()).toList();
      filteredOrders = filteredOrders.where((order) {
        bool matches = true;
        for (String term in searchTerms) {
          if (term.startsWith('<')) {
            double? amount = double.tryParse(term.substring(1));
            if (amount != null) {
              matches &= double.tryParse(order.totalAmount)! < amount;
            }
          } else if (term.startsWith('>')) {
            double? amount = double.tryParse(term.substring(1));
            if (amount != null) {
              matches &= double.tryParse(order.totalAmount)! > amount;
            }
          } else if (order.customerId.toLowerCase().contains(term) ||
              order.orderId.toString() == term ||
              order.totalAmount.contains(term)) {
            matches &= true;
          } else {
            matches = false;
          }
        }
        return matches;
      }).toList();
    }
    return filteredOrders;
  }
}
