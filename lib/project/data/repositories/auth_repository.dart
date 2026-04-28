import 'package:flutter_learn/project/core/errors/failure_dart.dart'
    show AuthFailure, ServerFailure;
import 'package:flutter_learn/project/data/models/profile_model.dart'
    show ProfileModel;
import 'package:supabase_flutter/supabase_flutter.dart';

class AuthRepository {
  final SupabaseClient _supabase = Supabase.instance.client;

  Future<ProfileModel> signUp({
    required String email,
    required String password,
    required String fullName,
    required String universityId,
    required String phoneNumber,
  }) async {
    try {
      final authResponse = await _supabase.auth.signUp(
        email: email,
        password: password,
        data: {'full_name': fullName},
      );

      if (authResponse.user == null) {
        throw const AuthFailure('Signup failed. Please try again.');
      }

      final userId = authResponse.user!.id;

      // ← Trigger ko time do
      await Future.delayed(const Duration(milliseconds: 500));

      // ← Profile exist karo check — nahi hai to manually insert karo
      await _supabase.from('profiles').select().eq('id', userId).maybeSingle();
      final profileData = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .single();

      return ProfileModel.fromJson(profileData);
    } on AuthFailure {
      rethrow;
    } on AuthException catch (e) {
      if (e.message.contains('rate limit') || e.statusCode == '429') {
        throw const AuthFailure(
          'Too many attempts. Please wait and try again.',
        );
      }
      throw AuthFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  Future<ProfileModel> login({
    required String email,
    required String password,
  }) async {
    try {
      final authResponse = await _supabase.auth.signInWithPassword(
        email: email,
        password: password,
      );

      if (authResponse.user == null) {
        throw const AuthFailure('Login failed.');
      }
      final userId = authResponse.user!.id;
      await Future.delayed(const Duration(milliseconds: 500));

      // ← maybeSingle use karo
      final profileData = await _supabase
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle(); // ← safe

      if (profileData == null) {
        // ← Profile nahi mili to create karo
        await _supabase.from('profiles').upsert({
          'id': userId,
          'email': email,
          'role': 'student',
        });

        final newProfile = await _supabase
            .from('profiles')
            .select()
            .eq('id', userId)
            .single();

        return ProfileModel.fromJson(newProfile);
      }

      return ProfileModel.fromJson(profileData);
    } on AuthFailure {
      rethrow;
    } on AuthException catch (e) {
      throw AuthFailure(e.message);
    } catch (e) {
      throw ServerFailure(e.toString());
    }
  }

  // ─── Logout ──────────────────────────────────────────────────────────────
  Future<void> logout() async {
    await _supabase.auth.signOut();
  }

  // ─── Current User ─────────────────────────────────────────────────────────
  Future<ProfileModel?> getCurrentUser() async {
    final user = _supabase.auth.currentUser;
    if (user == null) return null;

    final profileData = await _supabase
        .from('profiles')
        .select()
        .eq('id', user.id)
        .single();

    return ProfileModel.fromJson(profileData);
  }
}
