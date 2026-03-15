import 'package:flutter/material.dart';
import '../components/icon_item.dart';

class UserInterestScreen extends StatefulWidget {
  const UserInterestScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserInterestScreenState();
}

class _UserInterestScreenState extends State<UserInterestScreen> {

  @override
  void initState() {
    super.initState();
  }

  @override
  void dispose() {
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        const SizedBox(height: 10),
        const Text(
          "STEP 6/7",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF7265E3),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          "Time to customize your interest",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),

        const SizedBox(height: 20),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            IconItemWithText(
              onTap: () {},
              iconText: "🍉",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Nutrition",
            ),
            IconItemWithText(
              onTap: () {},
              iconText: "🌾",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Organic",
              selectionColor: Color(0xFFFF9B90),
            ),
            IconItemWithText(
              onTap: () {},
              iconText: "🍃",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Meditation",
              selectionColor: Color(0xFF7FE3F0),
            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            IconItemWithText(
              onTap: () {},
              iconText: "🏂",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Sports",
            ),
            IconItemWithText(
              onTap: () {},
              iconText: "🚬",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Smoke Free",
              selectionColor: Color(0xFFFF9B90),

            ),
            IconItemWithText(
              onTap: () {},
              iconText: "🛏",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Sleep",
              selectionColor: Color(0xFF7FE3F0),

            ),
          ],
        ),

        const SizedBox(height: 10),

        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            IconItemWithText(
              onTap: () {},
              iconText: "💪",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Health",
            ),
            IconItemWithText(
              onTap: () {},
              iconText: "👟",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Running",
              selectionColor: Color(0xFFFF9B90),

            ),
            IconItemWithText(
              onTap: () {},
              iconText: "🥑",
              iconSize: Size(90, 90),
              padding: 0,
              title: "Vegan",
              selectionColor: Color(0xFF7FE3F0),

            ),
          ],
        ),

        const SizedBox(height: 30),

        FilledButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => OnboardingFlow()),
            // );
          },
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF7265E3),
            padding: EdgeInsets.symmetric(horizontal: 130, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(18),
            ),
          ),
          child: Text(
            "Continue",
            style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.2,
              fontFamily: "Rubik",
              color: Colors.white,
            ),
          ),
        ),
      ],
    );
  }
}
