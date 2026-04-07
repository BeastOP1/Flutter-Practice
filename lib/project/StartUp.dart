import 'package:flutter/material.dart';
import 'package:flutter_learn/project/navigation/wrapper/home_wrapper.dart';
import 'package:flutter_learn/project/ui/auth/log_in_screen.dart';
import 'package:flutter_learn/project/ui/auth/sign_up_screen.dart';
import 'package:flutter_learn/project/ui/home/HomeScreen.dart';
import 'package:flutter_learn/project/ui/onboard/onboarding_screen.dart';
import 'package:flutter_learn/project/ui/splash/splash_screen.dart';
import 'package:flutter_learn/project/utils/app_colors.dart';

void main() {
  runApp(Startup());
}


class Startup extends StatelessWidget{
  const Startup({super.key});



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LMS App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(
        primaryColor: AppColors.primary
      ),
      initialRoute: "/splash",
      routes: {
        "/splash": (context)=> SplashScreen(),
        "/onBoard": (context)=> OnboardingScreen(),
        "/login" :(context)=> LoginScreen(),
        "/sign_up" :(context)=> SignupScreen(),
        "/home" :(context)=> HomeWrapperEnhanced(),
      },

    );
  }

}

