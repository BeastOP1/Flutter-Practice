import 'package:flutter/material.dart';
import 'package:flutter_learn/project/ui/common/components/icon_button.dart';
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
        CustomIconButton( onBackPress: () {  }, marginEnd: true, ),
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
