import 'package:flutter/material.dart';
import 'package:flutter_learn/assignment/components/user_choice_item.dart';
import '../components/icon_item.dart';

class UserChoiceScreen extends StatefulWidget {
  const UserChoiceScreen({super.key});

  @override
  State<StatefulWidget> createState() => _UserChoiceScreenState();
}

class _UserChoiceScreenState extends State<UserChoiceScreen> {

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
          "STEP 7/7",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF7265E3),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          "Let us know how we\n can help you",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Text(
          "You always can change this later",
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(color: Color(0xFF4C5980), fontSize: 20),
        ),
        const SizedBox(height: 20),


        Column(
          mainAxisAlignment: MainAxisAlignment.center,
          spacing: 32,
          children: [
            UserChoiceItem(
              onTap: () {},
              iconText: "🍉",
              height: 90,
              padding: 0,
              title: "Nutrition",
            ),
            UserChoiceItem(
              onTap: () {},
              iconText: "🌾",
              height: 80,

              padding: 0,
              title: "Organic",
              selectionColor: Color(0xFFFF9B90),
            ),
            UserChoiceItem(
              onTap: () {},
              iconText: "🍃",
              height: 90,

              padding: 0,
              title: "Meditation",
              selectionColor: Color(0xFF7FE3F0),
            ),
          ],
        ),

        const SizedBox(height: 10),



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
