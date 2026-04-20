import 'package:flutter/animation.dart';

class AssignmentModel {
  final String id;
  final String courseId;
  final String courseTitle;
  final String courseCode;
  final String title;
  final String? description;
  final DateTime dueDate;
  final int maxScore;
  final double? weight;
  final String submissionType;
  final bool isSubmitted;
  final String? submissionId;
  final DateTime? submittedAt;
  final String? fileUrl;
  final String? fileName;
  final bool isLate;
  final int? obtainedScore;
  final String? feedback;

  AssignmentModel({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.courseCode,
    required this.title,
    this.description,
    required this.dueDate,
    required this.maxScore,
    this.weight,
    required this.submissionType,
    this.isSubmitted = false,
    this.submissionId,
    this.submittedAt,
    this.fileUrl,
    this.fileName,
    this.isLate = false,
    this.obtainedScore,
    this.feedback,
  });

  factory AssignmentModel.fromJson(Map<String, dynamic> json) {
    return AssignmentModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      courseTitle: json['course_title'] as String,
      courseCode: json['course_code'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      dueDate: DateTime.parse(json['due_date'] as String),
      maxScore: json['max_score'] as int,
      weight: json['weight'] != null
          ? double.parse(json['weight'].toString())
          : null,
      submissionType: json['submission_type'] as String,
      isSubmitted: json['is_submitted'] as bool? ?? false,
      submissionId: json['submission_id'] as String?,
      submittedAt: json['submitted_at'] != null
          ? DateTime.parse(json['submitted_at'] as String)
          : null,
      fileUrl: json['file_url'] as String?,
      fileName: json['file_name'] as String?,
      isLate: json['is_late'] as bool? ?? false,
      obtainedScore: json['obtained_score'] as int?,
      feedback: json['feedback'] as String?,
    );
  }

  String get formattedDueDate {
    return '${dueDate.day}/${dueDate.month}/${dueDate.year}';
  }

  String get timeLeft {
    final now = DateTime.now();
    final difference = dueDate.difference(now);

    if (difference.isNegative) {
      return 'Overdue';
    }

    if (difference.inDays > 0) {
      return '${difference.inDays} days left';
    } else if (difference.inHours > 0) {
      return '${difference.inHours} hours left';
    } else {
      return '${difference.inMinutes} minutes left';
    }
  }

  Color get statusColor {
    if (isSubmitted) return const Color(0xFF4CAF50);
    if (isLate || dueDate.isBefore(DateTime.now())) return const Color(0xFFF44336);
    if (dueDate.difference(DateTime.now()).inHours < 24) {
      return const Color(0xFFFF9800);
    }
    return const Color(0xFF2196F3);
  }

  String get statusText {
    if (isSubmitted) return 'Submitted';
    if (isLate || dueDate.isBefore(DateTime.now())) return 'Overdue';
    if (dueDate.difference(DateTime.now()).inHours < 24) return 'Due Soon';
    return 'Pending';
  }
}