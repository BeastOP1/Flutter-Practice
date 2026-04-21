// lib/presentation/providers/result_provider.dart
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import '../../data/models/result_model.dart';
import '../../data/repositories/result_repository.dart';
import 'auth_provider.dart';

final resultRepositoryProvider = Provider<ResultRepository>((ref) {
  return ResultRepository();
});

class ResultState {
  final List<ResultModel> allResults;
  final List<ResultModel> filteredResults;
  final List<String> semesters;
  final String? selectedSemester;
  final double cgpa;
  final int totalCredits;
  final int maxCredits;
  final bool isLoading;
  final String? errorMessage;

  const ResultState({
    this.allResults      = const [],
    this.filteredResults = const [],
    this.semesters       = const [],
    this.selectedSemester,
    this.cgpa            = 0.0,
    this.totalCredits    = 0,
    this.maxCredits      = 50,
    this.isLoading       = false,
    this.errorMessage,
  });

  ResultState copyWith({
    List<ResultModel>? allResults,
    List<ResultModel>? filteredResults,
    List<String>?      semesters,
    String?            selectedSemester,
    double?            cgpa,
    int?               totalCredits,
    int?               maxCredits,
    bool?              isLoading,
    String?            errorMessage,
  }) {
    return ResultState(
      allResults:       allResults       ?? this.allResults,
      filteredResults:  filteredResults  ?? this.filteredResults,
      semesters:        semesters        ?? this.semesters,
      selectedSemester: selectedSemester ?? this.selectedSemester,
      cgpa:             cgpa             ?? this.cgpa,
      totalCredits:     totalCredits     ?? this.totalCredits,
      maxCredits:       maxCredits       ?? this.maxCredits,
      isLoading:        isLoading        ?? this.isLoading,
      errorMessage:     errorMessage,
    );
  }
}

class ResultNotifier extends StateNotifier<ResultState> {
  final ResultRepository _repository;
  final String? _studentId;

  ResultNotifier({
    required ResultRepository repository,
    required String? studentId,
  })  : _repository = repository,
        _studentId  = studentId,
        super(const ResultState());

  Future<void> loadResults() async {
    if (_studentId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final results   = await _repository.getResults(_studentId);
      final semesters = await _repository.getSemesters(_studentId);

      final cgpa         = _calculateCGPA(results);
      final totalCredits = results.fold<int>(
        0, (sum, r) => sum + (r.credits ?? 0),
      );

      state = state.copyWith(
        allResults:      results,
        filteredResults: results,
        semesters:       semesters,
        cgpa:            cgpa,
        totalCredits:    totalCredits,
        isLoading:       false,
      );
    } on Failure catch (e) {
      state = state.copyWith(errorMessage: e.message, isLoading: false);
    } catch (e) {
      state = state.copyWith(errorMessage: e.toString(), isLoading: false);
    }
  }

  void filterBySemester(String? semester) {
    final filtered = semester == null || semester == 'All'
        ? state.allResults
        : state.allResults.where((r) => r.semester == semester).toList();

    state = state.copyWith(
      selectedSemester: semester,
      filteredResults:  filtered,
      cgpa:             _calculateCGPA(filtered),
      totalCredits:     filtered.fold(0, (s, r) => s! + (r.credits ?? 0)),
    );
  }

  double _calculateCGPA(List<ResultModel> results) {
    if (results.isEmpty) return 0.0;
    final gradePoints = results
        .map((r) => _gradeToPoint(r.finalGrade))
        .where((p) => p >= 0)
        .toList();
    if (gradePoints.isEmpty) return 0.0;
    return gradePoints.reduce((a, b) => a + b) / gradePoints.length;
  }

  double _gradeToPoint(String? grade) {
    return switch (grade) {
      'A+'  => 4.0,
      'A'   => 4.0,
      'A-'  => 3.7,
      'B+'  => 3.3,
      'B'   => 3.0,
      'B-'  => 2.7,
      'C+'  => 2.3,
      'C'   => 2.0,
      'C-'  => 1.7,
      'D'   => 1.0,
      'F'   => 0.0,
      _     => -1.0,
    };
  }
}

final resultProvider =
StateNotifierProvider<ResultNotifier, ResultState>((ref) {
  return ResultNotifier(
    repository: ref.watch(resultRepositoryProvider),
    studentId:  ref.watch(authProvider).userId,
  );
});