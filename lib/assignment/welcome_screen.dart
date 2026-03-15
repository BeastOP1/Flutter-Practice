import 'package:flutter/cupertino.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/assignment/components/step_progress.dart';
import 'package:flutter_learn/assignment/on_boarding_flow.dart';

class WelcomeScreen extends StatelessWidget {
  const WelcomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      spacing: 32,
      children: [
        // StepProgressBar(currentStep: 1, totalSteps: 7,onButtonTap: (){},
        // showButton: true,),
        Image.asset("assets/logo.png"),
        RichText(
          text: TextSpan(
            text: "Welcome to \n",
            style: TextStyle(
              color: Colors.black,
              fontWeight: FontWeight.bold,
              fontFamily: "Rubik",
              fontSize: 28,
            ),

            children: [
              TextSpan(
                text: "Momotaro",
                style: TextStyle(
                  color: Color(0xFF7265E3),
                  fontWeight: FontWeight.w500,
                  fontSize: 28,
                  fontFamily: "Rubik",

                ),
              ),
              TextSpan(
                text: " UI Kit",
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                  fontSize: 28,
                ),
              ),
            ],
          ),
          maxLines: 2,
          textAlign: TextAlign.center,

        ),
        Text(
          "The best UI Kit for your next\nhealth and fitness project!",
          style: TextStyle(
              color: Color(0xFF4C5980),
              fontSize: 16),
          textAlign: TextAlign.center,
          
        ),
        Image.asset("assets/welcome_image.png", width: double.maxFinite,fit: BoxFit.fitWidth,),
        FilledButton(onPressed: () {

          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => OnboardingFlow(),
            ),
          );
        },
          style: FilledButton.styleFrom(
            backgroundColor: Color(0xFF7265E3),
            padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
            shape: RoundedRectangleBorder(
              borderRadius: BorderRadiusGeometry.circular(18),
            ),
          ),
            child: Text(
              "Get Started",
              style: TextStyle(
              fontWeight: FontWeight.bold,
              fontSize: 20,
              letterSpacing: 0.2,
              fontFamily: "Rubik",
              color: Colors.white
            ),),
          
        ),
        RichText(
          text: TextSpan(
            text: "Already have account? ",
            style: TextStyle(color: Colors.black, fontSize: 16),
            children: [
              TextSpan(
                text: "Sign in",
                style: TextStyle(
                  color:     Color(0xFF7265E3),
                  decoration: TextDecoration.underline,
                  fontWeight: FontWeight.bold,
                ),
                recognizer: TapGestureRecognizer()
                  ..onTap = () {
                    print('Sign in clicked!');
                  },
              ),
            ],
          ),
        ),
      ],
    );
  }
}
