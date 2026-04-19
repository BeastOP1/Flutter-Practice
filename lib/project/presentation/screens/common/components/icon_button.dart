import 'package:flutter/material.dart';
import 'package:flutter_learn/project/core/utils/app_colors.dart' show AppColors;
import 'package:flutter_svg/svg.dart';
import 'package:flutter_learn/project/presentation/screens/notificationdetail/NotificationScreen.dart';


class CustomIconButton extends StatelessWidget {
  final VoidCallback? onBackPress;
  final String? iconRes;
  final bool marginEnd;
  final IconData? iconData;

  const CustomIconButton({
    super.key,
    this.onBackPress,
    this.iconRes,
    this.iconData,
    this.marginEnd = false,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        if (onBackPress != null) {
          onBackPress!();
        } else {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => const NotificationScreen()),
          );
        }
      },
      child: Container(
        margin: EdgeInsetsDirectional.only(end: marginEnd ? 16 : 0),
        height: 45,
        width: 45,
        padding: const EdgeInsets.all(8),
        decoration: const BoxDecoration(
          color: Color(0xFFF4F4F4),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: Color(0xFFF4F4F4),
              spreadRadius: 10,
              blurRadius: 1,
              blurStyle: BlurStyle.outer,
              offset: Offset(0, 1),
            ),
          ],
        ),

        child: iconData != null
            ? Icon(
          iconData,
          color: AppColors.primary,
          size: 20,
        )
            : SvgPicture.asset(
          iconRes ?? 'assets/ic_notification.svg',
          width: 9,
          height: 9,
          colorFilter: ColorFilter.mode(AppColors.primary, BlendMode.srcIn),
        ),
      ),
    );
  }
}