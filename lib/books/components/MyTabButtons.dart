import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyTabButtons extends StatelessWidget {
  final Color color;

  final String text;

  const MyTabButtons({super.key, required this.color, required this.text});

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Text(this.text, textAlign: TextAlign.center),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(10),
        color: color,
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.grey.withValues(alpha: 0.3),
        //     blurRadius: 7,
        //     offset: Offset(0, 0)
        //   )
        // ]
      ),
      width: 120,
      alignment: AlignmentGeometry.center,
      height: 50,
    );
  }
}
