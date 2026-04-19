// lib/presentation/providers/auth_provider.dart
import 'package:flutter_learn/project/core/errors/failure_dart.dart' show AuthFailure, ServerFailure;
import 'package:flutter_learn/project/data/models/profile_model.dart' show ProfileModel;
import 'package:flutter_learn/project/data/repositories/auth_repository.dart' show AuthRepository;
import 'package:flutter_riverpod/flutter_riverpod.dart';
// Repository provider
final authRepositoryProvider = Provider<AuthRepository>((ref) {
  return AuthRepository();
});

// Auth state
enum AuthStatus { initial, loading, authenticated, unauthenticated, error }

class AuthState {
  final AuthStatus status;
  final ProfileModel? profile;
  final String? errorMessage;

  const AuthState({
    required this.status,
    this.profile,
    this.errorMessage,
  });

  // Initial state
  factory AuthState.initial() => const AuthState(status: AuthStatus.initial);

  AuthState copyWith({
    AuthStatus? status,
    ProfileModel? profile,
    String? errorMessage,
  }) {
    return AuthState(
      status: status ?? this.status,
      profile: profile ?? this.profile,
      errorMessage: errorMessage,
    );
  }
}

// Auth Notifier
class AuthNotifier extends StateNotifier<AuthState> {
  final AuthRepository _repository;

  AuthNotifier(this._repository) : super(AuthState.initial());

  Future<void> signUp({
    required String email,
    required String password,
    required String fullName,
    required String universityId,
    required String phoneNumber,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final profile = await _repository.signUp(
        email: email,
        password: password,
        fullName: fullName,
        universityId: universityId,
        phoneNumber: phoneNumber,
      );
      state = state.copyWith(
        status: AuthStatus.authenticated,
        profile: profile,
      );
    } on AuthFailure catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message,
      );
    } on ServerFailure catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message,
      );
    }
  }

  Future<void> login({
    required String email,
    required String password,
  }) async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final profile = await _repository.login(
        email: email,
        password: password,
      );
      state = state.copyWith(
        status: AuthStatus.authenticated,
        profile: profile,
      );
    } on AuthFailure catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message,
      );
    } on ServerFailure catch (e) {
      state = state.copyWith(
        status: AuthStatus.error,
        errorMessage: e.message,
      );
    }
  }

  Future<void> logout() async {
    await _repository.logout();
    state = AuthState.initial();
  }

  Future<void> checkCurrentUser() async {
    state = state.copyWith(status: AuthStatus.loading);
    try {
      final profile = await _repository.getCurrentUser();
      if (profile != null) {
        state = state.copyWith(
          status: AuthStatus.authenticated,
          profile: profile,
        );
      } else {
        state = state.copyWith(status: AuthStatus.unauthenticated);
      }
    } catch (e) {
      state = state.copyWith(status: AuthStatus.unauthenticated);
    }
  }
}

// Provider
final authProvider = StateNotifierProvider<AuthNotifier, AuthState>((ref) {
  return AuthNotifier(ref.read(authRepositoryProvider));
});