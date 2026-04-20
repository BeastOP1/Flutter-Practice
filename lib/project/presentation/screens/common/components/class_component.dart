//
// import 'package:flutter/material.dart';
// import 'package:flutter_svg/svg.dart';
//
// class ClassComponent extends StatelessWidget {
//   final bool start;
//   final Color themeColor;
//   final String title;
//   final String time;
//   final String num;
//   final bool end;
//
//   const ClassComponent({
//     super.key,
//     required this.num,
//     required this.title,
//     required this.themeColor,
//     required this.time,
//     required this.start,
//     this.end = false,
//   });
//
//   @override
//   Widget build(BuildContext context) {
//     return Container(
//       margin: EdgeInsetsGeometry.only(
//         left: start ? 16 : 0,
//         right: end ? 0 : 16,
//       ),
//       width: 192,
//       height: 130,
//       decoration: BoxDecoration(
//         color: Colors.white,
//
//         borderRadius: BorderRadius.circular(25),
//         border: BoxBorder.all(color: themeColor, width: 0.5),
//         boxShadow: [
//           BoxShadow(
//             color: themeColor.withOpacity(0.18),
//             blurRadius: 20,
//             offset: const Offset(0, 10),
//           ),
//         ],
//       ),
//       child: ClipRRect(
//         borderRadius: BorderRadius.circular(25),
//         child: Stack(
//           children: [
//             Positioned.fill(
//               child: SvgPicture.asset('assets/ic_class.svg', color: themeColor),
//               left: -8,
//               top: -16,
//               right: -16,
//             ),
//             Positioned(
//               top: 8,
//               right: 15,
//               left: 55, // Padding barha di taake number ke upar text na aaye
//               child: Text(
//                 title,
//                 textAlign: TextAlign.center,
//                 maxLines: 1,
//                 overflow: TextOverflow.ellipsis,
//                 style: const TextStyle(
//                   color: Colors.white,
//                   fontSize: 14,
//                   fontWeight: FontWeight.w400,
//                 ),
//               ),
//             ),
//             Padding(
//               padding: const EdgeInsets.only(left: 46, top: 48),
//               child: Column(
//                 crossAxisAlignment: CrossAxisAlignment.start,
//                 children: [
//                   _classDetailItem('assets/ic_clock.svg', time, themeColor),
//                   _classDetailItem(
//                     'assets/ic_location.svg',
//                     "Room No 25",
//                     themeColor,
//                   ),
//                   if (!end)
//                     _classDetailItem(
//                       'assets/ic_instructor.svg',
//                       "Sir Ali",
//                       themeColor,
//                     ),
//                 ],
//               ),
//             ),
//
//             Positioned(
//               child: Text(
//                 num,
//                 style: TextStyle(
//                   fontSize: 40,
//                   height: 1,
//                   fontWeight: FontWeight.w900,
//                   color: themeColor,
//                   shadows: [
//                     Shadow(
//                       color: Colors.black.withOpacity(0.1),
//                       offset: const Offset(2, 2),
//                       blurRadius: 4,
//                     ),
//                   ],
//                 ),
//               ),
//               left: 16,
//               top: 36,
//             ),
//
//             if (end)
//               Positioned(
//                 child: SvgPicture.asset(
//                   "assets/ic_notification.svg",
//                   color: themeColor,
//                   height: 28,
//                   width: 28,
//                 ),
//                 bottom: 16,
//                 right: 16,
//               ),
//           ],
//         ),
//       ),
//     );
//   }
//
//   Widget _classDetailItem(String iconRes, String text, Color themeColor) {
//     return Padding(
//       padding: const EdgeInsets.only(bottom: 4),
//       child: Row(
//         spacing: 8,
//         children: [
//           SvgPicture.asset(iconRes, height: 20, color: themeColor),
//           Text(
//             text,
//             style: const TextStyle(
//               fontSize: 12,
//               color: Color(0xFF667085),
//               fontWeight: FontWeight.w500,
//             ),
//           ),
//         ],
//       ),
//     );
//   }
// }


// lib/presentation/screens/common/components/class_component.dart
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
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.only(
        left: start ? 16 : 0,
        right: end ? 16 : 16, // Fixed: hamesha right margin ho
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
                  themeColor.withOpacity(0.15),
                  BlendMode.srcIn,
                ),
              ),
              left: -8,
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
                  _classDetailItem('assets/ic_clock.svg', time, themeColor),
                  _classDetailItem(
                    'assets/ic_location.svg',
                    location ?? "Room No 25",
                    themeColor,
                  ),
                  if (!end)
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
              left: 16,
              top: 36,
            ),
            if (end)
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