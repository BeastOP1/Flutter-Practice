


import 'package:flutter/material.dart';
import 'package:flutter_learn/project/core/utils/app_colors.dart';
import '../models/class_model.dart';

class CalendarCard extends StatelessWidget {
  final DateTime focusedMonth;
  final DateTime selectedDate;
  final Map<String, List<ClassModel>> scheduleCache;
  final Function(DateTime) onDateSelected;
  final VoidCallback onPrevMonth;
  final VoidCallback onNextMonth;

  const CalendarCard({
    super.key,
    required this.focusedMonth,
    required this.selectedDate,
    required this.scheduleCache,
    required this.onDateSelected,
    required this.onPrevMonth,
    required this.onNextMonth,
  });

  int _daysInMonth(DateTime d) => DateTime(d.year, d.month + 1, 0).day;

  int _firstWeekday(DateTime d) {
    final wd = DateTime(d.year, d.month, 1).weekday % 7;
    return wd;
  }

  String _monthName(int m) => const [
    '', 'January', 'February', 'March', 'April', 'May', 'June',
    'July', 'August', 'September', 'October', 'November', 'December'
  ][m];

  @override
  Widget build(BuildContext context) {
    final days = _daysInMonth(focusedMonth);
    final offset = _firstWeekday(focusedMonth);
    final totalCells = offset + days;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: AppColors.surface,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 20,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        children: [
          _buildMonthHeader(),
          const SizedBox(height: 10),
          _buildDayHeaders(),
          const SizedBox(height: 6),
          _buildDateGrid(days, offset, totalCells),
        ],
      ),
    );
  }

  Widget _buildMonthHeader() {
    return Row(
      children: [
        Text(
          '${_monthName(focusedMonth.month)} ${focusedMonth.year}',
          style: const TextStyle(
            fontSize: 17,
            fontWeight: FontWeight.w700,
            color: AppColors.textPrimary,
          ),
        ),
        const SizedBox(width: 4),
        const Icon(
          Icons.chevron_right,
          color: AppColors.primary,
          size: 20,
        ),
        const Spacer(),
        GestureDetector(
          onTap: onPrevMonth,
          child: const Icon(
            Icons.chevron_left,
            color: AppColors.primary,
            size: 22,
          ),
        ),
        const SizedBox(width: 8),
        GestureDetector(
          onTap: onNextMonth,
          child: Icon(
            Icons.chevron_right,
            color: AppColors.secondary,
            size: 22,
          ),
        ),
      ],
    );
  }

  Widget _buildDayHeaders() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceAround,
      children: const ['SUN', 'MON', 'TUE', 'WED', 'THU', 'FRI', 'SAT']
          .map((d) => SizedBox(
        width: 36,
        child: Text(
          d,
          textAlign: TextAlign.center,
          style: TextStyle(
            fontSize: 10,
            fontWeight: FontWeight.w600,
            color: AppColors.textSecondary,
          ),
        ),
      ))
          .toList(),
    );
  }

  Widget _buildDateGrid(int days, int offset, int totalCells) {
    return GridView.builder(
      physics: const NeverScrollableScrollPhysics(),
      shrinkWrap: true,
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 7,
        childAspectRatio: 1,
      ),
      itemCount: totalCells,
      itemBuilder: (_, idx) {
        if (idx < offset) return const SizedBox.shrink();

        final day = idx - offset + 1;
        final date = DateTime(focusedMonth.year, focusedMonth.month, day);
        final isSelected = selectedDate.year == date.year &&
            selectedDate.month == date.month &&
            selectedDate.day == date.day;
        final key = '${date.year}-${date.month}-${date.day}';
        final hasEvents = scheduleCache.containsKey(key) &&
            scheduleCache[key]!.isNotEmpty;

        return _buildDateCell(date, isSelected, hasEvents);
      },
    );
  }

  Widget _buildDateCell(DateTime date, bool isSelected, bool hasEvents) {
    final today = DateTime.now();
    final isToday = date.year == today.year &&
        date.month == today.month &&
        date.day == today.day;

    return GestureDetector(
      onTap: () => onDateSelected(date),
      child: Center(
        child: Container(
          width: 32,
          height: 32,
          decoration: BoxDecoration(
            color: isSelected ? AppColors.primary.withOpacity(0.2) : null,
            shape: BoxShape.circle,
            border: isToday && !isSelected
                ? Border.all(color: AppColors.primary, width: 1.5)
                : null,
          ),
          alignment: Alignment.center,
          child: Stack(
            alignment: Alignment.center,
            children: [
              Text(
                '${date.day}',
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: isSelected || isToday
                      ? FontWeight.w800
                      : FontWeight.w500,
                  color: isSelected
                      ? AppColors.primary
                      : isToday
                      ? AppColors.primary
                      : AppColors.textDark,
                ),
              ),
              if (hasEvents)
                Positioned(
                  bottom: 2,
                  child: Container(
                    width: 4,
                    height: 4,
                    decoration: const BoxDecoration(
                      color: AppColors.warning,
                      shape: BoxShape.circle,
                    ),
                  ),
                ),
            ],
          ),
        ),
      ),
    );
  }
}