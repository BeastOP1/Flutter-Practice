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
      // Using your student_today_classes view
      final response = await _client
          .from('student_today_classes')
          .select()
          .eq('student_id', studentId)
          .order('start_time', ascending: true);

      if (kDebugMode) print('✅ Classes: ${response}');

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

      if (kDebugMode) {
        print('📤 RPC Call with: studentId=$studentId, today=$today');
      }

      // Using the RPC function we created
      final response = await _client.rpc(
        'get_student_today_assignments',
        params: {'student_id_param': studentId, 'today_date': today},
      );

      if (kDebugMode) {
        print('📥 RPC Response type: ${response.runtimeType}');
        print(
          '📥 RPC Response length: ${response is List ? response.length : 'not a list'}',
        );
      }
      if (response == null) {
        return [];
      }

      if (response is List) {
        return response.map((json) => AssignmentModel.fromJson(json)).toList();
      }


      return (response as List)
          .map((json) => AssignmentModel.fromJson(json))
          .toList();
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
      final response = await _client
          .from('course_enrollments')
          .select('''
            course_id,
            courses!inner(
              id,
              code,
              title,
              description,
              credits,
              image_url,
              department
            )
          ''')
          .eq('student_id', studentId)
          .eq('status', 'active');

      if (kDebugMode) print('✅ Courses: ${response}');

      return response
          .map((json) => CourseModel.fromJson(json['courses']))
          .toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }
}
