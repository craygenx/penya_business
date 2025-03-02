import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:penya_business/models/branch_model.dart';
import 'package:penya_business/models/business_model.dart';

class BusinessRepository {
  final FirebaseFirestore _firestore = FirebaseFirestore.instance;

  /// Fetch Business Data Based on Role
  Future<Business?> getBusinessData(String userId, String role) async {
    // return null;
    // if (role == 'owner') {
    //   // Fetch business where user is the owner
      final querySnapshot = await _firestore
          .collection('businesses')
          .where('owner_id', isEqualTo: userId)
          .limit(1)
          .get();

      if (querySnapshot.docs.isEmpty) return null;

      final businessDoc = querySnapshot.docs.first;
    //   // final businessId = businessDoc.id;

    //   // Fetch branches for this business
    //   // final branchesSnapshot = await _firestore
    //   //     .collection('businesses')
    //   //     .doc(businessId)
    //   //     .collection('branches')
    //   //     .get();

    //   // if(branchesSnapshot.docs.isEmpty){
    //   //   List<Branch> branches = [];
    //   //   return Business.fromFirestore(businessDoc);
    //   // } else{
    //   //     List<Branch> branches = branchesSnapshot.docs
    //   //       .map((branchDoc) => Branch.fromFirestore(branchDoc))
    //   //       .toList();

    //   //   return Business.fromFirestore(businessDoc, branches: branches);
    //   // }
      return Business.fromFirestore(businessDoc);
      
    // } else {
    //   // Fetch business assigned to branch manager from user collection
    //   final userDoc = await _firestore.collection('users').doc(userId).get();
    //   final userData = userDoc.data();
    //   if (userData == null || userData['business_id'] == null) return null;

    //   final businessId = userData['business_id'];
    //   final businessDoc =
    //       await _firestore.collection('businesses').doc(businessId).get();

    //   if (!businessDoc.exists) return null;

    //   return Business.fromFirestore(businessDoc);
    // }
  }

  /// Create a new business (Only for Owners)
  Future<void> createBusiness(Business business) async {
    await _firestore
        .collection('businesses')
        .doc(business.id)
        .set(business.toFirestore());
    await _firestore
        .collection('users')
        .doc(business.ownerId)
        .update({'business_id': business.id, 'roles': FieldValue.arrayUnion(['owner'])});
  }

  /// Update business details (Only for Owners)
  Future<void> updateBusiness(Business business) async {
    await _firestore
        .collection('businesses')
        .doc(business.id)
        .update(business.toFirestore());
  }

  /// Delete a business (Only for Owners)
  Future<void> deleteBusiness(String businessId) async {
    await _firestore.collection('businesses').doc(businessId).delete();
  }

  Future<List<Branch>> getBranches(List<dynamic> branchIds) async {
    if (branchIds.isEmpty) return [];
    final branchSnapshots = await Future.wait(branchIds.map((branchId) =>
        _firestore.collection('branches').doc(branchId).get()));

    return branchSnapshots
        .map((branchSnapshot) => Branch.fromFirestore(branchSnapshot))
        .toList();
  }

  /// Add a new branch to a business (Only for Owners)
  Future<void> addBranch(String businessId, Branch branch) async {
    await _firestore
        .collection('businesses')
        .doc(businessId)
        .collection('branches')
        .doc(branch.id)
        .set(branch.toFirestore());
  }

  /// Update a branch (Only for Owners)
  Future<void> updateBranch(String businessId, Branch branch) async {
    await _firestore
        .collection('businesses')
        .doc(businessId)
        .collection('branches')
        .doc(branch.id)
        .update(branch.toFirestore());
  }

  /// Delete a branch (Only for Owners)
  Future<void> deleteBranch(String businessId, String branchId) async {
    await _firestore
        .collection('businesses')
        .doc(businessId)
        .collection('branches')
        .doc(branchId)
        .delete();
  }
}
