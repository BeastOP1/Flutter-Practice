import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/app_bar_component.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/bottom_bar_component.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/class_component.dart';
import 'package:flutter_learn/project/presentation/screens/assignment/AssignmentUploadScreen.dart';
import 'package:flutter_svg/flutter_svg.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  var items = [
    NavBarItem(icon: "assets/ic_home.svg", label: "Home"),
    NavBarItem(icon: "assets/ic_course.svg", label: "Courses"),
    NavBarItem(icon: "assets/ic_schedule.svg", label: "Schedule"),
    NavBarItem(icon: "assets/ic_result.svg", label: "Result"),
    NavBarItem(icon: "assets/ic_student.svg", label: "Profile"),
  ];

  bool isNewsSelected = true;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 70),
        child: LMSAppBar(userName: "Hassan Farooq Siddiqi", onMenuPress: () {}),
      ),
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisAlignment: MainAxisAlignment.start,
          spacing: 16,
          children: [
            _buildCategories(),
            _buildSectionTitle("Today's Classes", "Open Schedule"),
            _buildClassesRow(),
            _buildSectionTitle("Today's Submission", "See All"),
            _buildSubmissionsRow(),
            _buildNewsEventsToggle(),
            isNewsSelected ? _buildNewsCard() : _buildEventsCard(),
          ],
        ),
      ),
    );
  }

  Widget _buildCategories() {
    final List<Map<String, String>> catData = [
      {"title": "Computer Science", "img": "assets/images/img_cs.png"},
      {"title": "IT", "img": "assets/images/img_his.png"},
      {"title": "Software Engineering", "img": "assets/images/img_soft.png"},
      {"title": "Cyber Security", "img": "assets/images/img_math.png"},
    ];

    return SizedBox(
      height: 120,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        itemCount: catData.length,
        itemBuilder: (context, index) {
          return Container(
            width: 125,

            margin: EdgeInsets.only(right: 16, left: (index == 0) ? 16 : 0),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(15),
              image: DecorationImage(
                image: AssetImage(catData[index]["img"]!),
                fit: BoxFit.cover,
                colorFilter: ColorFilter.mode(
                  Colors.black.withOpacity(0.25),
                  BlendMode.darken,
                ),
              ),
            ),
            padding: const EdgeInsets.all(10),
            alignment: Alignment.bottomLeft,
            child: Text(
              catData[index]["title"]!,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 11,
                fontWeight: FontWeight.bold,
              ),
            ),
          );
        },
      ),
    );
  }

  Widget _buildClassesRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      // clipBehavior ko none rakha hai taake shadow na katsaky
      clipBehavior: Clip.none,
      child: Row(
        children: [
          ClassComponent(
            start: true,
            themeColor: const Color(0xFF8A2373),
            title: 'Computer Networks',
            time: '12:00 - 2:00',
            num: '1',
          ),

          ClassComponent(
            num: "2",
            title: "Operating Systems",
            themeColor: Colors.orange,
            time: "02:00 - 04:00",
            start: false,
          ),
          ClassComponent(
            num  :"3",
            title:"Data Structures",
            themeColor:Colors.blue,
            time: "04:30 - 06:30",
           start:  false,
          ),
        ],
      ),
    );
  }

  Widget _buildSubmissionsRow() {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          _submitCard("Computer Networks", const Color(0xFF8A2373), true),
          _submitCard("Operating System", Colors.lightGreen, false),
          _submitCard("Mathematics", Colors.orange, false),
        ],
      ),
    );
  }

  Widget _submitCard(String title, Color themeColor, bool start) {
    return GestureDetector(
      onTap: () {
        // Navigation Logic
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => AssignmentUploadScreen(title: title),
          ),
        );
      },
      child: Container(
        width: 155,
        height: 135,
        margin: EdgeInsets.only(right: 16, bottom: 16, left: start ? 16 : 0),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(20),
          boxShadow: [
            BoxShadow(
              color: themeColor.withOpacity(0.15),
              blurRadius: 15,
              offset: const Offset(0, 8),
              spreadRadius: -2,
            ),
          ],
        ),
        child: Column(
          children: [
            Container(
              width: double.infinity,
              padding: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                color: themeColor,
                borderRadius: const BorderRadius.only(
                  topLeft: Radius.circular(25),
                  topRight: Radius.circular(25),
                ),
              ),
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 13,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
              child: Column(
                children: [
                  _submissionDetailItem(
                    Icons.copy_rounded,
                    "Assignment #08",
                    themeColor,
                  ),
                  const SizedBox(height: 8),
                  _submissionDetailItem(
                    Icons.person_outline_rounded,
                    "Sir Ali",
                    themeColor,
                  ),
                  const SizedBox(height: 8),
                  _submissionDetailItem(
                    Icons.timer_outlined,
                    "12 Hours Left",
                    themeColor,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _submissionDetailItem(IconData icon, String text, Color color) {
    return Row(
      children: [
        Icon(icon, size: 18, color: color),
        const SizedBox(width: 10),
        Expanded(
          child: Text(
            text,
            style: const TextStyle(
              fontSize: 11,
              color: Color(0xFF1D2939),
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildNewsEventsToggle() {
    return
      Container(
        width: 150,
        margin: EdgeInsetsGeometry.symmetric(horizontal: 16),
        padding: EdgeInsetsGeometry.all(8),
        decoration: BoxDecoration(
          border: BoxBorder.all(color: Color(0xffe9eae9)),
          borderRadius: BorderRadius.circular(25),
        ),
        child: Row(
          spacing: 8,
          children: [
            _toggleBtn(
              "News",
              isNewsSelected,
                  () => setState(() => isNewsSelected = true),
            ),
            _toggleBtn(
              "Events",
              !isNewsSelected,
                  () => setState(() => isNewsSelected = false),
            ),
          ],
        ),
      );

  }

  Widget _toggleBtn(String text, bool active, VoidCallback tap) {
    return GestureDetector(
      onTap: tap,
      child: Container(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
        decoration: BoxDecoration(
          color: active ? const Color(0xFF8A2373) : Colors.grey[100],
          borderRadius: BorderRadius.circular(20),
        ),
        child: Text(
          text,
          style: TextStyle(
            color: active ? Colors.white : Colors.black,
            fontSize: 12,
            fontWeight: FontWeight.w500,
          ),
        ),
      ),
    );
  }

  Widget _buildNewsCard() {
    return Container(
      margin: EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF4FB),
        boxShadow: [
          BoxShadow(
            color: Color(0x358D2072),
            offset: Offset(0, 2),
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "Lorem Ipsum",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8A2373),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Stay updated with the latest happenings in your campus and abroad.",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  _iconText(Icons.location_on, "Islamabad"),
                  _iconText(Icons.calendar_today, "23 Mar, 2026"),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                "assets/images/img_news.png",
                height: 171,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildEventsCard() {
    return Container(
      margin: EdgeInsetsGeometry.only(left: 16, right: 16, bottom: 16),
      decoration: BoxDecoration(
        color: const Color(0xFFFDF4FB),
        boxShadow: [
          BoxShadow(
            color: Color(0x358D2072),
            offset: Offset(0, 2),
            blurStyle: BlurStyle.outer,
          ),
        ],
        borderRadius: BorderRadius.circular(20),
      ),
      child: Row(
        children: [
          Expanded(
            flex: 6,
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    "IDP Study Abroad Expo",
                    style: const TextStyle(
                      fontWeight: FontWeight.bold,
                      color: Color(0xFF8A2373),
                      fontSize: 14,
                    ),
                  ),
                  const SizedBox(height: 5),
                  const Text(
                    "Stay updated with the latest happenings in your campus and abroad.",
                    style: TextStyle(fontSize: 10, color: Colors.grey),
                  ),
                  const SizedBox(height: 10),
                  _iconText(Icons.location_on, "Islamabad"),
                  _iconText(Icons.calendar_today, "23 Mar, 2026"),
                ],
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: ClipRRect(
              borderRadius: const BorderRadius.only(
                topRight: Radius.circular(20),
                bottomRight: Radius.circular(20),
              ),
              child: Image.asset(
                "assets/images/img_events.png",
                height: 170,
                fit: BoxFit.cover,
                errorBuilder: (context, error, stackTrace) =>
                    const Icon(Icons.image, size: 50, color: Colors.grey),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildSectionTitle(String title, String action) {
    return Padding(
      padding: EdgeInsets.symmetric(horizontal: 16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            title,
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Row(
            children: [
              Text(
                action,
                style: const TextStyle(
                  color: Color(0xFF8A2373),
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
              const Icon(
                Icons.arrow_forward_ios,
                size: 16,
                color: Color(0xFF8A2373),
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget _iconText(IconData icon, String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        children: [
          Icon(icon, size: 15, color: Colors.grey[600]),
          const SizedBox(width: 6),
          Text(text, style: TextStyle(fontSize: 10, color: Colors.grey[600])),
        ],
      ),
    );
  }
}
