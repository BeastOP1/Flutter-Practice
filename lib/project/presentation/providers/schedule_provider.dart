import 'package:flutter_learn/project/presentation/screens/schedule/models/class_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_learn/project/core/errors/failure_dart.dart';
import '../../data/repositories/schedule_repository.dart';
import 'auth_provider.dart';

final scheduleRepositoryProvider = Provider<ScheduleRepository>((ref) {
  return ScheduleRepository();
});

class ScheduleState {
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final List<ClassModel> selectedDateClasses;
  final Map<String, List<ClassModel>> scheduleCache;
  final bool isLoading;
  final String? errorMessage;

  const ScheduleState({
    required this.focusedMonth,
    required this.selectedDate,
    this.selectedDateClasses = const [],
    this.scheduleCache = const {},
    this.isLoading = false,
    this.errorMessage,
  });

  ScheduleState copyWith({
    DateTime? focusedMonth,
    DateTime? selectedDate,
    List<ClassModel>? selectedDateClasses,
    Map<String, List<ClassModel>>? scheduleCache,
    bool? isLoading,
    String? errorMessage,
  }) {
    return ScheduleState(
      focusedMonth:         focusedMonth         ?? this.focusedMonth,
      selectedDate:         selectedDate         ?? this.selectedDate,
      selectedDateClasses:  selectedDateClasses  ?? this.selectedDateClasses,
      scheduleCache:        scheduleCache        ?? this.scheduleCache,
      isLoading:            isLoading            ?? this.isLoading,
      errorMessage:         errorMessage,
    );
  }
}

class ScheduleNotifier extends StateNotifier<ScheduleState> {
  final ScheduleRepository _repository;
  final String? _studentId;

  ScheduleNotifier({
    required ScheduleRepository repository,
    required String? studentId,
  })  : _repository = repository,
        _studentId = studentId,
        super(ScheduleState(
        focusedMonth: DateTime.now(),
        selectedDate: DateTime.now(),
      )) {
    loadMonth(DateTime.now());
  }

  Future<void> loadMonth(DateTime month) async {
    if (_studentId == null) return;

    state = state.copyWith(isLoading: true, errorMessage: null);

    try {
      final cache = await _repository.getClassesForMonth(_studentId, month);

      // Get today's classes
      final today = DateTime.now();
      final todayKey = '${today.year}-${today.month}-${today.day}';
      final todayClasses = cache[todayKey] ?? [];

      state = state.copyWith(
        scheduleCache:       cache,
        selectedDateClasses: todayClasses,
        isLoading:           false,
      );
    } on Failure catch (e) {
      state = state.copyWith(
        errorMessage: e.message,
        isLoading:    false,
      );
    } catch (e) {
      state = state.copyWith(
        errorMessage: e.toString(),
        isLoading:    false,
      );
    }
  }

  void selectDate(DateTime date) {
    final key = '${date.year}-${date.month}-${date.day}';
    final classes = state.scheduleCache[key] ?? [];

    state = state.copyWith(
      selectedDate:        date,
      selectedDateClasses: classes,
    );
  }

  void changeMonth(int delta) {
    final newMonth = DateTime(
      state.focusedMonth.year,
      state.focusedMonth.month + delta,
    );
    state = state.copyWith(focusedMonth: newMonth);
    loadMonth(newMonth);
  }
}

   final scheduleProvider =
StateNotifierProvider<ScheduleNotifier, ScheduleState>((ref) {

  final repository = ref.watch(scheduleRepositoryProvider);
  final authState  = ref.watch(authProvider);

  return ScheduleNotifier(
    repository: repository,
    studentId:  authState.userId,
  );

});