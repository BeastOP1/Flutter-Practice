

import 'class_model.dart';

class ScheduleDay {
  final DateTime date;
  final List<ClassModel> classes;
  final bool isHoliday;
  final String? holidayName;

  const ScheduleDay({
    required this.date,
    this.classes = const [],
    this.isHoliday = false,
    this.holidayName,
  });

  bool get hasClasses => classes.isNotEmpty;
  bool get isToday {
    final now = DateTime.now();
    return date.year == now.year &&
        date.month == now.month &&
        date.day == now.day;
  }
}