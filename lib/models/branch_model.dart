import 'package:cloud_firestore/cloud_firestore.dart';

class Branch {
  final String id;
  final String name;
  final String location;
  final double income;
  final double profit;
  final bool marketplaceEnabled;

  Branch({
    required this.id,
    required this.name,
    required this.location,
    required this.income,
    required this.profit,
    required this.marketplaceEnabled,
  });

  factory Branch.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;
    return Branch(
      id: doc.id,
      name: data['name'] ?? '',
      location: data['location'] ?? '',
      income: (data['income'] ?? 0).toDouble(),
      profit: (data['profit'] ?? 0).toDouble(),
      marketplaceEnabled: data['marketplace_enabled'] ?? false,
    );
  }

  Map<String, dynamic> toFirestore() {
    return {
      'name': name,
      'location': location,
      'income': income,
      'profit': profit,
      'marketplace_enabled': marketplaceEnabled,
    };
  }
}
