import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import '../models/course_model.dart';

abstract class ICourseRepository {
  Future<List<CourseModel>> getEnrolledCourses(String studentId);
  Future<CourseModel?> getCourseDetails(String courseId, String studentId);
  Future<List<Map<String, dynamic>>> getCourseSyllabus(String courseId);
  Future<List<Map<String, dynamic>>> getCourseAssignments(String courseId, String studentId);
}

class CourseRepository implements ICourseRepository {
  final SupabaseClient _client;

  CourseRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  @override
  Future<List<CourseModel>> getEnrolledCourses(String studentId) async {
    try {
      final response = await _client
          .from('course_enrollments')
          .select('''
          course_id,
          courses!inner(
            id, code, title, description, credits, 
            image_url, department, syllabus_url, is_active,
            course_instructors(
              profiles(full_name)
            )
          )
        ''')
          .eq('student_id', studentId)
          .eq('status', 'active');

      return response.map((json) {
        final courseData = json['courses'] as Map<String, dynamic>;
        final instructors = courseData['course_instructors'] as List?;

        return CourseModel.fromJson({
          ...courseData,
          'instructor_name': instructors?.isNotEmpty == true
              ? instructors![0]['profiles']['full_name']
              : 'Instructor TBA',
        });
      }).toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  @override
  Future<CourseModel?> getCourseDetails(String courseId, String studentId) async {
    try {
      final response = await _client
          .from('courses')
          .select('''
          id, code, title, description, credits, 
          image_url, department, syllabus_url, is_active,
          course_instructors(
            profiles(full_name)
          ),
          schedules(
            location, room_number
          )
        ''')
          .eq('id', courseId)
          .maybeSingle();

      if (response == null) return null;

      final instructors = response['course_instructors'] as List?;
      final schedules = response['schedules'] as List?;

      return CourseModel.fromJson({
        ...response,
        'instructor_name': instructors?.isNotEmpty == true
            ? instructors![0]['profiles']['full_name']
            : 'Instructor TBA',
        'location': schedules?.isNotEmpty == true
            ? schedules![0]['location']
            : null,
        'room_number': schedules?.isNotEmpty == true
            ? schedules![0]['room_number']
            : null,
      });
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }
  // @override
  // Future<List<CourseModel>> getEnrolledCourses(String studentId) async {
  //   try {
  //     final response = await _client
  //         .from('course_enrollments')
  //         .select('''
  //           course_id,
  //           courses!inner(
  //             id, code, title, description, credits,
  //             image_url, department, syllabus_url, is_active
  //           ),
  //           course_instructors!inner(
  //             profiles!inner(full_name)
  //           )
  //         ''')
  //         .eq('student_id', studentId)
  //         .eq('status', 'active');
  //
  //     return response.map((json) {
  //       final courseData = json['courses'] as Map<String, dynamic>;
  //       final instructorData = json['course_instructors'] as List?;
  //
  //       return CourseModel.fromJson({
  //         ...courseData,
  //         'instructor_name': instructorData?.isNotEmpty == true
  //             ? instructorData![0]['profiles']['full_name']
  //             : null,
  //       });
  //     }).toList();
  //   } on PostgrestException catch (e) {
  //     throw ServerFailure( e.message);
  //   } catch (e) {
  //     throw NetworkFailure(message: e.toString());
  //   }
  // }
  //
  // @override
  // Future<CourseModel?> getCourseDetails(String courseId, String studentId) async {
  //   try {
  //     final response = await _client
  //         .from('courses')
  //         .select('''
  //           id, code, title, description, credits,
  //           image_url, department, syllabus_url, is_active,
  //           course_instructors(
  //             profiles(full_name)
  //           ),
  //           schedules(
  //             location, room_number
  //           )
  //         ''')
  //         .eq('id', courseId)
  //         .maybeSingle();
  //
  //     if (response == null) return null;
  //
  //     final schedules = response['schedules'] as List?;
  //
  //     return CourseModel.fromJson({
  //       ...response,
  //       'instructor_name': response['course_instructors']?.isNotEmpty == true
  //           ? response['course_instructors'][0]['profiles']['full_name']
  //           : null,
  //       'location': schedules?.isNotEmpty == true
  //           ? schedules![0]['location']
  //           : null,
  //       'room_number': schedules?.isNotEmpty == true
  //           ? schedules![0]['room_number']
  //           : null,
  //     });
  //   } on PostgrestException catch (e) {
  //     throw ServerFailure( e.message);
  //   } catch (e) {
  //     throw NetworkFailure(message: e.toString());
  //   }
  // }

  @override
  Future<List<Map<String, dynamic>>> getCourseSyllabus(String courseId) async {
    // For now, return static syllabus topics
    // Later can be moved to a separate table
    return [
      {'num': '01', 'title': 'Introduction to Programming'},
      {'num': '02', 'title': 'Control Flow & Loops'},
      {'num': '03', 'title': 'Functions & Recursion'},
      {'num': '04', 'title': 'Arrays & Strings'},
      {'num': '05', 'title': 'Pointers & Memory Management'},
      {'num': '06', 'title': 'Structures & Unions'},
      {'num': '07', 'title': 'File Handling'},
    ];
  }

  @override
  Future<List<Map<String, dynamic>>> getCourseAssignments(String courseId, String studentId) async {
    try {
      final response = await _client
          .from('assignments')
          .select('''
            id, title, description, due_date, max_score, weight, submission_type,
            submissions!left(id, submitted_at, file_url, is_late),
            grades!left(score, feedback)
          ''')
          .eq('course_id', courseId)
          .eq('submissions.student_id', studentId)
          .order('due_date', ascending: true);

      return response;
    } on PostgrestException catch (e) {
      throw ServerFailure( e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }
}