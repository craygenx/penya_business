import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
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

  Branch({
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
  });

  factory Branch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Branch(
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
    };
  }
}
