import 'package:flutter/material.dart';

class IconItem extends StatelessWidget {
  final bool isSelected;
  final String iconText;
  final VoidCallback onTap;
  final Size iconSize;
  final double padding;

  const IconItem({
    super.key,
    this.isSelected = false,
    this.iconText = "👻",
    required this.onTap,
    this.iconSize = const Size(90.0, 90.0),
    this.padding = 16.0,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: this.onTap,
      child: AnimatedScale(
        scale: isSelected ? 1.11 : 0.8,
        duration: const Duration(milliseconds: 300),
        curve: Curves.easeInOutCubic,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          curve: Curves.easeInOutCubic,
          margin: EdgeInsets.symmetric(horizontal: this.padding),
          decoration: BoxDecoration(
            color: isSelected ? Color(0xFF8FACFF) : Colors.white,
            shape: BoxShape.rectangle,
            boxShadow: [
              BoxShadow(
                color: isSelected
                    ? Color(0xFF8FACFF).withOpacity(0.25)
                    : Colors.transparent,
                offset: Offset(0, 15),
                spreadRadius: 0,
                blurRadius: 15,
                // blurStyle: BlurStyle.inner
              ),
            ],

            borderRadius: BorderRadiusGeometry.circular(32),
          ),
          alignment: Alignment.center,
          height: this.iconSize.height,
          width: this.iconSize.width,
          child: Text(this.iconText, style: TextStyle(fontSize: 35)),
        ),
      ),
    );
  }
}


class IconItemWithText extends StatefulWidget {
  final String iconText;
  final String title;
  final VoidCallback? onTap;
  final Size iconSize;
  final double padding;
  final bool initialSelected;
  final ValueChanged<bool>? onSelectionChanged;

  final Color selectionColor;

  const IconItemWithText({
    super.key,
    this.iconText = "👻",
    this.onTap,
    this.iconSize = const Size(90.0, 90.0),
    this.padding = 16.0,
    required this.title,
    this.initialSelected = false,
    this.onSelectionChanged,
     this.selectionColor =  const Color(0xFF8FACFF),
  });

  @override
  State<IconItemWithText> createState() => _IconItemWithTextState();
}

class _IconItemWithTextState extends State<IconItemWithText> {
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
    return Column(
      spacing: 12,
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        GestureDetector(
          onTap: _toggleSelection,
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            curve: Curves.easeInOutCubic,
            margin: EdgeInsets.symmetric(horizontal: widget.padding),
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
            height: widget.iconSize.height,
            width: widget.iconSize.width,
            child: AnimatedScale(
              scale: isSelected ? 1.1 : 1.0,
              duration: const Duration(milliseconds: 300),
              curve: Curves.easeInOutCubic,
              child: Text(
                widget.iconText,
                style: const TextStyle(fontSize: 45),
              ),
            ),
          ),
        ),
        Text(
          widget.title,
          style: TextStyle(
            fontSize: 16,
            fontWeight: FontWeight.w500,
            color: Colors.black87,
          ),
        )
      ],
    );
  }
}
