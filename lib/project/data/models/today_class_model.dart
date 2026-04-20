class TodayClassModel {
  final String id;
  final String courseId;
  final String courseTitle;
  final String courseCode;
  final String? courseImage;
  final String startTime;
  final String endTime;
  final String? location;
  final String? roomNumber;
  final String? semester;
  final String? instructorName;
  final String studentId;

  TodayClassModel({
    required this.id,
    required this.courseId,
    required this.courseTitle,
    required this.courseCode,
    this.courseImage,
    required this.startTime,
    required this.endTime,
    this.location,
    this.roomNumber,
    this.semester,
    this.instructorName,
    required this.studentId,
  });

  factory TodayClassModel.fromJson(Map<String, dynamic> json) {
    return TodayClassModel(
      id: json['id'] as String,
      courseId: json['course_id'] as String,
      courseTitle: json['course_title'] as String,
      courseCode: json['course_code'] as String,
      courseImage: json['course_image'] as String?,
      startTime: json['start_time'] as String,
      endTime: json['end_time'] as String,
      location: json['location'] as String?,
      roomNumber: json['room_number'] as String?,
      semester: json['semester'] as String?,
      instructorName: json['instructor_name'] as String?,
      studentId: json['student_id'] as String,
    );
  }

  String get formattedTime => '$startTime - $endTime';

  String get locationDisplay {
    if (roomNumber != null && roomNumber!.isNotEmpty) {
      return roomNumber!;
    }
    return location ?? 'Online';
  }
}