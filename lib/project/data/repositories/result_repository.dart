// // lib/data/repositories/result_repository.dart
// import 'package:flutter/foundation.dart';
// import 'package:supabase_flutter/supabase_flutter.dart';
// import 'package:flutter_learn/project/core/errors/failure_dart.dart';
// import '../models/result_model.dart';
//
// class ResultRepository {
//   final SupabaseClient _client;
//
//   ResultRepository({SupabaseClient? client})
//       : _client = client ?? Supabase.instance.client;
//
//   Future<List<ResultModel>> getResults(String studentId) async {
//     try {
//       final response = await _client
//           .from('semester_results')
//           .select('''
//             id,
//             final_grade,
//             final_score,
//             semester,
//             course_enrollments!inner(
//               student_id,
//               courses!inner(
//                 id, code, title, credits, department,
//                 course_instructors(
//                   profiles(full_name)
//                 )
//               )
//             )
//           ''')
//           .eq('course_enrollments.student_id', studentId)
//           .order('issued_at', ascending: false);
//
//
//       if(kDebugMode){
//
//         print("Result ${response}");
//       }
//       return response.map((json) => ResultModel.fromJson(json)).toList();
//     } on PostgrestException catch (e) {
//       throw ServerFailure(e.message);
//     } catch (e) {
//       throw NetworkFailure(message: e.toString());
//     }
//   }
//
//   Future<List<String>> getSemesters(String studentId) async {
//     try {
//       final response = await _client
//           .from('semester_results')
//           .select('semester, course_enrollments!inner(student_id)')
//           .eq('course_enrollments.student_id', studentId)
//           .not('semester', 'is', null);
//
//       final semesters = response
//           .map((e) => e['semester'] as String? ?? '')
//           .where((s) => s.isNotEmpty)
//           .toSet()
//           .toList();
//
//       semesters.sort();
//       return semesters;
//     } on PostgrestException catch (e) {
//       throw ServerFailure(e.message);
//     } catch (e) {
//       throw NetworkFailure(message: e.toString());
//     }
//   }
// }

import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';
import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import '../models/result_model.dart';

class ResultRepository {
  final SupabaseClient _client;

  ResultRepository({SupabaseClient? client})
    : _client = client ?? Supabase.instance.client;

  Future<List<ResultModel>> getResults(String studentId) async {
    try {
      final response = await _client
          .from('student_semester_results')
          .select()
          .eq('student_id', studentId)
          .order('issued_at', ascending: false);

      if (kDebugMode) {
        print("Results (flat view): $response");
      }

      return response.map((json) => ResultModel.fromJson(json)).toList();
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }

  Future<List<String>> getSemesters(String studentId) async {
    try {
      final response = await _client
          .from('student_semester_results')
          .select('semester')
          .eq('student_id', studentId)
          .not('semester', 'is', null);
      if (kDebugMode) {
        print("Result ${response}");
      }
      final semesters =
          response.map((e) => e['semester'] as String).toSet().toList()
            ..sort((a, b) => b.compareTo(a)); // newest first

      return semesters;
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }
}
