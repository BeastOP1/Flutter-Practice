import 'package:flutter/material.dart';
import 'package:flutter_learn/project/ui/common/components/app_bar_component.dart';
import 'package:flutter_learn/project/ui/common/components/bottom_bar_component.dart';

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


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(double.maxFinite, 70),
        child:  LMSAppBar(userName:   "Hassan Farooq Siddiqi",onMenuPress: (){}),
      ),
      bottomNavigationBar: LMSNavBar(onTabChange: (e){}, items: items),

      backgroundColor: Colors.white,
      body: const Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Home")
        ],
      ),
    );
  }
}

