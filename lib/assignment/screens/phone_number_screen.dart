import 'package:flutter/material.dart';

import '../components/phone_number_text_field.dart';

class PhoneNumberScreen extends StatelessWidget {
  final VoidCallback onNext;

  const PhoneNumberScreen({super.key, required this.onNext});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        const Text(
          "STEP 1/7",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF7265E3),
            fontWeight: FontWeight.w500,
          ),
        ),

        const Text(
          "Let’s start with your \nmobile number",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Text(
          "Number we can use to reach you",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(color: Color(0xFF4C5980), fontSize: 16),
        ),
        PhoneInputWithPackage(),
        FilledButton(onPressed: () {

          // Navigator.push(
          //   context,
          //   MaterialPageRoute(
          //     builder: (context) => ,
          //   ),
          // );
        },
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF7265E3),
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(18),
            ),
          ),
          child: Text(
            "Verify Now",
            style: TextStyle(
                fontWeight: FontWeight.bold,
                fontSize: 20,
                letterSpacing: 0.2,
                fontFamily: "Rubik",
                color: Colors.white
            ),),

        ),

      ],
    );
  }
}
