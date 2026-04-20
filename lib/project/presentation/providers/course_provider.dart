import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/course_model.dart';
import '../../data/repositories/course_repository.dart';
import 'auth_provider.dart';

final courseRepositoryProvider = Provider<CourseRepository>((ref) {
  return CourseRepository();
});

class CourseState {
  final List<CourseModel> enrolledCourses;
  final CourseModel? selectedCourse;
  final List<Map<String, dynamic>> syllabus;
  final List<Map<String, dynamic>> assignments;
  final bool isLoading;
  final bool isLoadingDetails;
  final String? errorMessage;
  final String? searchQuery;

  const CourseState({
    this.enrolledCourses = const [],
    this.selectedCourse,
    this.syllabus = const [],
    this.assignments = const [],
    this.isLoading = false,
    this.isLoadingDetails = false,
    this.errorMessage,
    this.searchQuery,
  });

  CourseState copyWith({
    List<CourseModel>? enrolledCourses,
    CourseModel? selectedCourse,
    List<Map<String, dynamic>>? syllabus,
    List<Map<String, dynamic>>? assignments,
    bool? isLoading,
    bool? isLoadingDetails,
    String? errorMessage,
    String? searchQuery,
  }) {
    return CourseState(
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      selectedCourse: selectedCourse ?? this.selectedCourse,
      syllabus: syllabus ?? this.syllabus,
      assignments: assignments ?? this.assignments,
      isLoading: isLoading ?? this.isLoading,
      isLoadingDetails: isLoadingDetails ?? this.isLoadingDetails,
      errorMessage: errorMessage,
      searchQuery: searchQuery,
    );
  }

  List<CourseModel> get filteredCourses {
    if (searchQuery == null || searchQuery!.isEmpty) {
      return enrolledCourses;
    }
    return enrolledCourses.where((course) {
      return course.code.toLowerCase().contains(searchQuery!.toLowerCase()) ||
          course.title.toLowerCase().contains(searchQuery!.toLowerCase());
    }).toList();
  }
}

class CourseNotifier extends StateNotifier<CourseState> {
  final CourseRepository _repository;
  final String? _studentId;

  CourseNotifier({
    required CourseRepository repository,
    required String? studentId,
  })  : _repository = repository,
        _studentId = studentId,
        super(const CourseState());

  Future<void> loadEnrolledCourses() async {
    if (_studentId == null) {
      state = state.copyWith(
        errorMessage: 'User not authenticated',
        isLoading: false,
      );
      return;
    }

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final courses = await _repository.getEnrolledCourses(_studentId);
      state = state.copyWith(
        enrolledCourses: courses,
        isLoading: false,
      );
    } on Failure catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isLoading: false,
      );
    }
  }

  Future<void> loadCourseDetails(String courseId) async {
    if (_studentId == null) return;

    state = state.copyWith(isLoadingDetails: true, errorMessage: null);

    try {
      final results = await Future.wait([
        _repository.getCourseDetails(courseId, _studentId),
        _repository.getCourseSyllabus(courseId),
        _repository.getCourseAssignments(courseId, _studentId),
      ]);

      state = state.copyWith(
        selectedCourse: results[0] as CourseModel?,
        syllabus: results[1] as List<Map<String, dynamic>>,
        assignments: results[2] as List<Map<String, dynamic>>,
        isLoadingDetails: false,
      );
    } on Failure catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isLoadingDetails: false,
      );
    }
  }

  void setSearchQuery(String query) {
    state = state.copyWith(searchQuery: query);
  }

  void clearSelectedCourse() {
    state = state.copyWith(
      selectedCourse: null,
      syllabus: [],
      assignments: [],
    );
  }
}

final courseProvider = StateNotifierProvider<CourseNotifier, CourseState>((ref) {
  final repository = ref.watch(courseRepositoryProvider);
  final authState = ref.watch(authProvider);

  return CourseNotifier(
    repository: repository,
    studentId: authState.userId,
  );
});