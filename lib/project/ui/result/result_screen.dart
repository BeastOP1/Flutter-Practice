


import 'package:flutter/material.dart';


class ResultScreen extends StatefulWidget {
  const ResultScreen({super.key});

  @override
  State<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends State<ResultScreen> {
  String _selectedSemester = 'Semester';

  static const List<Color> _cardColors = [
    Color(0xFF8B3A8F), // purple
    Color(0xFF6B3FA0), // violet
    Color(0xFF1A2550), // navy
    Color(0xFFB5860D), // golden
    Color(0xFF4A8080), // teal
    Color(0xFFB84B1A), // burnt orange
    Color(0xFF556B2F), // olive
    Color(0xFF1A7A5E), // emerald
    Color(0xFF7A3030), // burgundy
    Color(0xFF2D5F8A), // steel blue
  ];

  static final List<Map<String, String>> _results = List.filled(
    10,
    const {
      'code':
      'CPR601260-S24-PB-GCL-BSSEM-SPRING 2024-2028-BSSE-S24-1A-LAB-PROGRAMMING FUNDAMENTALS (LAB)',
      'title': 'PROGRAMMING FUNDAMENTALS (LAB)',
      'faculty': 'Faculty of Computer Science and Information Technology-GCL',
      'instructor': 'Hafiz Asad Ali -428888',
      'creditHour': '1',
      'courseCode': 'CPR601232132-S24-PB',
      'grade': 'A+',
    },
  );

  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          children: [
            // ── top bar
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
              child: Row(
                children: [
                  const Spacer(),
                  const Text(
                    'Result',
                    style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w700,
                        color: Color(0xFF1A1A2E)),
                  ),
                  const Spacer(),
                  _notificationBell(),
                ],
              ),
            ),

            // ── stats card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _statsCard(),
            ),

            const SizedBox(height: 16),

            // ── results grid
            Expanded(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.08,
                  ),
                  itemCount: _results.length,
                  itemBuilder: (context, i) =>
                      _resultCard(_results[i], _cardColors[i % _cardColors.length]),
                ),
              ),
            ),

            const SizedBox(height: 10),
          ],
        ),
      ),
    );
  }

  // ── Notification bell ────────────────────────
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
                  offset: const Offset(0, 4))
            ],
          ),
          child: const Icon(Icons.notifications_none_rounded,
              color: Color(0xFF555566), size: 22),
        ),
        Positioned(
          top: -2,
          right: -2,
          child: Container(
            width: 18,
            height: 18,
            decoration:
            const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
            alignment: Alignment.center,
            child: const Text('3',
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 10,
                    fontWeight: FontWeight.bold)),
          ),
        ),
      ],
    );
  }

  // ── Stats card (CGPA + credits) ──────────────
  Widget _statsCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
              color: Colors.black.withOpacity(0.06),
              blurRadius: 18,
              offset: const Offset(0, 6))
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // semester dropdown
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () {},
              child: Container(
                padding:
                const EdgeInsets.symmetric(horizontal: 18, vertical: 8),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E8F5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      _selectedSemester,
                      style: const TextStyle(
                          fontSize: 13,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF8B3A8F)),
                    ),
                    const SizedBox(width: 6),
                    const Icon(Icons.keyboard_arrow_down_rounded,
                        color: Color(0xFF8B3A8F), size: 18),
                  ],
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),

          // CGPA
          _progressRow(
            label: 'Overall CGPA',
            value: '2.0/4.0',
            progress: 2.0 / 4.0,
          ),

          const SizedBox(height: 14),

          // Credits
          _progressRow(
            label: 'Credits Earned',
            value: '28/50',
            progress: 28 / 50,
          ),
        ],
      ),
    );
  }

  Widget _progressRow({
    required String label,
    required String value,
    required double progress,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(label,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w500,
                    color: Color(0xFF888899))),
            Text(value,
                style: const TextStyle(
                    fontSize: 13,
                    fontWeight: FontWeight.w600,
                    color: Color(0xFF1A1A2E))),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value: progress,
            minHeight: 8,
            backgroundColor: const Color(0xFFEEEEF2),
            valueColor:
            const AlwaysStoppedAnimation<Color>(Color(0xFF8B3A8F)),
          ),
        ),
      ],
    );
  }

  // ── Result card ──────────────────────────────
  Widget _resultCard(Map<String, String> data, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: color.withOpacity(0.3),
            blurRadius: 14,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // ── subtle background image overlay (textbook pattern)
            Positioned.fill(
              child: Opacity(
                opacity: 0.18,
                child: Image.network(
                  'https://images.unsplash.com/photo-1456513080510-7bf3a84b82f8?w=400&q=60',
                  fit: BoxFit.cover,
                  errorBuilder: (_, __, ___) => const SizedBox.shrink(),
                ),
              ),
            ),

            // ── dark gradient overlay
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      color.withOpacity(0.5),
                      color.withOpacity(0.88),
                    ],
                  ),
                ),
              ),
            ),

            // ── content
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  // course code (small)
                  Text(
                    data['code']!,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 7.5,
                      fontWeight: FontWeight.w600,
                      height: 1.35,
                    ),
                  ),
                  const SizedBox(height: 3),
                  Text(
                    data['faculty']!,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 7,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    'Instructor : ${data['instructor']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 7,
                    ),
                  ),
                  Text(
                    'Credit Hour : ${data['creditHour']}',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 7,
                    ),
                  ),
                  Text(
                    'Course Code : ${data['courseCode']}',
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.8),
                      fontSize: 7,
                    ),
                  ),
                  const Spacer(),
                  // Result badge
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 10, vertical: 3),
                      decoration: BoxDecoration(
                        color: Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                            color: Colors.white.withOpacity(0.3), width: 0.5),
                      ),
                      child: Text(
                        'Result : ${data['grade']}',
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 11,
                          fontWeight: FontWeight.w800,
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}