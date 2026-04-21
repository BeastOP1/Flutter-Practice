import 'package:flutter/foundation.dart';
import 'package:flutter_learn/project/core/errors/failure_dart.dart'
    show ServerFailure, NetworkFailure;
import 'package:flutter_learn/project/data/models/course_model.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/today_class_model.dart';
import '../models/assignment_model.dart';
import '../models/news_event_model.dart';

abstract class IHomeRepository {
  Future<List<TodayClassModel>> getTodayClasses(String studentId);
  Future<List<AssignmentModel>> getTodayAssignments(String studentId);
  Future<List<NewsEventModel>> getNewsEvents();
  Future<List<CourseModel>> getEnrolledCourses(String studentId);
}

class HomeRepository implements IHomeRepository {
  final SupabaseClient _client;

  HomeRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Future<List<TodayClassModel>> getTodayClasses(String studentId) async {
    try {
      final response = await _client
          .from('student_today_classes')
          .select()
          .eq('student_id', studentId)
          .order('start_time', ascending: true);

      if (kDebugMode) print('✅ Classes: $response');

      return response.map((json) => TodayClassModel.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  @override
  Future<List<AssignmentModel>> getTodayAssignments(String studentId) async {
    try {
      final today = DateTime.now().toIso8601String().split('T')[0];

      final response = await _client.rpc(
        'get_student_today_assignments',
        params: {'student_id_param': studentId, 'today_date': today},
      );

      if (response == null) return [];
      if (response is List) {
        return response.map((json) => AssignmentModel.fromJson(json)).toList();
      }
      return [];
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  @override
  Future<List<NewsEventModel>> getNewsEvents() async {
    try {
      final response = await _client
          .from('news_events')
          .select()
          .eq('is_published', true)
          .order('published_at', ascending: false)
          .limit(5);

      return response.map((json) => NewsEventModel.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  @override
  Future<List<CourseModel>> getEnrolledCourses(String studentId) async {
    try {
      // ✅ Use the flat view that already includes instructor_name
      final response = await _client
          .from('student_course_details')
          .select()
          .eq('student_id', studentId);

      if (kDebugMode) print('✅ Courses (with instructors): $response');

      return response.map<CourseModel>((json) {
        return CourseModel.fromJson({
          'id': json['id'],
          'code': json['code'],
          'title': json['title'],
          'description': json['description'],
          'credits': json['credits'],
          'image_url': json['image_url'],
          'department': json['department'],
          'instructor_name': json['instructor_name'], // 👈 now included
        });
      }).toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }
}