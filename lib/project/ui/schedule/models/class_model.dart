import 'dart:ui';

class ClassModel {
  final String id;
  final String title;
  final String time;
  final String roomNumber;
  final String instructor;
  final DateTime startTime;
  final DateTime endTime;
  final Color themeColor;
  final bool hasNotification;
  final int notificationCount;

  const ClassModel({
    required this.id,
    required this.title,
    required this.time,
    required this.roomNumber,
    required this.instructor,
    required this.startTime,
    required this.endTime,
    required this.themeColor,
    this.hasNotification = false,
    this.notificationCount = 0,
  });

  factory ClassModel.fromJson(Map<String, dynamic> json) {
    return ClassModel(
      id: json['id'] as String,
      title: json['title'] as String,
      time: json['time'] as String,
      roomNumber: json['roomNumber'] as String,
      instructor: json['instructor'] as String,
      startTime: DateTime.parse(json['startTime'] as String),
      endTime: DateTime.parse(json['endTime'] as String),
      themeColor: Color(json['themeColor'] as int),
      hasNotification: json['hasNotification'] as bool? ?? false,
      notificationCount: json['notificationCount'] as int? ?? 0,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'title': title,
      'time': time,
      'roomNumber': roomNumber,
      'instructor': instructor,
      'startTime': startTime.toIso8601String(),
      'endTime': endTime.toIso8601String(),
      'themeColor': themeColor.value,
      'hasNotification': hasNotification,
      'notificationCount': notificationCount,
    };
  }
}