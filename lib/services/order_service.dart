// import 'package:penya_business/models/orders_model.dart';
//
// import '../models/data.dart';
//
// class OrderService {
//   final List<OrdersModel> _orders = orders;
//   List<OrdersModel> fetchProducts() {
//     return _orders;
//   }
//
//   void addProduct(OrdersModel order) {
//     _orders.add(order);
//   }
//
//   void updateProduct(String id, OrdersModel updatedOrder) {
//     final index = _orders.indexWhere((p) => p.orderId == id);
//     if (index != -1) _orders[index] = updatedOrder;
//   }
//
//   void deleteProduct(String id) {
//     _orders.removeWhere((p) => p.orderId == id);
//   }
// }
import 'package:cloud_firestore/cloud_firestore.dart';

class OrderService {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;
  Future<List<Map<String, dynamic>>> fetchOrders(String businessId) async {
    try {
      QuerySnapshot querySnapshot = await _firestore.collection('orders').where('businessId', isEqualTo: businessId).get();
      return querySnapshot.docs.map((doc) => doc.data() as Map<String, dynamic>).toList();
  }
    catch (e) {
      return [];
    }
  }

  Future<void> addOrder(Map<String, dynamic> orderData) async {
    try {
      await _firestore.collection('orders').add(orderData);
    } catch (e) {
      print('Error adding order: $e');
    }
  }

  Future<void> updateOrder(String orderId, Map<String, dynamic> updatedData) async {
    try {
      await _firestore.collection('orders').doc(orderId).update(updatedData);
    } catch (e) {
      print('Error updating order: $e');
    }
  }

  Future<void> deleteOrder(String orderId) async {
    try {
      await _firestore.collection('orders').doc(orderId).delete();
    } catch (e) {
      print('Error deleting order: $e');
    }
  }
}