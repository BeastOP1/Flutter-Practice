import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';


class UserChoiceItem extends StatefulWidget {
  final String iconText;
  final String title;
  final VoidCallback? onTap;
  final double height;
  final double padding;
  final bool initialSelected;
  final ValueChanged<bool>? onSelectionChanged;

  final Color selectionColor;

  const UserChoiceItem({
    super.key,
    this.iconText = "👻",
    this.onTap,
    this.height =  60.0,
    this.padding = 16.0,
    required this.title,
    this.initialSelected = false,
    this.onSelectionChanged,
    this.selectionColor =  const Color(0xFF8FACFF),
  });

  @override
  State<UserChoiceItem> createState() => _UserChoiceItemState();
}

class _UserChoiceItemState extends State<UserChoiceItem> {
  late bool isSelected;

  late bool exam;
  @override
  void initState() {
    super.initState();
    isSelected = widget.initialSelected;
  }

  void _toggleSelection() {
    setState(() {
      isSelected = !isSelected;
    });
    widget.onSelectionChanged?.call(isSelected);
    widget.onTap?.call();
  }

  @override
  Widget build(BuildContext context) {
    return
      GestureDetector(
        onTap: _toggleSelection,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsetsDirectional.symmetric(horizontal: 16),
          decoration: BoxDecoration(
            color: isSelected ? widget.selectionColor : const  Color(0xFFF5F5F7),
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? const Color(0xFF8FACFF).withOpacity(0.35)
                    : Colors.black.withOpacity(0.08),
                offset: const Offset(0, 8),
                spreadRadius: 0,
                blurRadius: 16,
              ),
            ],
            borderRadius: BorderRadius.circular(32),
          ),
          alignment: Alignment.center,
          height: widget.height,
          width: double.infinity,
          child: AnimatedScale(
            scale: isSelected ? 1.1 : 1.0,
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            child:

            Row(
              spacing: 12,
              mainAxisAlignment: MainAxisAlignment.center,
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [

                Text(
                  widget.title,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w500,
                    color: Colors.black87,
                  ),
                )
              ],
            )
           ,
          ),
        ),
      );

  }
}



