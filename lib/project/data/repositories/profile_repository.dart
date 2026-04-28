import 'package:flutter/foundation.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

// lib/data/repositories/profile_repository.dart
import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

class ProfileRepository {
  final SupabaseClient _client;

  ProfileRepository({SupabaseClient? client})
      : _client = client ?? Supabase.instance.client;

  Future<Map<String, dynamic>> getStudentProfile(String studentId) async {
    try {
      // Fetch profile data
      final profile = await _client
          .from('profiles')
          .select('full_name, university_id, department, batch, current_semester, avatar_url')
          .eq('id', studentId)
          .maybeSingle();

      // Fetch academic summary
      final summary = await _client
          .from('student_academic_summary')
          .select('courses_passed, courses_failed, courses_pending, credits_earned, cgpa')
          .eq('student_id', studentId)
          .maybeSingle();

      // Program total credits (can be fetched from a program table or hardcoded)
      const totalProgramCredits = 130;

      if(kDebugMode){
        print("Profile ${profile}");
        print("Profile ${summary}");
      }



      return {
        'full_name': profile?['full_name'] ?? 'Student',
        'roll_number': profile?['university_id'] ?? studentId.substring(0, 8),
        'department': profile?['department'] ?? 'Computer Science',
        'batch': profile?['batch'] ?? '2025–2029',
        'current_semester': profile?['current_semester'] ?? 1,
        'avatar_url': profile?['avatar_url'],
        'courses_passed': summary?['courses_passed'] ?? 0,
        'courses_failed': summary?['courses_failed'] ?? 0,
        'courses_pending': summary?['courses_pending'] ?? 0,
        'credits_earned': summary?['credits_earned'] ?? 0,
        'cgpa': summary?['cgpa']?.toDouble() ?? 0.0,
        'total_credits': totalProgramCredits,
      };
    } on PostgrestException catch (e) {
      throw ServerFailure(e.message);
    } catch (e) {
      throw NetworkFailure(message: e.toString());
    }
  }
}