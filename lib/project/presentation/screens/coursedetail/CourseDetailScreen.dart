import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/screens//common/components/icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class CourseDetailScreen extends StatelessWidget {
  final Map<String, dynamic> course;

  const CourseDetailScreen({super.key, required this.course});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          // ── Header Image with Back Button
          SliverAppBar(
            expandedHeight: 250,
            pinned: true,
            backgroundColor: course['color'],
            leading: Padding(
              padding: const EdgeInsets.all(8.0),
              child: CustomIconButton(
                iconData: Icons.arrow_back_ios_new,
                onBackPress: () => Navigator.pop(context),
              ),
            ),
            flexibleSpace: FlexibleSpaceBar(
              background: Stack(
                fit: StackFit.expand,
                children: [
                  Image.asset(course['img'], fit: BoxFit.cover),
                  Container(color: Colors.black.withOpacity(0.3)), // Overlay
                ],
              ),
            ),
          ),

          // ── Course Information
          SliverToBoxAdapter(
            child: Padding(
              padding: const EdgeInsets.all(20),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Container(
                        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                        decoration: BoxDecoration(
                          color: course['color'].withOpacity(0.1),
                          borderRadius: BorderRadius.circular(20),
                        ),
                        child: Text(
                          course['code'],
                          style: TextStyle(color: course['color'], fontWeight: FontWeight.bold),
                        ),
                      ),
                      const Icon(Icons.share_outlined, color: Colors.grey),
                    ],
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    "PROGRAMMING FUNDAMENTALS (LAB)",
                    style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold, color: Color(0xFF1A1A2E)),
                  ),
                  const SizedBox(height: 10),
                  _infoTile(Icons.person_outline, "Instructor", "Hafiz Anas Ali"),
                  _infoTile(Icons.star_border, "Credit Hours", "3.0 Credits"),
                  _infoTile(Icons.location_on_outlined, "Location", "Lab 04, Ground Floor"),

                  const Divider(height: 40),
                  const Text(
                    "Course Description",
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    "This course covers the fundamental concepts of programming including variables, control structures, functions, and arrays. You will learn how to solve problems using logical thinking and code.",
                    style: TextStyle(color: Colors.grey[600], fontSize: 14, height: 1.5),
                  ),

                  const SizedBox(height: 30),
                  // Syllabus / Topics Section
                  const Text("Syllabus Highlights", style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold)),
                  const SizedBox(height: 12),
                  _syllabusItem("01", "Introduction to Programming"),
                  _syllabusItem("02", "Control Flow & Loops"),
                  _syllabusItem("03", "Functions & Recursion"),

                  const SizedBox(height: 30), // Bottom padding for smooth finish
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
          Text(num, style: const TextStyle(fontWeight: FontWeight.bold, color: Colors.grey)),
          const SizedBox(width: 15),
          Text(title, style: const TextStyle(fontWeight: FontWeight.w500)),
        ],
      ),
    );
  }
}