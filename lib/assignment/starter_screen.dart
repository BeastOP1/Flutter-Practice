import 'package:flutter/material.dart';
import 'package:flutter_learn/assignment/welcome_screen.dart';

class StarterScreen extends StatelessWidget {
  const StarterScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: "Momotaro-App",
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.blue,
        fontFamily: 'Rubik', // optional
      ),
      home: Scaffold(

        backgroundColor: Colors.white,
        body: SafeArea(child: WelcomeScreen()),
      ),
    );
  }
}
