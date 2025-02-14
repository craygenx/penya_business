import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penya_business/models/branch_model.dart';

class Business {
  final String id;
  final String name;
  final String ownerId;
  final bool isSingleEntity;
  final bool marketplaceEnabled;
  final double totalIncome;
  final double totalProfit;
  final List<Branch>? branches; // Only fetched for owners

  Business({
    required this.id,
    required this.name,
    required this.ownerId,
    required this.isSingleEntity,
    required this.marketplaceEnabled,
    required this.totalIncome,
    required this.totalProfit,
    this.branches,
  });

  factory Business.fromFirestore(DocumentSnapshot doc, {List<Branch>? branches}) {
    final data = doc.data() as Map<String, dynamic>;
    return Business(
      id: doc.id,
      name: data['name'] ?? '',
      ownerId: data['owner_id'] ?? '',
      isSingleEntity: data['is_single_entity'] ?? true,
      marketplaceEnabled: data['marketplace_enabled'] ?? false,
      totalIncome: (data['total_income'] ?? 0).toDouble(),
      totalProfit: (data['total_profit'] ?? 0).toDouble(),
      branches: branches,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'owner_id': ownerId,
      'is_single_entity': isSingleEntity,
      'marketplace_enabled': marketplaceEnabled,
      'total_income': totalIncome,
      'total_profit': totalProfit,
    };
  }
}
