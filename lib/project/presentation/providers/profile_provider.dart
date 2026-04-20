import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileModel {
  final String id;
  final String email;
  final String? fullName;
  final String? avatarUrl;
  final String role;
  final String? universityId;
  final String? phoneNumber;
  final String? department;
  final String? batch;
  final int? currentSemester;
  final int? maxCredits;

  ProfileModel({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    required this.role,
    this.universityId,
    this.phoneNumber,
    this.department,
    this.batch,
    this.currentSemester,
    this.maxCredits,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'] as String,
      email: json['email'] as String,
      fullName: json['full_name'] as String?,
      avatarUrl: json['avatar_url'] as String?,
      role: json['role'] as String,
      universityId: json['university_id'] as String?,
      phoneNumber: json['phone_number'] as String?,
      department: json['department'] as String?,
      batch: json['batch'] as String?,
      currentSemester: json['current_semester'] as int?,
      maxCredits: json['max_credits'] as int?,
    );
  }

  String get displayName {
    if (fullName != null && fullName!.isNotEmpty) {
      return fullName!.split(' ')[0];
    }
    return 'Student';
  }

  String get fullNameOrEmail => fullName ?? email;
}

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
      final response = await Supabase.instance.client
          .from('profiles')
          .select()
          .eq('id', userId)
          .maybeSingle();

      if (response != null) {
        state = state.copyWith(
          profile: ProfileModel.fromJson(response),
          isLoading: false,
        );
      } else {
        state = state.copyWith(
          errorMessage: 'Profile not found',
          isLoading: false,
        );
      }
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