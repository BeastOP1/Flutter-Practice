import 'package:flutter/foundation.dart';
import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import 'package:flutter_learn/project/data/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../data/models/today_class_model.dart';
import '../../data/models/assignment_model.dart';
import '../../data/models/news_event_model.dart';
import '../../data/repositories/home_repository.dart';
import 'auth_provider.dart';

final homeRepositoryProvider = Provider<HomeRepository>((ref) {
  return HomeRepository();
});

class HomeState {
  final List<TodayClassModel> todayClasses;
  final List<AssignmentModel> todayAssignments;
  final List<NewsEventModel> newsEvents;
  final List<CourseModel> enrolledCourses;
  final bool isLoading;
  final String? errorMessage;
  final bool isRefreshing;

  const HomeState({
    this.todayClasses = const [],
    this.todayAssignments = const [],
    this.newsEvents = const [],
    this.enrolledCourses = const [],
    this.isLoading = false,
    this.errorMessage,
    this.isRefreshing = false,
  });

  HomeState copyWith({
    List<TodayClassModel>? todayClasses,
    List<AssignmentModel>? todayAssignments,
    List<NewsEventModel>? newsEvents,
    List<CourseModel>? enrolledCourses,
    bool? isLoading,
    String? errorMessage,
    bool? isRefreshing,
  }) {
    return HomeState(
      todayClasses: todayClasses ?? this.todayClasses,
      todayAssignments: todayAssignments ?? this.todayAssignments,
      newsEvents: newsEvents ?? this.newsEvents,
      enrolledCourses: enrolledCourses ?? this.enrolledCourses,
      isLoading: isLoading ?? this.isLoading,
      errorMessage: errorMessage,
      isRefreshing: isRefreshing ?? this.isRefreshing,
    );
  }
}

class HomeNotifier extends StateNotifier<HomeState> {
  final HomeRepository _repository;
  final String? _studentId;

  HomeNotifier({
    required HomeRepository repository,
    required String? studentId,
  })  : _repository = repository,
        _studentId = studentId,
        super(const HomeState());

  Future<void> loadHomeData({bool refresh = false}) async {
    if (_studentId == null) {
      state = state.copyWith(
        errorMessage: 'User not authenticated',
        isLoading: false,
      );
      return;
    }

    state = state.copyWith(
      isLoading: !refresh,
      isRefreshing: refresh,
      errorMessage: null,
    );

    try {
      final results = await Future.wait([
        _repository.getTodayClasses(_studentId),
        _repository.getTodayAssignments(_studentId),
        _repository.getNewsEvents(),
        _repository.getEnrolledCourses(_studentId)
      ]);

      state = state.copyWith(
        todayClasses: results[0] as List<TodayClassModel>,
        todayAssignments: results[1] as List<AssignmentModel>,
        newsEvents: results[2] as List<NewsEventModel>,
        enrolledCourses: results[3] as List<CourseModel>,
        isLoading: false,
        isRefreshing: false,
      );
    } on Failure catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isLoading: false,
        isRefreshing: false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: 'An unexpected error occurred',
        isLoading: false,
        isRefreshing: false,
      );
    }
  }

  void clearError() {
    state = state.copyWith(errorMessage: null);
  }
}

final homeProvider = StateNotifierProvider<HomeNotifier, HomeState>((ref) {
  final repository = ref.watch(homeRepositoryProvider);
  final authState = ref.watch(authProvider);

  return HomeNotifier(
    repository: repository,
    studentId: authState.userId,
  );
});