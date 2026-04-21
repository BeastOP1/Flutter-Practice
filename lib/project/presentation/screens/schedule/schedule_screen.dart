import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/class_component.dart';
import 'package:flutter_learn/project/presentation/screens/schedule/widget/calender_card.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/schedule_provider.dart';
import '../common/components/icon_button.dart';

class ScheduleScreen extends ConsumerWidget {
  const ScheduleScreen({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final state = ref.watch(scheduleProvider);
    final notifier = ref.read(scheduleProvider.notifier);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'Schedule',
                    style: TextStyle(fontSize: 22, fontWeight: FontWeight.w700),
                  ),
                  const Spacer(),
                  CustomIconButton(),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: CalendarCard(
                focusedMonth: state.focusedMonth,
                selectedDate: state.selectedDate,
                scheduleCache: state.scheduleCache,
                onDateSelected: notifier.selectDate,
                onPrevMonth: () => notifier.changeMonth(-1),
                onNextMonth: () => notifier.changeMonth(1),
              ),
            ),

            const SizedBox(height: 20),

            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.selectedDateClasses.isEmpty
                  ? _buildEmptyState(state.selectedDate)
                  : Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16),
                      child: GridView.builder(
                        physics: const BouncingScrollPhysics(),
                        padding: const EdgeInsets.only(bottom: 100),
                        gridDelegate:
                            const SliverGridDelegateWithFixedCrossAxisCount(
                              crossAxisCount: 2,
                              mainAxisSpacing: 14,
                              crossAxisSpacing: 14,
                              childAspectRatio: 185 / 128,
                            ),
                        itemCount: state.selectedDateClasses.length,
                        itemBuilder: (context, i) {
                          final cls = state.selectedDateClasses[i];
                          return ClassComponent(
                            num: '${i + 1}',
                            title: cls.title,
                            themeColor: cls.themeColor,
                            time: cls.time,
                            location: cls.roomNumber,
                            instructor: cls.instructor,
                            start: i == 0,
                            isNotEnabled: true,
                            end: i == state.selectedDateClasses.length - 1,
                          );
                        },
                      ),
                    ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildEmptyState(DateTime date) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.calendar_today_outlined,
            size: 64,
            color: Colors.grey.shade300,
          ),
          const SizedBox(height: 16),
          Text(
            'No classes on this day',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
        ],
      ),
    );
  }
}
