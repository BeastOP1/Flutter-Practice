import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../components/icon_item.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<StatefulWidget> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  static const List<String> iconList = ["👻", "🐵", "😺", "😍"];
  int selectedIconIndex = 2;
  late ScrollController _scrollController;

  static const double iconContainerSize = 90;
  static const double itemSpacing = 20;

  @override
  void initState() {
    super.initState();
    _scrollController = ScrollController();
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _scrollToSelected();
    });
  }

  @override
  void dispose() {
    _scrollController.dispose();
    super.dispose();
  }

  void _scrollToSelected() {
    final itemWidth = iconContainerSize + (itemSpacing * 2);
    final screenWidth = MediaQuery.of(context).size.width;
    final offset = (selectedIconIndex * itemWidth) - (screenWidth / 2) + (iconContainerSize / 2);

    if (_scrollController.hasClients) {
      _scrollController.animateTo(
        offset.clamp(0.0, _scrollController.position.maxScrollExtent),
        duration: const Duration(milliseconds: 500),
        curve: Curves.easeInOutCubic,
      );
    }
  }

  void _onIconSelected(int index) {
    setState(() {
      selectedIconIndex = index;
    });
    _scrollToSelected();
  }

  @override
  Widget build(BuildContext context) {
    return Column(
        mainAxisAlignment: MainAxisAlignment.center,
        spacing: 8,
        children: [
          const SizedBox(height: 10),
          const Text(
            "STEP 5/7",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF7265E3),
              fontWeight: FontWeight.w500,
            ),
          ),
          const Text(
            "Profile Picture",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 32,
              color: Colors.black,
              fontWeight: FontWeight.w500,
            ),
          ),
          const SizedBox(height: 30),

          // Horizontal Carousel Slider
          Positioned(
            top: 0,
            child: CustomPaint(
              painter: TrianglePainter(
                color: const Color(0xFF7265E3),
                isInverted: true,
              ),
              size: const Size(16, 12),
            ),
          ),

          SizedBox(
            height: 140,
            child: Stack(
              alignment: Alignment.center,
              children: [
                // Top Triangle Indicator

                // Carousel ListView
                ScrollConfiguration(
                  behavior: ScrollConfiguration.of(context)
                      .copyWith(scrollbars: false),
                  child: ListView.builder(
                    controller: _scrollController,
                    scrollDirection: Axis.horizontal,
                    physics: const BouncingScrollPhysics(),
                    padding: EdgeInsets.symmetric(
                      horizontal: 32,
                      vertical: 16
                    ),
                    itemCount: iconList.length,
                    itemBuilder: (context, index) {
                      final isSelected = selectedIconIndex == index;
                      return IconItem(onTap: (){ _onIconSelected(index);},
                        iconText: iconList[index],
                        isSelected: isSelected,
                      );
                    },
                  ),
                ),
                // Bottom Triangle Indicator
              ],
            ),
          ),
          Positioned(
            bottom: 0,
            child: CustomPaint(
              painter: TrianglePainter(
                color: const Color(0xFF7265E3),
                isInverted: false,
              ),
              size: const Size(16, 12),
            ),
          ),

          const SizedBox(height: 20),

          const Text(
            "You can select photo from one of this emoji or add your own photo as profile picture",
            textAlign: TextAlign.center,
            maxLines: 3,
            style: TextStyle(color: Color(0xFF4C5980), fontSize: 20),
          ),
          SizedBox(height: 40),

          RichText(
            text: TextSpan(
              text: "Add Custom Photo",
              style: TextStyle(
                color: Color(0xFF7265E3),
                decoration: TextDecoration.none,
                fontWeight: FontWeight.bold,
              ),
              recognizer: TapGestureRecognizer(),
            ),
          ),

          const SizedBox(height: 70),



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
          const SizedBox(height: 40),
        ],
      );
  }
}

// Custom Triangle Painter
class TrianglePainter extends CustomPainter {
  final Color color;
  final bool isInverted;

  TrianglePainter({
    required this.color,
    this.isInverted = false,
  });

  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()..color = color;
    final path = Path();

    if (isInverted) {
      // Inverted triangle (pointing down)
      path.moveTo(0, 0);
      path.lineTo(size.width, 0);
      path.lineTo(size.width / 2, size.height);
    } else {
      // Normal triangle (pointing up)
      path.moveTo(0, size.height);
      path.lineTo(size.width, size.height);
      path.lineTo(size.width / 2, 0);
    }

    path.close();
    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(TrianglePainter oldDelegate) {
    return oldDelegate.color != color || oldDelegate.isInverted != isInverted;
  }
}