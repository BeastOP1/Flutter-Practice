import 'package:flutter/material.dart';
import 'package:flutter_learn/project/ui/common/components/class_component.dart';
import 'package:flutter_learn/project/ui/common/components/icon_button.dart';

class ScheduleScreen extends StatefulWidget {
  const ScheduleScreen({super.key});

  @override
  State<ScheduleScreen> createState() => _ScheduleScreenState();
}

class _ScheduleScreenState extends State<ScheduleScreen> {
  DateTime _focusedMonth = DateTime(2025, 4);
  final DateTime _today = DateTime(2025, 4, 20);

  static const List<Color> _cardColors = [
    Color(0xFF8B3A8F),
    Color(0xFFB5860D),
    Color(0xFF556B2F),
    Color(0xFF4A8080),
    Color(0xFFB84B1A),
    Color(0xFF1A2550),
  ];

  int _daysInMonth(DateTime d) => DateTime(d.year, d.month + 1, 0).day;

  int _firstWeekday(DateTime d) {
    // weekday: Mon=1…Sun=7 → we want Sun=0
    final wd = DateTime(d.year, d.month, 1).weekday % 7;
    return wd;
  }

  void _prevMonth() => setState(
    () => _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month - 1),
  );

  void _nextMonth() => setState(
    () => _focusedMonth = DateTime(_focusedMonth.year, _focusedMonth.month + 1),
  );

  String _monthName(int m) => const [
    '',
    'January',
    'February',
    'March',
    'April',
    'May',
    'June',
    'July',
    'August',
    'September',
    'October',
    'November',
    'December',
  ][m];

  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  const Spacer(),
                  const Text(
                    'Schedule',
                    style: TextStyle(
                      fontSize: 22,
                      fontWeight: FontWeight.w700,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      CustomIconButton(),
                      Positioned(
                        right: 4,
                        top: 0,
                        child: Container(
                          padding: const EdgeInsets.all(4),
                          decoration: const BoxDecoration(
                            color: Colors.red,
                            shape: BoxShape.circle,
                          ),
                          child: const Text(
                            "3",
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 10,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _calendarCard(),
            ),

            const SizedBox(height: 20),

            // ── class cards grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 14,
                    crossAxisSpacing: 14,
                    childAspectRatio: 185 / 128,
                  ),
                  itemCount: 6,
                  itemBuilder: (context, i) => ClassComponent(
                    num: '${i + 1}',
                    title: 'Computer Networks',
                    themeColor: _cardColors[i],
                    time: '12:00 - 2:00',
                    start: false,
                    end: true,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ── Notification bell widget ─────────────────
  Widget _notificationBell() {
    return Stack(
      clipBehavior: Clip.none,
      children: [
        Container(
          width: 44,
          height: 44,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black.withOpacity(0.08),
                blurRadius: 10,
                offset: const Offset(0, 4),
              ),
            ],
          ),
          child: const Icon(
            Icons.notifications_none_rounded,
            color: Color(0xFF555566),
            size: 22,
          ),
        ),
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            width: 18,
            height: 18,
            decoration: const BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            alignment: Alignment.center,
            child: const Text(
              '3',
              style: TextStyle(
                color: Colors.white,
                fontSize: 10,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ],
    );
  }

  // ── Calendar card ────────────────────────────
  Widget _calendarCard() {
    final days = _daysInMonth(_focusedMonth);
    final offset = _firstWeekday(_focusedMonth);
    final totalCells = offset + days;

    return Container(
      padding: const EdgeInsets.fromLTRB(16, 16, 16, 12),
      decoration: BoxDecoration(
        color: Colors.white,
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
          // month header
          Row(
            children: [
              Text(
                '${_monthName(_focusedMonth.month)} ${_focusedMonth.year}',
                style: const TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w700,
                  color: Color(0xFF1A1A2E),
                ),
              ),
              const SizedBox(width: 4),
              const Icon(
                Icons.chevron_right,
                color: Color(0xFF8B3A8F),
                size: 20,
              ),
              const Spacer(),
              GestureDetector(
                onTap: _prevMonth,
                child: const Icon(
                  Icons.chevron_left,
                  color: Color(0xFF8B3A8F),
                  size: 22,
                ),
              ),
              const SizedBox(width: 8),
              GestureDetector(
                onTap: _nextMonth,
                child: const Icon(
                  Icons.chevron_right,
                  color: Color(0xFFB5860D),
                  size: 22,
                ),
              ),
            ],
          ),
          const SizedBox(height: 10),
          // day headers
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: const ['SUN', 'MON', 'WED', 'THU', 'FRI', 'SAT', 'SUN']
                .map(
                  (d) => SizedBox(
                    width: 36,
                    child: Text(
                      d,
                      textAlign: TextAlign.center,
                      style: const TextStyle(
                        fontSize: 10,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFFAAAAAA),
                      ),
                    ),
                  ),
                )
                .toList(),
          ),
          const SizedBox(height: 6),
          // date grid
          GridView.builder(
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
              final isToday =
                  _focusedMonth.year == _today.year &&
                  _focusedMonth.month == _today.month &&
                  day == _today.day;
              final isTuesdayFirst = day == 1; // red color for 1st (Tuesday)
              return Center(
                child: Container(
                  width: 32,
                  height: 32,
                  decoration: isToday
                      ? BoxDecoration(
                          color: const Color(0xFFE8D5F0),
                          shape: BoxShape.circle,
                        )
                      : null,
                  alignment: Alignment.center,
                  child: Text(
                    '$day',
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: isToday ? FontWeight.w800 : FontWeight.w500,
                      color: isToday
                          ? const Color(0xFF8B3A8F)
                          : isTuesdayFirst
                          ? const Color(0xFFB84B1A)
                          : const Color(0xFF2A2A3E),
                    ),
                  ),
                ),
              );
            },
          ),
        ],
      ),
    );
  }

  // ── Class card ───────────────────────────────
  Widget _classCard({
    required String num,
    required String title,
    required Color themeColor,
    required String time,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: themeColor.withOpacity(0.35), width: 0.8),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.18),
            blurRadius: 16,
            offset: const Offset(0, 8),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(20),
        child: Stack(
          children: [
            // ── background wave shape
            Positioned(
              top: -12,
              left: -12,
              right: -12,
              child: Container(
                height: 62,
                decoration: BoxDecoration(
                  color: themeColor,
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
            ),

            // ── curved wave bottom edge
            Positioned(
              top: 32,
              left: -12,
              right: -12,
              child: CustomPaint(
                size: const Size(double.infinity, 30),
                painter: _WavePainter(themeColor),
              ),
            ),

            // ── title
            Positioned(
              top: 8,
              left: 50,
              right: 12,
              child: Text(
                title,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 12,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),

            // ── big number
            Positioned(
              left: 12,
              top: 22,
              child: Text(
                num,
                style: TextStyle(
                  fontSize: 38,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: themeColor,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.12),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
            ),

            // ── details
            Positioned(
              left: 46,
              top: 38,
              right: 8,
              bottom: 6,
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _detail(Icons.access_time_rounded, time, themeColor),
                  const SizedBox(height: 2),
                  _detail(Icons.location_on_outlined, 'Room No 25', themeColor),
                ],
              ),
            ),

            // ── bell icon
            Positioned(
              bottom: 8,
              right: 10,
              child: Icon(
                Icons.notifications_none_rounded,
                color: themeColor.withOpacity(0.7),
                size: 16,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _detail(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 11, color: color),
        const SizedBox(width: 3),
        Flexible(
          child: Text(
            text,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              fontSize: 10.5,
              color: color,
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }
}

// ── Wave painter for card background ─────────
class _WavePainter extends CustomPainter {
  final Color color;

  _WavePainter(this.color);

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path()
      ..moveTo(0, 0)
      ..quadraticBezierTo(size.width * 0.5, 28, size.width, 0)
      ..lineTo(size.width, 30)
      ..lineTo(0, 30)
      ..close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter old) => false;
}
