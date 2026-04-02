
import 'package:flutter/material.dart';
import 'package:flutter_learn/project/utils/app_colors.dart';
import 'package:flutter_learn/project/ui/home/HomeScreen.dart';
import 'package:flutter_svg/svg.dart';

import '../../../start.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    _navigateToHome();
  }

  void _navigateToHome() {
    Future.delayed(const Duration(seconds: 3), () {

      Navigator.pushNamed(context, "/onBoard");

      // Navigator.pushReplacement(
      //   context,
      //   MaterialPageRoute(builder: (context) =>  HomeScreen()),
      // );
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.primary,
      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [

          Center(
            child: SvgPicture.asset("assets/su_logo.svg",alignment: Alignment.center,
              color: Colors.white,
              height: 180,
              width: 180,
            ),
          )
        ],
      ),

    );
  }
}
