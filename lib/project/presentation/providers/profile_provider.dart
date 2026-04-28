// lib/presentation/providers/profile_provider.dart (existing file)
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../../data/models/profile_model.dart';   // adjust path

class ProfileState {
  final ProfileModel? profile;
  final bool isLoading;
  final String? errorMessage;

  const ProfileState({
    this.profile,
    this.isLoading = false,
    this.errorMessage,
  });

  ProfileState copyWith({
    ProfileModel? profile,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ProfileState(
      profile: profile ?? this.profile,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
    );
  }
}

class ProfileNotifier extends StateNotifier<ProfileState> {
  ProfileNotifier() : super(const ProfileState());

  Future<void> fetchProfile() async {
    final userId = Supabase.instance.client.auth.currentUser?.id;
    if (userId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      // 1. Fetch basic profile
      final profileResponse = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (profileResponse == null) {
        state = state.copyWith(
          errorMessage: 'Profile not found',
          isLoading: false,
        );
        return;
      }

      // 2. Fetch academic summary from view
      final summaryResponse = await Supabase.instance.client
          .from('student_academic_summary')
          .select()
          .eq('student_id', userId)
          .maybeSingle();

      // 3. Merge data into ProfileModel
      final profile = ProfileModel.fromJson({
        ...profileResponse,
        if (summaryResponse != null) ...summaryResponse,
      });

      state = state.copyWith(
        profile: profile,
        isLoading: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        isLoading: false,
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final profileProvider = StateNotifierProvider<ProfileNotifier, ProfileState>((ref) {
  return ProfileNotifier();
});