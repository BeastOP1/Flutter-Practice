import 'package:flutter/material.dart';
import 'package:flutter_learn/project/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LMSAppBar extends StatelessWidget {
  final String userName;
  final VoidCallback? onBackPress;
  final VoidCallback? onMenuPress;

  const LMSAppBar({
    super.key,
    required this.userName,
    this.onBackPress,
    this.onMenuPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsetsGeometry.all(0),
      centerTitle: false,
      primary: true,
      forceMaterialTransparency: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            "Welcome back",
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.normal,
              color: Color(0xFF7E848D),
            ),
            textAlign: TextAlign.start,
          ),
          Text(
          this.userName,
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.w500),
            maxLines: 1,
            textAlign: TextAlign.start,
          ),
        ],
      ),
      actions: [
        GestureDetector(
          onTap: onBackPress,
          child: Container(
            margin: EdgeInsetsDirectional.only(end: 16),
            height: 50,
            width: 50,
            padding: EdgeInsetsDirectional.all(8),
            decoration: BoxDecoration(
              color: Color(0xFFF4F4F4),
              shape: BoxShape.circle,
              boxShadow: [
                BoxShadow(
                  color: Color(0xFFF4F4F4),
                  spreadRadius: 10,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(0, 1),
                ),
              ],
            ),
            child: SvgPicture.asset(
              "assets/ic_notification.svg",
              width: 10,
              height: 10,
              color: AppColors.primary,
            ),
          ),
        ),
      ],
      leading: CircleAvatar(
        backgroundColor: Colors.transparent,
        child: Image.asset("assets/avater.png", height: 65, width: 65),
      ),
      leadingWidth: 80,
      toolbarHeight: 60,
    );
  }
}
