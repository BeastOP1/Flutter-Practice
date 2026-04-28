// lib/data/models/result_model.dart
class ResultModel {
  final String id;
  final String courseId;
  final String courseCode;
  final String courseTitle;
  final String? faculty;
  final String? instructorName;
  final int? credits;
  final String? finalGrade;
  final double? finalScore;
  final String? semester;

  const ResultModel({
    required this.id,
    required this.courseId,
    required this.courseCode,
    required this.courseTitle,
    this.faculty,
    this.instructorName,
    this.credits,
    this.finalGrade,
    this.finalScore,
    this.semester,
  });

  factory ResultModel.fromJson(Map<String, dynamic> json) {
    final enrollment = json['course_enrollments'] as Map<String, dynamic>?;
    final course =
        enrollment?['courses'] as Map<String, dynamic>? ??
        json['courses'] as Map<String, dynamic>? ??
        json;

    final instructors = course['course_instructors'] as List?;
    String? instructorName;
    try {
      if (instructors != null && instructors.isNotEmpty) {
        instructorName = instructors[0]['profiles']?['full_name'] as String?;
      }
    } catch (_) {}

    return ResultModel(
      id: json['id'] as String,
      courseId: course['id'] as String? ?? '',
      courseCode: course['code'] as String? ?? '',
      courseTitle: course['title'] as String? ?? '',
      faculty: course['department'] as String?,
      instructorName: instructorName,
      credits: course['credits'] as int?,
      finalGrade: json['final_grade'] as String?,
      finalScore: (json['final_score'] as num?)?.toDouble(),
      semester: json['semester'] as String?,
    );
  }
}
