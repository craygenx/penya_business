import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:penya_business/services/auth_service.dart';
import '../models/user_model.dart';

class AuthNotifier extends StateNotifier<AsyncValue<UserModel?>> {
  final AuthRepository _authRepository;
  final Ref ref;

  AuthNotifier(this._authRepository, this.ref) : super(const AsyncValue.loading()) {
    _checkAutoLogin();
  }

  /// **Check if session is still valid (Auto-login)**
  Future<void> _checkAutoLogin() async {
    state = const AsyncLoading();
    try {
      final user = await _authRepository.autoLogin(); // Implement this in AuthRepository
      state = AsyncData(user);

      if (user != null) {
      ref.read(businessIdProvider.notifier).state = user.businessId ?? "";
    }

    } catch (e) {
      state = AsyncData(null);
    }
  }

  /// **Load user from Firestore if logged in**
  // Future<void> _loadUser() async {
  //   try {
  //     final user = await _authRepository.getCurrentUser();
  //     state = AsyncValue.data(user);
  //   } catch (e) {
  //     state = AsyncValue.error(e, StackTrace.current);
  //   }
  // }

  /// **Sign in user**
  Future<void> signIn(String email, String password) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.signIn(email, password);
      state = AsyncValue.data(user);

      if (user != null) {
        ref.read(businessIdProvider.notifier).state = user.businessId ?? "";
      }

    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  Future<void> signUp(String email, String password, String displayName) async {
    state = const AsyncValue.loading();
    try {
      final user = await _authRepository.signUp(email: email, password: password, displayName: displayName);
      state = AsyncValue.data(user);

      if (user != null) {
        ref.read(businessIdProvider.notifier).state = user.businessId ?? "";
      }

    } catch (e) {
      state = AsyncValue.error(e, StackTrace.current);
    }
  }

  /// **Sign out user**
  Future<void> signOut() async {
    await _authRepository.signOut();
    state = const AsyncValue.data(null);
    ref.read(businessIdProvider.notifier).state = "";
  }
}

/// **Auth Provider**
final authProvider =
    StateNotifierProvider<AuthNotifier, AsyncValue<UserModel?>>((ref) {
  return AuthNotifier(ref.watch(authRepositoryProvider), ref);
});

final businessIdProvider = StateProvider<String>((ref) => "");
