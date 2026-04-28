import 'dart:ui';

class CourseModel {
  final String id;
  final String code;
  final String title;
  final String? description;
  final int? credits;
  final String? imageUrl;
  final String? department;
  final String? syllabusUrl;
  final bool isActive;
  final String? instructorName;  //  Joined from course_instructors
  final String? location;        // From schedules
  final String? roomNumber;      //  From schedules

  CourseModel({
    required this.id,
    required this.code,
    required this.title,
    this.description,
    this.credits,
    this.imageUrl,
    this.department,
    this.syllabusUrl,
    this.isActive = true,
    this.instructorName,
    this.location,
    this.roomNumber,
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
      syllabusUrl: json['syllabus_url'] as String?,
      isActive: json['is_active'] as bool? ?? true,
      instructorName: json['instructor_name'] as String?,
      location: json['location'] as String?,
      roomNumber: json['room_number'] as String?,
    );
  }


  Color get displayColor {
    final colors = [
      const Color(0xFF4C4D56),
      const Color(0xFFC04E2D),
      const Color(0xFF7A813E),
      const Color(0xFFB06F23),
      const Color(0xFF8A2373),
      const Color(0xFF2D6A4F),
      const Color(0xFF2D3250),
      const Color(0xFF7077A1),
    ];
    return colors[code.hashCode % colors.length];
  }


  String get displayCredits => credits != null ? '$credits Credits' : 'N/A';
}