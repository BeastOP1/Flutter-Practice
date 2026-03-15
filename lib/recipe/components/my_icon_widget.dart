import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class MyIconWidget extends StatelessWidget {
  final IconData icon;
  final VoidCallback pressed;

  const MyIconWidget({super.key, required this.icon, required this.pressed});

  @override
  Widget build(BuildContext context) {
    return IconButton(
      onPressed: this.pressed,
      icon: Icon(this.icon, color: Colors.white,),
      style: IconButton.styleFrom(
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadiusGeometry.circular(15),
        ),
        backgroundColor: Colors.teal.shade500,
        fixedSize: Size(50, 50),
      ),
    );
  }
}
