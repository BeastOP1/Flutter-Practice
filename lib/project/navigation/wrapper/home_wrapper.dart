// lib/project/ui/home/home_wrapper_enhanced.dart
import 'package:flutter/material.dart';
import 'package:flutter_learn/project/ui/common/components/bottom_bar_component.dart';
import 'package:flutter_learn/project/ui/home/HomeScreen.dart';
import '../../ui/courses/courses_screen.dart';
import '../../ui/profile/profile_screen.dart';
import '../../ui/result/result_screen.dart';
import '../../ui/schedule/schedule_screen.dart';

class HomeWrapperEnhanced extends StatefulWidget {
  const HomeWrapperEnhanced({super.key});

  @override
  State<HomeWrapperEnhanced> createState() => _HomeWrapperEnhancedState();
}

class _HomeWrapperEnhancedState extends State<HomeWrapperEnhanced> {
  late PageController _pageController;
  late int _selectedIndex;

  final List<NavBarItem> items = [
    NavBarItem(icon: "assets/ic_home.svg", label: "Home"),
    NavBarItem(icon: "assets/ic_course.svg", label: "Courses"),
    NavBarItem(icon: "assets/ic_schedule.svg", label: "Schedule"),
    NavBarItem(icon: "assets/ic_result.svg", label: "Result"),
    NavBarItem(icon: "assets/ic_student.svg", label: "Profile"),
  ];

  final List<Widget> _screens = [
    const HomeScreen(),
    const CourseScreen(),
    const ScheduleScreen(),
    const ResultScreen(),
    const ProfileScreen(),
  ];

  @override
  void initState() {
    super.initState();
    _selectedIndex = 0;
    // _pageController = PageController(initialPage: 0);
  }

  void _onTabChange(int index) {
    setState(() {
      _selectedIndex = index;
      // _pageController.animateToPage(
      //   index,
      //   duration: const Duration(milliseconds: 300),
      //   curve: Curves.easeInOut,
      // );
    });
  }

  @override
  void dispose() {
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _screens[_selectedIndex],
      bottomNavigationBar: LMSNavBar(
        onTabChange: _onTabChange,
        items: items,
      ),
      backgroundColor: Colors.white,
    );
  }
}