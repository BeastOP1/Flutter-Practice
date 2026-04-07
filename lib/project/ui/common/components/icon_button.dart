import 'dart:ffi';

import 'package:flutter/cupertino.dart';
import 'package:flutter_svg/svg.dart';

import '../../../utils/app_colors.dart';

class CustomIconButton extends StatelessWidget {
  final VoidCallback onBackPress;
  final String iconRes;
  final bool marginEnd;
  const CustomIconButton({
    super.key,
    required this.onBackPress,
    this.iconRes = 'assets/ic_notification.svg',
     this.marginEnd = false,

  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onBackPress,
      child: Container(
        margin: EdgeInsetsDirectional.only(end: marginEnd ? 16: 0),
        height: 45,
        width: 45,
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
          iconRes,
          width: 9,
          height: 9,
          color: AppColors.primary,
        ),
      ),
    );
  }
}
