import 'package:flutter/material.dart';
import 'package:flutter_learn/project/core/utils/app_colors.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LMSNavBar extends StatefulWidget {
  final Function(int) onTabChange;
  final List<NavBarItem> items;
  final Color backgroundColor;
  final Color activeIconColor;
  final Color activeInductionColor;
  final Color activeLabelColor;
  final Color inactiveIconColor;
  final Color inactiveLabelColor;
  final double height;

  const LMSNavBar({
    super.key,
    required this.onTabChange,
    required this.items,
    this.backgroundColor = const Color(0xFFF3F3F3),
    this.activeIconColor = const Color(0xFFFFFFFF),
    this.activeInductionColor = AppColors.primary,
    this.inactiveIconColor = const Color(0xFF5F6368),
    this.activeLabelColor = const Color(0xFFFFFFFF),
    this.inactiveLabelColor = const Color(0xFFFFFFFF),
    this.height = 70
  });

  @override
  State<LMSNavBar> createState() => _LMSNavBarState();
}

class _LMSNavBarState extends State<LMSNavBar> with TickerProviderStateMixin {
  late int _selectedIndex = 0;
  late List<AnimationController> _animationControllers = [];

  @override
  void initState() {
    super.initState();
    _initializeAnimations();
  }

  void _initializeAnimations() {
    _animationControllers = List.generate(
      widget.items.length,
      (index) => AnimationController(
        duration: const Duration(milliseconds: 250),
        vsync: this,
      ),
    );
    _animationControllers[0].forward();
  }

  void _onTabChange(int index) {
    if (_selectedIndex == index) return;
    _animationControllers[_selectedIndex].reverse();
    _animationControllers[index].forward();
    setState(() => _selectedIndex = index);
    widget.onTabChange(index);
  }

  @override
  void dispose() {
    for (var controller in _animationControllers) {
      controller.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          margin: const EdgeInsets.only(bottom: 8, left: 16, right: 16),
          height: widget.height,
          decoration: BoxDecoration(
            color: widget.backgroundColor,
            borderRadius: BorderRadius.circular(32),
            border: Border.all(color: AppColors.grey300),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            // REMOVED spacing: 8.0  ← Ye line hata di
            children: List.generate(
              widget.items.length,
              (index) => _buildNavItem(index),
            ),
          ),
        );
      },
    );
  }

  Widget _buildNavItem(int index) {
    final isActive = _selectedIndex == index;
    final animation = _animationControllers[index];
    final item = widget.items[index];

    return GestureDetector(
      onTap: () => _onTabChange(index),
      child: Container(
        height: 40,
        // REMOVED fixed width constraints
        padding: const EdgeInsets.symmetric(horizontal: 8), // Reduced padding
        child: ScaleTransition(
          scale: Tween<double>(begin: 1.0, end: 1.1).animate(
            CurvedAnimation(
              parent: animation,
              curve: Curves.fastLinearToSlowEaseIn,
              reverseCurve: Curves.fastLinearToSlowEaseIn,
            ),
          ),
          child: AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: 40,
            padding: const EdgeInsets.symmetric(horizontal: 12),
            decoration: BoxDecoration(
              color: isActive
                  ? widget.activeInductionColor
                  : Colors.transparent,
              borderRadius: BorderRadius.circular(32),
            ),
            child: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                SvgPicture.asset(
                  item.icon,
                  color: isActive
                      ? widget.activeIconColor
                      : widget.inactiveIconColor,
                  height: 22,
                  width: 22,
                ),
                if (isActive) ...[
                  const SizedBox(width: 6),
                  ScaleTransition(
                    scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                      CurvedAnimation(
                        parent: animation,
                        curve: Curves.fastLinearToSlowEaseIn,
                      ),
                    ),
                    child: Text(
                      item.label,
                      style: TextStyle(
                        fontSize: 12,
                        fontWeight: FontWeight.w600,
                        color: isActive
                            ? widget.activeLabelColor
                            : widget.inactiveLabelColor,
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class NavBarItem {
  final String icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}
