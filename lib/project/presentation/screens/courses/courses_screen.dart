import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_learn/project/presentation/screens/coursedetail/CourseDetailScreen.dart';
class CourseScreen extends StatefulWidget {
  const CourseScreen({super.key});

  @override
  State<CourseScreen> createState() => _CourseScreenState();
}

class _CourseScreenState extends State<CourseScreen> {
  bool isGridView = false;

  final List<Map<String, dynamic>> courses = [
    {
      "code": "CS-RC0103",
      "color": const Color(0xFF4C4D56),
      "img": "assets/images/img_cs.png",
    },
    {
      "code": "EE-RC0110",
      "color": const Color(0xFFC04E2D),
      "img": "assets/images/img_his.png",
    },
    {
      "code": "MT-RC0120",
      "color": const Color(0xFF7A813E),
      "img": "assets/images/img_soft.png",
    },
    {
      "code": "HU-RC0130",
      "color": const Color(0xFFB06F23),
      "img": "assets/images/img_his.png",
    },
    {
      "code": "PH-RC0140",
      "color": const Color(0xFF8A2373),
      "img": "assets/images/img_math.png",
    },
    {
      "code": "CH-RC0150",
      "color": const Color(0xFF2D6A4F),
      "img": "assets/images/img_his.png",
    },
    {
      "code": "CS-AD9900",
      "color": const Color(0xFF2D3250),
      "img": "assets/images/img_cs.png",
    },
    {
      "code": "EE-XT1122",
      "color": const Color(0xFF7077A1),
      "img": "assets/images/img_his.png",
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        // Bottom: false taake content bottom bar ke peeche tak jaye (Professional look)
        bottom: false,
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Column(
            spacing: 16,
            children: [
              _buildHeader(),
              _buildSearchRow(),
              Expanded(
                // IndexedStack ya Simple condition for switching
                child: isGridView ? _buildGridView() : _buildListView(),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          child: Text(
            "Available Courses",
            style: TextStyle(fontSize: 22, fontWeight: FontWeight.bold),
            textAlign: TextAlign.center,
          ),
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
              color: Color(0xfff3f3f3),
              borderRadius: BorderRadius.circular(25),
            ),
            child: TextField(
              decoration: InputDecoration(
                icon: SvgPicture.asset(
                  'assets/ic_search.svg',
                  color: Color(0xff949494),
                  height: 22,
                  width: 22,
                ),
                hintText: "Search your Course Here",
                border: InputBorder.none,
                hintStyle: TextStyle(fontSize: 16, fontWeight: FontWeight.w400),
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

  Widget _buildListView() {
    return ListView.builder(
      // Padding bottom 120 taake last item bottom bar ke peeche na chupe
      padding: const EdgeInsets.only(top: 10, bottom: 120),
      physics: const BouncingScrollPhysics(), // Smooth scrolling effect
      itemCount: courses.length,
      itemBuilder: (context, index) => _courseCard(courses[index], false),
    );
  }

  Widget _buildGridView() {
    return GridView.builder(
      // Same padding logic for Grid
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

  Widget _courseCard(Map<String, dynamic> course, bool isGrid) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => CourseDetailScreen(course: course),
          ),
        );
      },
      child: Container(
        margin: EdgeInsets.only(bottom: isGrid ? 0 : 16),
        height: isGrid ? 60 : 125,
        clipBehavior: Clip.hardEdge,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(color: Colors.black.withOpacity(0.03), blurRadius: 10),
          ],
        ),
        child: isGrid
            ? Column(
          children: [
            _buildImage(course, true),
            // Expanded(child: ),
            _buildInfo(course, true),
          ],
        )
            : Row(
          spacing: 0,
          children: [
            _buildImage(course, false),
            Expanded(child: _buildInfo(course, false)),
          ],
        ),
      ),
    );
  }

  Widget _buildImage(Map<String, dynamic> course, bool isGrid) {
    return ClipRRect(
      borderRadius: isGrid
          ? const BorderRadius.vertical(top: Radius.circular(20))
          : const BorderRadius.only(
              topLeft: Radius.circular(16),
              bottomLeft: Radius.circular(16),
            ),
      child: Image.asset(
        course['img'],
        width: isGrid ? double.infinity : 125,
        height: isGrid ? 65 : double.infinity,
        fit: BoxFit.cover,
      ),
    );
  }

  Widget _buildInfo(Map<String, dynamic> course, bool isGrid) {
    return Container(
      padding: EdgeInsets.symmetric(
        horizontal: isGrid ? 8 : 9,
        vertical: isGrid ? 12 : 16,
      ),
      decoration: BoxDecoration(
        color: course['color'],
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
            "${course['code']}-S24-PB-DCL1",
            maxLines: 1,
            style: TextStyle(
              color: Colors.white,
              fontSize: isGrid ? 11 : 12,
              fontWeight: FontWeight.bold,
            ),
          ),
          const Text(
            "PROGRAMMING FUNDAMENTALS (LAB)",
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            style: TextStyle(
              color: Colors.white,
              fontSize: 12,
              fontWeight: FontWeight.w600,
            ),
          ),
          const SizedBox(height: 2),
          const Text(
            "Instructor: Hafiz Anas Ali",
            style: TextStyle(color: Colors.white70, fontSize: 11),
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,

            children: [
              Text(
                "Credit Hour: 3",
                style: const TextStyle(color: Colors.white70, fontSize: 12),
              ),

              SvgPicture.asset(
                "assets/ic_fav.svg",
                color: Colors.white,
                height: 20,
                width: 20,
              ),
            ],
          ),
        ],
      ),
    );
  }
}
