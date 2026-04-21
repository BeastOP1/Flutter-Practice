
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';

class ClassComponent extends StatelessWidget {
  final bool start;
  final bool end;
  final Color themeColor;
  final String title;
  final String time;
  final String num;
  final String? location;
  final bool isNotEnabled;
  final String? instructor;

  const ClassComponent({
    super.key,
    required this.num,
    required this.title,
    required this.themeColor,
    required this.time,
    required this.start,
    this.end = false,
    this.location,
    this.instructor,
    String roomNumber = "1",
    this.isNotEnabled = false,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: 8,
        right: 8, // Fixed: hamesha right margin ho
      ),
      width: 192,
      height: 130,
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(25),
        border: Border.all(color: themeColor, width: 0.5),
        boxShadow: [
          BoxShadow(
            color: themeColor.withOpacity(0.18),
            blurRadius: 20,
            offset: const Offset(0, 10),
          ),
        ],
      ),
      child: ClipRRect(
        borderRadius: BorderRadius.circular(25),
        child: Stack(
          children: [
            Positioned.fill(
              child: SvgPicture.asset(
                'assets/ic_class.svg',
                colorFilter: ColorFilter.mode(
                  themeColor.withOpacity(1),
                  BlendMode.srcIn,
                ),
              ),
              left: -42,
              top: -16,
              right: -16,
            ),
            Positioned(
              top: 8,
              right: 15,
              left: 55,
              child: Text(
                title,
                textAlign: TextAlign.center,
                maxLines: 1,
                overflow: TextOverflow.ellipsis,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 14,
                  fontWeight: FontWeight.w400,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.only(left: 46, top: 48),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  _classDetailItem('assets/ic_clock.svg', time.toString(), themeColor),
                  _classDetailItem(
                    'assets/ic_location.svg',
                    location ?? "Room No 25",
                    themeColor,
                  ),
                  if (instructor != null)
                    _classDetailItem(
                      'assets/ic_instructor.svg',
                      instructor ?? "Sir Ali",
                      themeColor,
                    ),
                ],
              ),
            ),
            Positioned(
              child: Text(
                num,
                style: TextStyle(
                  fontSize: 40,
                  height: 1,
                  fontWeight: FontWeight.w900,
                  color: themeColor,
                  shadows: [
                    Shadow(
                      color: Colors.black.withOpacity(0.1),
                      offset: const Offset(2, 2),
                      blurRadius: 4,
                    ),
                  ],
                ),
              ),
              left: 12,
              top: 42,
            ),
            if (isNotEnabled)
              Positioned(
                child: SvgPicture.asset(
                  "assets/ic_notification.svg",
                  colorFilter: ColorFilter.mode(themeColor, BlendMode.srcIn),
                  height: 28,
                  width: 28,
                ),
                bottom: 16,
                right: 16,
              ),
          ],
        ),
      ),
    );
  }

  Widget _classDetailItem(String iconRes, String text, Color themeColor) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 4),
      child: Row(
        spacing: 8,
        children: [
          SvgPicture.asset(
            iconRes,
            height: 20,
            colorFilter: ColorFilter.mode(themeColor, BlendMode.srcIn),
          ),
          Text(
            text,
            style: const TextStyle(
              fontSize: 12,
              color: Color(0xFF667085),
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }
}