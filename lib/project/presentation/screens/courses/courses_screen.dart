import 'package:flutter/material.dart';
import 'package:flutter_learn/project/data/models/course_model.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../providers/course_provider.dart';
import '../../providers/auth_provider.dart';
import '../common/components/icon_button.dart';
import 'course_detail_screen.dart';

class CourseScreen extends ConsumerStatefulWidget {
  const CourseScreen({super.key});

  @override
  ConsumerState<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends ConsumerState<CourseScreen> {
  bool isGridView = false;
  final _searchController = TextEditingController();

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      ref.read(courseProvider.notifier).loadEnrolledCourses();
    });
  }

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final courseState = ref.watch(courseProvider);
    final authState = ref.watch(authProvider);

    final courses = courseState.filteredCourses;
    final isLoading = courseState.isLoading;

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            spacing: 16,
            children: [
              _buildHeader(authState),
              _buildSearchRow(),
              Expanded(
                child: isLoading
                    ? _buildLoadingState()
                    : courses.isEmpty
                    ? _buildEmptyState()
                    : isGridView
                    ? _buildGridView(courses)
                    : _buildListView(courses),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader(authState) {
    final userName = authState.profile?.fullName?.split(' ')[0] ?? 'Student';

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              "Available Courses",
              style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            ),
            Text(
              "Welcome, $userName",
              style: TextStyle(fontSize: 14, color: Colors.grey.shade600),
            ),
          ],
        ),
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
    );
  }

  Widget _buildSearchRow() {
    return Row(
      children: [
        Expanded(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 16),
            decoration: BoxDecoration(
              color: const Color(0xfff3f3f3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              controller: _searchController,
              onChanged: (value) {
                ref.read(courseProvider.notifier).setSearchQuery(value);
              },
              decoration: InputDecoration(
                icon: SvgPicture.asset(
                  'assets/ic_search.svg',
                  colorFilter: const ColorFilter.mode(
                    Color(0xff949494),
                    BlendMode.srcIn,
                  ),
                  height: 22,
                  width: 22,
                ),
                hintText: "Search your Course Here",
                border: InputBorder.none,
                hintStyle: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
          ),
        ),
        const SizedBox(width: 10),
        GestureDetector(
          onTap: () => setState(() => isGridView = !isGridView),
          child: Container(
            padding: const EdgeInsets.all(12),
            decoration: BoxDecoration(
              color: const Color(0xfff3f3f3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(
              isGridView
                  ? Icons.view_headline_rounded
                  : Icons.grid_view_rounded,
              color: const Color(0xFF8A2373),
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildListView(List<CourseModel> courses) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 120),
      physics: const BouncingScrollPhysics(),
      itemCount: courses.length,
      itemBuilder: (context, index) => _courseCard(courses[index], false),
    );
  }

  Widget _buildGridView(List<CourseModel> courses) {
    return GridView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 120),
      physics: const BouncingScrollPhysics(),
      gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
        crossAxisCount: 2,
        childAspectRatio: 1.1,
        crossAxisSpacing: 12,
        mainAxisSpacing: 12,
      ),
      itemCount: courses.length,
      itemBuilder: (context, index) => _courseCard(courses[index], true),
    );
  }

  Widget _courseCard(CourseModel course, bool isGrid) {
    final color = course.displayColor;
    final imagePath = course.imageUrl ?? _getDefaultImage(course.department);

    return GestureDetector(
      onTap: () async {
        // Load course details before navigating
        await ref.read(courseProvider.notifier).loadCourseDetails(course.id);
        if (mounted) {
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => CourseDetailScreen(course: course),
            ),
          );
        }
      },
      child: Container(
        margin: EdgeInsets.only(bottom: isGrid ? 0 : 16),
        clipBehavior: Clip.hardEdge,
        height: isGrid ? null : 110,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.03),
              blurRadius: 10,
            ),
          ],
        ),
        child: isGrid
            ? Column(
          children: [
            _buildImage(course, isGrid),
            _buildInfo(course, color, isGrid),
          ],
        )
            : Row(
          children: [
            _buildImage(course, isGrid),
            Expanded(child: _buildInfo(course, color, isGrid)),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(CourseModel course, bool isGrid) {
    final imagePath = course.imageUrl ?? _getDefaultImage(course.department);

    return ClipRRect(
      borderRadius: isGrid
          ? const BorderRadius.vertical(top: Radius.circular(20))
          : const BorderRadius.only(
        topLeft: Radius.circular(16),
        bottomLeft: Radius.circular(16),
      ),
      child: course.imageUrl != null
          ? Image.network(
        course.imageUrl!,
        width: isGrid ? double.infinity : 125,
        height: isGrid ? 65 : double.infinity,
        fit: BoxFit.cover,
        errorBuilder: (context, error, stackTrace) {
          return Image.asset(
            imagePath,
            width: isGrid ? double.infinity : 125,
            height: isGrid ? 65 : double.infinity,
            fit: BoxFit.cover,
          );
        },
      )
          : Image.asset(
        imagePath,
        width: isGrid ? double.infinity : 125,
        height: isGrid ? 65 : double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInfo(CourseModel course, Color color, bool isGrid) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isGrid ? 8 : 9,
        vertical: isGrid ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: color,
        borderRadius: isGrid
            ? const BorderRadius.vertical(bottom: Radius.circular(20))
            : const BorderRadius.only(
          topRight: Radius.circular(20),
          bottomRight: Radius.circular(20),
        ),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            course.code,
            maxLines: 1,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          Text(
            course.title,
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          Text(
            "Instructor: ${course.instructorName ?? 'TBA'}",
            style: const TextStyle(color: Colors.white70, fontSize: 11),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                "Credit: ${course.credits ?? 'N/A'}",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),
              SvgPicture.asset(
                "assets/ic_fav.svg",
                colorFilter: const ColorFilter.mode(
                  Colors.white,
                  BlendMode.srcIn,
                ),
                height: 20,
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _buildLoadingState() {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 10, bottom: 120),
      itemCount: 6,
      itemBuilder: (context, index) {
        return Container(
          margin: const EdgeInsets.only(bottom: 16),
          height: 125,
          decoration: BoxDecoration(
            color: Colors.grey.shade200,
            borderRadius: BorderRadius.circular(16),
          ),
        );
      },
    );
  }

  Widget _buildEmptyState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Icon(
            Icons.book_outlined,
            size: 64,
            color: Colors.grey.shade400,
          ),
          const SizedBox(height: 16),
          Text(
            'No courses found',
            style: TextStyle(
              fontSize: 18,
              color: Colors.grey.shade600,
            ),
          ),
          const SizedBox(height: 8),
          Text(
            'Enroll in courses to get started',
            style: TextStyle(
              fontSize: 14,
              color: Colors.grey.shade500,
            ),
          ),
        ],
      ),
    );
  }

  String _getDefaultImage(String? department) {
    const images = {
      'Computer Science': 'assets/images/img_cs.png',
      'IT': 'assets/images/img_his.png',
      'Software Engineering': 'assets/images/img_soft.png',
      'Cyber Security': 'assets/images/img_math.png',
    };
    return images[department] ?? 'assets/images/img_cs.png';
  }
}