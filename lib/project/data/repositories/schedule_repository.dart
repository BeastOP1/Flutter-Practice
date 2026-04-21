// lib/project/data/repositories/schedule_repository.dart
import 'package:flutter/foundation.dart';
import 'package:flutter_learn/project/core/utils/app_colors.dart';
import 'package:flutter_learn/project/presentation/screens/schedule/models/class_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_learn/project/core/errors/failure_dart.dart';

class ScheduleRepository {
  final SupabaseClient _client;

  ScheduleRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  /// Returns today's classes using the pre-built view `student_today_classes`
  Future<List<ClassModel>> getClassesForDate(String studentId, DateTime date) async {
    try {
      final response = await _client
          .from('student_today_classes')
          .select()
          .eq('student_id', studentId);

      final colors = AppColors.classCardColors;
      return response.asMap().entries.map((entry) {
        return _mapFromFlatView(entry.value, date, colorIndex: entry.key);
      }).toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  /// Returns all scheduled classes for a given month using the flat view `student_schedule_details`
  Future<Map<String, List<ClassModel>>> getClassesForMonth(
      String studentId, DateTime month) async {
    try {
      final response = await _client
          .from('student_schedule_details')
          .select()
          .eq('student_id', studentId);

      final Map<String, List<ClassModel>> cache = {};
      final daysInMonth = DateTime(month.year, month.month + 1, 0).day;
      final colors = AppColors.classCardColors;

      for (int day = 1; day <= daysInMonth; day++) {
        final date = DateTime(month.year, month.month, day);
        final dayOfWeek = date.weekday % 7; // Sunday = 0
        final key = '${date.year}-${date.month}-${date.day}';

        final daySchedules = response.where((s) => s['day_of_week'] == dayOfWeek).toList();
        if (daySchedules.isNotEmpty) {
          cache[key] = daySchedules.asMap().entries.map((entry) {
            return _mapFromFlatView(entry.value, date, colorIndex: entry.key);
          }).toList();
        }
      }
      return cache;
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  /// Unified mapper for both flat views
  ClassModel _mapFromFlatView(Map<String, dynamic> json, DateTime date,
      {required int colorIndex}) {
    final startStr = json['start_time'] as String? ?? '00:00:00';
    final endStr = json['end_time'] as String? ?? '00:00:00';
    final startParts = startStr.split(':');
    final endParts = endStr.split(':');

    final startTime = DateTime(
      date.year, date.month, date.day,
      int.parse(startParts[0]), int.parse(startParts[1]),
    );
    final endTime = DateTime(
      date.year, date.month, date.day,
      int.parse(endParts[0]), int.parse(endParts[1]),
    );

    final colors = AppColors.classCardColors;

    return ClassModel(
      id: json['id'] as String? ?? '',
      title: json['course_title'] as String? ?? 'Unknown',
      time: '${startStr.substring(0, 5)} - ${endStr.substring(0, 5)}',
      roomNumber: json['room_number'] as String? ?? 'TBA',
      instructor: json['instructor_name'] as String? ?? 'TBA',
      startTime: startTime,
      endTime: endTime,
      themeColor: colors[colorIndex % colors.length],
      // If you later add courseImage to ClassModel, uncomment:
      // courseImage: json['course_image'],
    );
  }
}