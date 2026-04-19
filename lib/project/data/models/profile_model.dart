// lib/data/models/profile_model.dart
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
  final int currentSemester;
  final int maxCredits;
  final DateTime createdAt;

  const ProfileModel({
    required this.id,
    required this.email,
    this.fullName,
    this.avatarUrl,
    required this.role,
    this.universityId,
    this.phoneNumber,
    this.department,
    this.batch,
    required this.currentSemester,
    required this.maxCredits,
    required this.createdAt,
  });

  factory ProfileModel.fromJson(Map<String, dynamic> json) {
    return ProfileModel(
      id: json['id'],
      email: json['email'],
      fullName: json['full_name'],
      avatarUrl: json['avatar_url'],
      role: json['role'] ?? 'student',
      universityId: json['university_id'],
      phoneNumber: json['phone_number'],
      department: json['department'],
      batch: json['batch'],
      currentSemester: json['current_semester'] ?? 1,
      maxCredits: json['max_credits'] ?? 50,
      createdAt: DateTime.parse(json['created_at']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'email': email,
      'full_name': fullName,
      'avatar_url': avatarUrl,
      'role': role,
      'university_id': universityId,
      'phone_number': phoneNumber,
      'department': department,
      'batch': batch,
      'current_semester': currentSemester,
      'max_credits': maxCredits,
    };
  }
}