import 'package:cloud_firestore/cloud_firestore.dart';

class UserModel {
  final String id;
  final String email;
  final String displayName;
  final List<String> roles;
  final String? businessId;
  final DateTime createdAt;
  final DateTime lastLogin;

  UserModel({
    required this.id,
    required this.email,
    required this.displayName,
    required this.roles,
    this.businessId,
    required this.createdAt,
    required this.lastLogin,
  });

  /// **Convert Firestore document to UserModel**
  factory UserModel.fromFirestore(DocumentSnapshot doc) {
    final data = doc.data() as Map<String, dynamic>;

    return UserModel(
      id: doc.id,
      email: data['email'] ?? '',
      displayName: data['display_name'] ?? '',
      roles: List<String>.from(data['roles'] ?? []),
      businessId: data['business_id'],
      createdAt: (data['created_at'] as Timestamp).toDate(),
      lastLogin: (data['last_login'] as Timestamp).toDate(),
    );
  }

  /// **Convert UserModel to Firestore document**
  Map<String, dynamic> toFirestore() {
    return {
      'email': email,
      'display_name': displayName,
      'roles': roles,
      'business_id': businessId,
      'created_at': Timestamp.fromDate(createdAt),
      'last_login': Timestamp.fromDate(lastLogin),
    };
  }

  /// **Update User Role**
  UserModel copyWithRoles(List<String> newRoles) {
    return UserModel(
      id: id,
      email: email,
      displayName: displayName,
      roles: newRoles,
      businessId: businessId,
      createdAt: createdAt,
      lastLogin: lastLogin,
    );
  }

  /// **Update Business ID**
  UserModel copyWithBusinessId(String? newBusinessId) {
    return UserModel(
      id: id,
      email: email,
      displayName: displayName,
      roles: roles,
      businessId: newBusinessId,
      createdAt: createdAt,
      lastLogin: lastLogin,
    );
  }
}
