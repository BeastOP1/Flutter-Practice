import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/navigation/wrapper/home_wrapper.dart';
import 'package:flutter_learn/project/presentation/screens/auth/log_in_screen.dart';
import 'package:flutter_learn/project/presentation/screens/auth/sign_up_screen.dart';
import 'package:flutter_learn/project/presentation/screens/onboard/onboarding_screen.dart';
import 'package:flutter_learn/project/presentation/screens/splash/splash_screen.dart';
import 'package:flutter_learn/project/core/utils/app_colors.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

import 'core/constants/supabase_constant.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Supabase.initialize(
    url: SupabaseConstants.url,
    anonKey: SupabaseConstants.anonKey,
  );

  runApp(const ProviderScope(child: Startup()));
}

class Startup extends StatelessWidget {
  const Startup({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "LMS App",
      debugShowCheckedModeBanner: false,
      home: SplashScreen(),
      theme: ThemeData(primaryColor: AppColors.primary),
      initialRoute: "/splash",
      routes: {
        "/splash": (context) => SplashScreen(),
        "/onBoard": (context) => OnboardingScreen(),
        "/login": (context) => LoginScreen(),
        "/sign_up": (context) => SignupScreen(),
        "/home": (context) => HomeWrapperEnhanced(),
      },
    );
  }
}
