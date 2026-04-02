import 'package:flutter/material.dart';

import '../auth/log_in_screen.dart';

class OnboardingScreen extends StatefulWidget {
  const OnboardingScreen({super.key});

  @override
  State<OnboardingScreen> createState() => _OnboardingScreenState();
}

class _OnboardingScreenState extends State<OnboardingScreen> {
  final PageController _pageController = PageController();
  int _currentIndex = 0;

  final List<Map<String, String>> _onboardingData = [
    {
      "image": 'Asset/images/img_1.png',
      "title": "Better way to learning is calling you!",
      "desc": "Unlock your potential, Embrace Education"
    },
    {
      "image": "Asset/images/img_2.png",
      "title": "Find yourself by doing whatever you do!",
      "desc": "Education with Grace and Style"
    },
    {
      "image": "Asset/images/img_3.png",
      "title": "Track Your Progress",
      "desc": "Stay on top of your studies with detailed performance insights"
    },
  ];

  void _navigateToLogin() {
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => LoginScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    const primaryColor = Color(0xFF8A2373);

    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Column(
          children: [
            _buildProgressBar(primaryColor),

            Expanded(
              child: PageView.builder(
                controller: _pageController,
                onPageChanged: (index) => setState(() => _currentIndex = index),
                itemCount: _onboardingData.length,
                itemBuilder: (context, index) => _buildPageContent(index),
              ),
            ),

            _buildActionButtons(primaryColor),
          ],
        ),
      ),
    );
  }

  Widget _buildProgressBar(Color color) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Row(
        children: List.generate(3, (index) => Expanded(
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 4,
            margin: const EdgeInsets.symmetric(horizontal: 4),
            decoration: BoxDecoration(
              color: _currentIndex == index ? color : Colors.grey.shade300,
              borderRadius: BorderRadius.circular(2),
            ),
          ),
        )),
      ),
    );
  }

  Widget _buildPageContent(int index) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Image.asset(_onboardingData[index]["image"]!,
                    height: 300),
        const SizedBox(height: 40),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 30),
          child: Text(
            _onboardingData[index]["title"]!,
            textAlign: TextAlign.center,
            style: const TextStyle(
                fontSize: 22,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
        const SizedBox(height: 15),
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 40),
          child: Text(
            _onboardingData[index]["desc"]!,
            textAlign: TextAlign.center,
            style: TextStyle(
                fontSize: 14,
                color: Colors.grey.shade600
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildActionButtons(Color color) {
    bool isLastPage = _currentIndex == _onboardingData.length - 1;

    return Padding(
      padding: const EdgeInsets.fromLTRB(30, 10, 30, 30),
      child: Column(
        children: [
          SizedBox(
            width: double.infinity,
            height: 55,
            child: ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: color,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(10)
                ),
              ),
              onPressed: () {
                if (isLastPage) {
                  _navigateToLogin();
                } else {
                  _pageController.nextPage(
                    duration: const Duration(milliseconds: 500),
                    curve: Curves.easeInOut,
                  );
                }
              },
              child: Text(
                isLastPage ? "Get Started" : "Next",
                style: const TextStyle(
                    color: Colors.white,
                    fontSize: 16
                ),
              ),
            ),
          ),
          const SizedBox(height: 15),
          Opacity(
            opacity: isLastPage ? 0.0 : 1.0,
            child: GestureDetector(
              onTap: isLastPage ? null : () => _pageController.jumpToPage(2),
              child: Text(
                "Skip",
                style: TextStyle(
                    color: color,
                    fontWeight: FontWeight.bold
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}