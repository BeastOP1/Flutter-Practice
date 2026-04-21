// lib/presentation/screens/result/result_screen.dart
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/result_provider.dart';
import '../common/components/icon_button.dart';
import '../../../data/models/result_model.dart';

class ResultScreen extends ConsumerStatefulWidget {
  const ResultScreen({super.key});

  @override
  ConsumerState<ResultScreen> createState() => _ResultScreenState();
}

class _ResultScreenState extends ConsumerState<ResultScreen> {

  static const List<Color> _cardColors = [
    Color(0xFF8B3A8F), Color(0xFF6B3FA0), Color(0xFF1A2550),
    Color(0xFFB5860D), Color(0xFF4A8080), Color(0xFFB84B1A),
    Color(0xFF556B2F), Color(0xFF1A7A5E), Color(0xFF7A3030),
    Color(0xFF2D5F8A),
  ];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(resultProvider.notifier).loadResults();
    });
  }

  @override
  Widget build(BuildContext context) {
    final state = ref.watch(resultProvider);

    return Scaffold(
      backgroundColor: const Color(0xFFF5F5F7),
      body: SafeArea(
        child: Column(
          children: [
            // ── Header
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
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const Spacer(),
                  Stack(
                    children: [
                      const CustomIconButton(marginEnd: false),
                      Positioned(
                        right: 4, top: 0,
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

            // ── Stats Card
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: _statsCard(state),
            ),

            const SizedBox(height: 16),

            // ── Grid
            Expanded(
              child: state.isLoading
                  ? const Center(child: CircularProgressIndicator())
                  : state.filteredResults.isEmpty
                  ? _buildEmptyState()
                  : Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16),
                child: GridView.builder(
                  physics: const BouncingScrollPhysics(),
                  padding: const EdgeInsets.only(bottom: 100),
                  gridDelegate:
                  const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount:  2,
                    mainAxisSpacing: 12,
                    crossAxisSpacing: 12,
                    childAspectRatio: 1.08,
                  ),
                  itemCount: state.filteredResults.length,
                  itemBuilder: (context, i) => _resultCard(
                    state.filteredResults[i],
                    _cardColors[i % _cardColors.length],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _statsCard(ResultState state) {
    final semesters = ['All', ...state.semesters];
    final selected  = state.selectedSemester ?? 'All';
    final cgpaStr   = state.cgpa.toStringAsFixed(1);

    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.06),
            blurRadius: 18,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.stretch,
        children: [
          // ← Semester dropdown
          Align(
            alignment: Alignment.centerRight,
            child: GestureDetector(
              onTap: () => _showSemesterPicker(semesters, selected),
              child: Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 18, vertical: 8,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFFF0E8F5),
                  borderRadius: BorderRadius.circular(30),
                ),
                child: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text(
                      selected,
                      style: const TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: Color(0xFF8B3A8F),
                      ),
                    ),
                    const SizedBox(width: 6),
                    const Icon(
                      Icons.keyboard_arrow_down_rounded,
                      color: Color(0xFF8B3A8F),
                      size: 18,
                    ),
                  ],
                ),
              ),
            ),
          ),
          const SizedBox(height: 16),
          _progressRow(
            label:    'Overall CGPA',
            value:    '$cgpaStr/4.0',
            progress: state.cgpa / 4.0,
          ),
          const SizedBox(height: 14),
          _progressRow(
            label:    'Credits Earned',
            value:    '${state.totalCredits}/${state.maxCredits}',
            progress: state.totalCredits / state.maxCredits,
          ),
        ],
      ),
    );
  }

  void _showSemesterPicker(List<String> semesters, String selected) {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (_) => ListView(
        shrinkWrap: true,
        children: semesters.map((s) => ListTile(
          title: Text(s),
          trailing: s == selected
              ? const Icon(Icons.check, color: Color(0xFF8B3A8F))
              : null,
          onTap: () {
            ref.read(resultProvider.notifier)
                .filterBySemester(s == 'All' ? null : s);
            Navigator.pop(context);
          },
        )).toList(),
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
                  color: Color(0xFF888899),
                )),
            Text(value,
                style: const TextStyle(
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                  color: Color(0xFF1A1A2E),
                )),
          ],
        ),
        const SizedBox(height: 8),
        ClipRRect(
          borderRadius: BorderRadius.circular(8),
          child: LinearProgressIndicator(
            value:           progress.clamp(0.0, 1.0),
            minHeight:       8,
            backgroundColor: const Color(0xFFEEEEF2),
            valueColor: const AlwaysStoppedAnimation<Color>(
              Color(0xFF8B3A8F),
            ),
          ),
        ),
      ],
    );
  }

  Widget _resultCard(ResultModel result, Color color) {
    return Container(
      decoration: BoxDecoration(
        color: color,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color:  color.withOpacity(0.3),
            blurRadius: 14,
            offset: const Offset(0, 6),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(16),
        child: Stack(
          children: [
            // Background gradient
            Positioned.fill(
              child: DecoratedBox(
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end:   Alignment.bottomCenter,
                    colors: [
                      color.withOpacity(0.5),
                      color.withOpacity(0.88),
                    ],
                  ),
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(10),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    result.courseCode,
                    maxLines: 1,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 7.5,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    result.courseTitle,
                    maxLines: 2,
                    overflow: TextOverflow.ellipsis,
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 8,
                      fontWeight: FontWeight.w700,
                      height: 1.3,
                    ),
                  ),
                  const SizedBox(height: 2),
                  if (result.faculty != null)
                    Text(
                      result.faculty!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 7,
                      ),
                    ),
                  if (result.instructorName != null)
                    Text(
                      'Instructor: ${result.instructorName}',
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 7,
                      ),
                    ),
                  if (result.credits != null)
                    Text(
                      'Credit Hours: ${result.credits}',
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 7,
                      ),
                    ),
                  if (result.semester != null)
                    Text(
                      result.semester!,
                      maxLines: 1,
                      overflow: TextOverflow.ellipsis,
                      style: TextStyle(
                        color: Colors.white.withOpacity(0.8),
                        fontSize: 7,
                      ),
                    ),
                  const Spacer(),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                        horizontal: 10, vertical: 3,
                      ),
                      decoration: BoxDecoration(
                        color:  Colors.white.withOpacity(0.15),
                        borderRadius: BorderRadius.circular(6),
                        border: Border.all(
                          color: Colors.white.withOpacity(0.3),
                          width: 0.5,
                        ),
                      ),
                      child: Text(
                        'Result: ${result.finalGrade ?? 'N/A'}',
                        style: const TextStyle(
                          color:      Colors.white,
                          fontSize:   11,
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

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(Icons.school_outlined, size: 64, color: Colors.grey.shade300),
          const SizedBox(height: 16),
          Text(
            'No results found',
            style: TextStyle(fontSize: 16, color: Colors.grey.shade500),
          ),
          const SizedBox(height: 8),
          Text(
            'Results will appear after semester completion',
            style: TextStyle(fontSize: 13, color: Colors.grey.shade400),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }
}