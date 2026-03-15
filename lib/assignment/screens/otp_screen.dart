import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/assignment/components/otp_text_field.dart';

class OtpScreen extends StatelessWidget {
  final VoidCallback onContinue;

  final VoidCallback onBack;

  const OtpScreen({super.key, required this.onContinue, required this.onBack});

  @override
  Widget build(BuildContext context) {
    return Column(
      spacing: 16,
      children: [
        const Text(
          "STEP 2/7",
          style: TextStyle(
            fontSize: 14,
            color: Color(0xFF7265E3),
            fontWeight: FontWeight.w500,
          ),
        ),

        const Text(
          "Verify your number",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(
            fontSize: 28,
            color: Colors.black,
            fontWeight: FontWeight.w500,
          ),
        ),

        const Text(
          "Wel’ll text you on 08223780727.",
          textAlign: TextAlign.center,
          maxLines: 2,
          style: TextStyle(color: Color(0xFF4C5980), fontSize: 16),
        ),

        SizedBox(height: 10),

        OtpField(
          fieldCount: 4,
          onCompleted: (otp) {
            print('OTP entered: $otp');
            // Yahan OTP verify karo
          },
        ),
        SizedBox(height: 10),

        RichText(
          text: TextSpan(
            text: "Send me a new code",
            style: TextStyle(
              color: Color(0xFF7265E3),
              decoration: TextDecoration.none,
              fontWeight: FontWeight.bold,
            ),
            recognizer: TapGestureRecognizer(),
          ),
        ),

        SizedBox(height: 30),
        FilledButton(
          onPressed: this.onContinue,
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF7265E3),
            padding: EdgeInsets.symmetric(horizontal: 90, vertical: 16),
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
