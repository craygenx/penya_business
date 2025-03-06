import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penya_business/models/branch_model.dart';

class Business {
  final String id;
  final String name;
  final String ownerId;
  final String businessEmail;
  final String businessPhone;
  final bool isSingleEntity;
  final bool marketplaceEnabled;
  final double totalIncome;
  final double totalProfit;
  final List<String> products;
  final List<String> branches; // Only fetched for owners

  Business({
    required this.id,
    required this.name,
    required this.businessEmail,
    required this.businessPhone,
    required this.ownerId,
    required this.isSingleEntity,
    required this.marketplaceEnabled,
    required this.totalIncome,
    required this.totalProfit,
    this.products = const [],
    this.branches = const [],
  });

  factory Business.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Business(
      id: doc.id,
      name: data['name'] ?? '',
      businessEmail: data['business_email'] ?? '',
      businessPhone: data['business_phone'] ?? '',
      products: data['products'] ?? [],
      ownerId: data['owner_id'] ?? '',
      isSingleEntity: data['is_single_entity'] ?? true,
      marketplaceEnabled: data['marketplace_enabled'] ?? false,
      totalIncome: (data['total_income'] ?? 0).toDouble(),
      totalProfit: (data['total_profit'] ?? 0).toDouble(),
      branches:
          data['branches'] != null ? List<String>.from(data['branches']) : [],
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'id': id,
      'name': name,
      'business_email': businessEmail,
      'business_phone': businessPhone,
      'owner_id': ownerId,
      'is_single_entity': isSingleEntity,
      'marketplace_enabled': marketplaceEnabled,
      'total_income': totalIncome,
      'total_profit': totalProfit,
      'products': products,
      'branches': branches,
    };
  }

  Future<List<Branch>> getBranches(List<String> branchIds) async {
    if (branchIds.isEmpty) return [];
    final branchSnapshots = await Future.wait(branchIds.map((branchId) =>
        FirebaseFirestore.instance.collection('branches').doc(branchId).get()));
    return branchSnapshots
        .map((branchSnapshot) => Branch.fromFirestore(branchSnapshot))
        .toList();
  }
}
