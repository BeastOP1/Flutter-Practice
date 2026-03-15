import 'package:flutter/material.dart';


class FingerprintScreen extends StatelessWidget {
  const FingerprintScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      spacing: 8,
      children: [
        SizedBox(height: 10),

        Image.asset("assets/finger_print_img.png",
            height: 270,
            fit: BoxFit.fitHeight),
        SizedBox(height: 20),

        const Text(
          "STEP 4/7",
          style: TextStyle(
            fontSize: 14,

            color: Color(0xFF7265E3),
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          "Enable Fingerprint",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 32,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),
        const Text(
          "If you enable touch ID, you don’t need to enter your password when you login. ",
          textAlign: TextAlign.center,
          maxLines: 3,
          style: TextStyle(color: Color(0xFF4C5980), fontSize: 20),
        ),
        SizedBox(height: 40),

        FilledButton(
          onPressed: () {
            // Navigator.push(
            //   context,
            //   MaterialPageRoute(builder: (context) => OnboardingFlow()),
            // );
          },
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF7265E3),
            padding: EdgeInsets.symmetric(horizontal: 110, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(18),
            ),
          ),
          child: Text(
            "Activate",
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
