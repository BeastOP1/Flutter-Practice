import 'package:flutter/material.dart';
import 'package:flutter_learn/project/data/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../providers/course_provider.dart';
import '../common/components/icon_button.dart';

class CourseDetailScreen extends ConsumerWidget {
  final CourseModel course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final courseState = ref.watch(courseProvider);
    final selectedCourse = courseState.selectedCourse ?? course;
    final isLoading = courseState.isLoadingDetails;

    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: selectedCourse.displayColor,
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIconButton(
                iconData: Icons.arrow_back_ios_new,
                onBackPress: () {
                  ref.read(courseProvider.notifier).clearSelectedCourse();
                  Navigator.pop(context);
                },
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  selectedCourse.imageUrl != null
                      ? Image.network(
                    selectedCourse.imageUrl!,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) {
                      return Image.asset(
                        'assets/images/img_cs.png',
                        fit: BoxFit.cover,
                      );
                    },
                  )
                      : Image.asset(
                    'assets/images/img_cs.png',
                    fit: BoxFit.cover,
                  ),
                  Container(color: Colors.black.withOpacity(0.3)),
                ],
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: isLoading
                ? _buildLoadingDetails()
                : Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(
                          horizontal: 12,
                          vertical: 6,
                        ),
                        decoration: BoxDecoration(
                          color: selectedCourse.displayColor.withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          selectedCourse.code,
                          style: TextStyle(
                            color: selectedCourse.displayColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                      const Icon(Icons.share_outlined, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 15),
                  Text(
                    selectedCourse.title,
                    style: const TextStyle(
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF1A1A2E),
                    ),
                  ),
                  const SizedBox(height: 10),
                  _infoTile(
                    Icons.person_outline,
                    "Instructor",
                    selectedCourse.instructorName ?? 'TBA',
                  ),
                  _infoTile(
                    Icons.star_border,
                    "Credit Hours",
                    "${selectedCourse.credits ?? 'N/A'} Credits",
                  ),
                  _infoTile(
                    Icons.location_on_outlined,
                    "Location",
                    selectedCourse.roomNumber ?? selectedCourse.location ?? 'TBA',
                  ),
                  const Divider(height: 40),
                  const Text(
                    "Course Description",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    selectedCourse.description ?? 'No description available.',
                    style: TextStyle(
                      color: Colors.grey[600],
                      fontSize: 14,
                      height: 1.5,
                    ),
                  ),
                  const SizedBox(height: 30),
                  const Text(
                    "Syllabus Highlights",
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 12),
                  ...courseState.syllabus.map(
                        (item) => _syllabusItem(item['num'], item['title']),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _infoTile(IconData icon, String label, String value) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8),
      child: Row(
        children: [
          Icon(icon, size: 20, color: Colors.grey),
          const SizedBox(width: 10),
          Text("$label: ", style: const TextStyle(color: Colors.grey)),
          Text(value, style: const TextStyle(fontWeight: FontWeight.w600)),
        ],
      ),
    );
  }

  Widget _syllabusItem(String num, String title) {
    return Container(
      margin: const EdgeInsets.only(bottom: 10),
      padding: const EdgeInsets.all(12),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey.shade200),
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: [
          Text(
            num,
            style: const TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.grey,
            ),
          ),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }

  Widget _buildLoadingDetails() {
    return const Padding(
      padding: EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 20),
          Center(child: CircularProgressIndicator()),
          SizedBox(height: 20),
        ],
      ),
    );
  }
}