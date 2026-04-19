import 'package:supabase_flutter/supabase_flutter.dart';

class CourseModel {
  final String id;
  final String code;
  final String title;
  final String? description;
  final int? credits;
  final String? imageUrl;
  final String? department;

  CourseModel({
    required this.id,
    required this.code,
    required this.title,
    this.description,
    this.credits,
    this.imageUrl,
    this.department,
  });

  factory CourseModel.fromJson(Map<String, dynamic> json) {
    return CourseModel(
      id: json['id'] as String,
      code: json['code'] as String,
      title: json['title'] as String,
      description: json['description'] as String?,
      credits: json['credits'] as int?,
      imageUrl: json['image_url'] as String?,
      department: json['department'] as String?,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'code': code,
      'title': title,
      'description': description,
      'credits': credits,
      'image_url': imageUrl,
      'department': department,
    };
  }
}