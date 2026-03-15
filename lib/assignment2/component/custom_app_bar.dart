import 'package:flutter/material.dart';

class CustomAppBar extends StatelessWidget {
  final String title;
  final String subTitle;
  final VoidCallback? onBackPress;
  final VoidCallback? onMenuPress;

  const CustomAppBar({
    super.key,
    required this.title,
    required this.subTitle,
    this.onBackPress,
    this.onMenuPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actionsPadding: EdgeInsetsGeometry.all(0),
      centerTitle: true,
      primary: true,
      forceMaterialTransparency: true,
      title: Column(
        children: [
          Text(
            this.title,
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
            maxLines: 1,
            textAlign: TextAlign.center,
          ),
          Text(
            this.subTitle,
            style: TextStyle(fontSize: 16, fontWeight: FontWeight.normal),
            textAlign: TextAlign.center,
          ),
        ],
      ),
      actions: [

        GestureDetector(onTap: onMenuPress,child:
        Container(
          margin: EdgeInsetsDirectional.only(end: 32),
          height: 55,
          width: 55,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.rectangle,
            borderRadius: BorderRadiusGeometry.all(Radius.circular(16)),
            border: Border.all(color: Colors.grey.shade400),
          ),
          child: Icon(
            Icons.filter_list_sharp,
            color: Color(0xFFDC87CE),
            size: 35,
          ),
        ),)
      ],
      leading:  GestureDetector(onTap: onBackPress,
          child:
      Container(
          margin: EdgeInsetsDirectional.only(start: 48),
          height: 45,
          width: 45,
          decoration: BoxDecoration(
            color: Colors.white,
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                  color: Colors.grey.shade300,
                  spreadRadius: 10,
                  blurRadius: 1,
                  blurStyle: BlurStyle.outer,
                  offset: const Offset(0, 1)
              ),
            ],
          ),
          child: Icon(
            Icons.keyboard_backspace_outlined,
            color: Color(0xFFDC87CE),
            size: 30,
          )
      )
      ),
      leadingWidth: 80,
      toolbarHeight: 60,
    );
  }
}
