import 'package:flutter/material.dart';
import 'package:flutter_learn/assignment/screens/fingerprint_screen.dart';
import 'package:flutter_learn/assignment/screens/otp_screen.dart';
import 'package:flutter_learn/assignment/screens/password_screen.dart';
import 'package:flutter_learn/assignment/screens/phone_number_screen.dart';
import 'package:flutter_learn/assignment/screens/profile_screen.dart';
import 'package:flutter_learn/assignment/screens/user_choice_screen.dart';
import 'package:flutter_learn/assignment/screens/user_interest_screen.dart';

import 'components/step_progress.dart';

class OnboardingFlow extends StatefulWidget {
  @override
  _OnboardingFlowState createState() => _OnboardingFlowState();
}

class _OnboardingFlowState extends State<OnboardingFlow> {
  int _currentStep = 1; // Current step 1 se start

  // Step ke hisaab se content return karne wala function
  Widget _getStepContent() {
    switch (_currentStep) {
      case 1:
        return PhoneNumberScreen(onNext: () => _goToNextStep());
      case 2:
        return OtpScreen(
          onContinue: () => _goToNextStep(),
          onBack: () => _goToPreviousStep(),
        );
      case 3:
        // return PasswordScreen(onNext: () {  });
        return PasswordStrengthWidget(
          onContinue: () {},
          onPasswordChanged: (va) {},
        );
      case 4:
        return FingerprintScreen();
      case 5:
        return ProfileScreen();
      case 6:
        return UserInterestScreen();
      case 7:
        return UserChoiceScreen();
      //   CompleteScreen(
      //   onFinish: () {
      //     // Go to home screen
      //     Navigator.pushReplacementNamed(context, '/home');
      //   },
      // );
      default:
        return Container();
    }
  }

  void _goToNextStep() {
    if (_currentStep < 7) {
      setState(() {
        _currentStep++;
      });
    }
  }

  void _goToPreviousStep() {
    if (_currentStep > 1) {
      setState(() {
        _currentStep--;
      });
    }
  }

  String getButtonText() {
    switch (_currentStep) {
      case 1:
        return "Next";
      case 2:
        return "";
      case 3:
        return "";
      case 4:
        return "Skip";
      case 5:
        return "Skip";
      case 6:
        return "Skip";
      case 7:
        return "Skip";
      default:
        return "Next";
        ;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF4F6FA),
      body: SafeArea(
        child: Column(
          children: [
            // Step Progress Bar (top fixed)
            StepProgressBar(
              currentStep: _currentStep,
              totalSteps: 7,
              buttonText: getButtonText(),
              showButton: (_currentStep != 2),
              onButtonTap: _goToNextStep,
              onPreviousTap: _goToPreviousStep,
            ),

            // Dynamic Content (changes with step)
            Expanded(child: _getStepContent()),
          ],
        ),
      ),
    );
  }
}
