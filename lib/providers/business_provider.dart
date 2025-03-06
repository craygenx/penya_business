import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/models/branch_model.dart';
import 'package:penya_business/models/business_model.dart';
import 'package:penya_business/providers/auth_provider.dart';
import 'package:penya_business/services/business_service.dart';

class BusinessNotifier extends StateNotifier<AsyncValue<Business?>> {
  final BusinessRepository _repository;
  final String userId;
  final String role;

  BusinessNotifier(this._repository, this.userId, this.role)
      : super(const AsyncLoading()) {
    fetchBusiness();
  }

  Future<void> fetchBusiness() async {
    state = const AsyncLoading();
    try {
      final business = await _repository.getBusinessData(userId, role);
      state = AsyncData(business);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  // Future<List<Branch>> getBranches(List<String> branchIds) async {
  //   return _repository.getBranches(branchIds);
  // }

  Future<void> createBusiness(Business business) async {
    try {
      await _repository.createBusiness(business);
      fetchBusiness(); // Refresh data
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> updateBusiness(Business business) async {
    try {
      await _repository.updateBusiness(business);
      fetchBusiness();
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> deleteBusiness(String businessId) async {
    try {
      await _repository.deleteBusiness(businessId);
      state = AsyncData(null);
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> addBranch(String businessId, Branch branch) async {
    try {
      await _repository.addBranch(businessId, branch);
      fetchBusiness();
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> updateBranch(String businessId, Branch branch) async {
    try {
      await _repository.updateBranch(businessId, branch);
      fetchBusiness();
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }

  Future<void> deleteBranch(String businessId, String branchId) async {
    try {
      await _repository.deleteBranch(businessId, branchId);
      fetchBusiness();
    } catch (e) {
      state = AsyncError(e.toString(), StackTrace.current);
    }
  }
}

final businessRepositoryProvider = Provider((ref) => BusinessRepository());


// Provider to get user details
final userRoleProvider = Provider<Map<String, String>>((ref) {
  final authState = ref.watch(authProvider);
  return {
    'userId': authState.value?.id ?? '',  // Replace with actual FirebaseAuth UID
    'role': authState.value!.roles.contains('owner') ? 'owner': '', // Fetch from Firestore user collection
  };
});

// Business state provider
final businessProvider =
    StateNotifierProvider<BusinessNotifier, AsyncValue<Business?>>((ref) {
  final repository = ref.watch(businessRepositoryProvider);
  final userInfo = ref.watch(userRoleProvider);
  return BusinessNotifier(repository, userInfo['userId']!, userInfo['role']!);
});

