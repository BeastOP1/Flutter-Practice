// // lib/data/models/profile_model.dart
// class ProfileModel {
//   final String id;
//   final String email;
//   final String? fullName;
//   final String? avatarUrl;
//   final String role;
//   final String? universityId;
//   final String? phoneNumber;
//   final String? department;
//   final String? batch;
//   final int currentSemester;
//   final int maxCredits;
//   final DateTime createdAt;
//
//   const ProfileModel({
//     required this.id,
//     required this.email,
//     this.fullName,
//     this.avatarUrl,
//     required this.role,
//     this.universityId,
//     this.phoneNumber,
//     this.department,
//     this.batch,
//     required this.currentSemester,
//     required this.maxCredits,
//     required this.createdAt,
//   });
//
//   factory ProfileModel.fromJson(Map<String, dynamic> json) {
//     return ProfileModel(
//       id: json['id'],
//       email: json['email'],
//       fullName: json['full_name'],
//       avatarUrl: json['avatar_url'],
//       role: json['role'] ?? 'student',
//       universityId: json['university_id'],
//       phoneNumber: json['phone_number'],
//       department: json['department'],
//       batch: json['batch'],
//       currentSemester: json['current_semester'] ?? 1,
//       maxCredits: json['max_credits'] ?? 50,
//       createdAt: DateTime.parse(json['created_at']),
//     );
//   }
//
//   Map<String, dynamic> toJson() {
//     return {
//       'id': id,
//       'email': email,
//       'full_name': fullName,
//       'avatar_url': avatarUrl,
//       'role': role,
//       'university_id': universityId,
//       'phone_number': phoneNumber,
//       'department': department,
//       'batch': batch,
//       'current_semester': currentSemester,
//       'max_credits': maxCredits,
//     };
//   }
// }



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
  final int? currentSemester;
  final int? maxCredits;

  // --- New academic summary fields ---
  final double cgpa;
  final int creditsEarned;
  final int totalCredits;        // can be from program or fixed
  final int passedCourses;
  final int failedCourses;
  final int pendingCourses;

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
    this.cgpa = 0.0,
    this.creditsEarned = 0,
    this.totalCredits = 130,      // default program credits
    this.passedCourses = 0,
    this.failedCourses = 0,
    this.pendingCourses = 0,
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
      cgpa: (json['cgpa'] as num?)?.toDouble() ?? 0.0,
      creditsEarned: json['credits_earned'] as int? ?? 0,
      totalCredits: json['total_credits'] as int? ?? 130,
      passedCourses: json['courses_passed'] as int? ?? 0,
      failedCourses: json['courses_failed'] as int? ?? 0,
      pendingCourses: json['courses_pending'] as int? ?? 0,
    );
  }

  ProfileModel copyWith({
    String? id,
    String? email,
    String? fullName,
    String? avatarUrl,
    String? role,
    String? universityId,
    String? phoneNumber,
    String? department,
    String? batch,
    int? currentSemester,
    int? maxCredits,
    double? cgpa,
    int? creditsEarned,
    int? totalCredits,
    int? passedCourses,
    int? failedCourses,
    int? pendingCourses,
  }) {
    return ProfileModel(
      id: id ?? this.id,
      email: email ?? this.email,
      fullName: fullName ?? this.fullName,
      avatarUrl: avatarUrl ?? this.avatarUrl,
      role: role ?? this.role,
      universityId: universityId ?? this.universityId,
      phoneNumber: phoneNumber ?? this.phoneNumber,
      department: department ?? this.department,
      batch: batch ?? this.batch,
      currentSemester: currentSemester ?? this.currentSemester,
      maxCredits: maxCredits ?? this.maxCredits,
      cgpa: cgpa ?? this.cgpa,
      creditsEarned: creditsEarned ?? this.creditsEarned,
      totalCredits: totalCredits ?? this.totalCredits,
      passedCourses: passedCourses ?? this.passedCourses,
      failedCourses: failedCourses ?? this.failedCourses,
      pendingCourses: pendingCourses ?? this.pendingCourses,
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