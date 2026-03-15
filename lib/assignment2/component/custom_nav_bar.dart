import 'package:flutter/material.dart';

class CustomNavBar extends StatefulWidget {
  final Function(int) onTabChange;
  final List<NavBarItem> items;
  final Color backgroundColor;
  final Color activeIconColor;
  final Color activeInductionColor;
  final Color activeLabelColor;
  final Color inactiveIconColor;
  final Color inactiveLabelColor;
  final double height;

  const CustomNavBar({
    super.key,
    required this.onTabChange,
    required this.items,
    this.backgroundColor = const Color(0xFFFFFFFF),
    this.activeIconColor = const Color(0xFFFFFFFF),
    this.activeInductionColor = const Color(0xFFDC87CE),
    this.inactiveIconColor = const Color(0xFF5F6368),
    this.activeLabelColor = const Color(0xFFFFFFFF),
    this.inactiveLabelColor = const Color(0xFFFFFFFF),
    this.height = 70,
  });

  @override
  State<CustomNavBar> createState() => _CustomNavBarState();
}

class _CustomNavBarState extends State<CustomNavBar>
    with TickerProviderStateMixin {
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
    return Container(
      height: widget.height,
      decoration: BoxDecoration(
        color: widget.backgroundColor,
        borderRadius: BorderRadiusGeometry.circular(32),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withAlpha(10),
            blurRadius: 2,
            offset: const Offset(0, -2),
          ),
          
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.center,
        children: List.generate(
          widget.items.length,
          (index) => _buildNavItem(index),
        ),
      ),
    );
  }

  Widget _buildNavItem(int index) {
    final isActive = _selectedIndex == index;
    final animation = _animationControllers[index];
    final item = widget.items[index];

    return GestureDetector(
      onTap: () => _onTabChange(index),
      child: ScaleTransition(
        scale: Tween<double>(
          begin: 1.0,
          end: 1.1,
        ).animate(CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn)),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 300),
          width: isActive? 130 :85,
          height: 40,
          decoration: BoxDecoration(
            color: isActive
                ? widget.activeInductionColor
                : Colors.transparent,
            borderRadius: BorderRadius.circular(32),
            shape: BoxShape.rectangle,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            spacing: 3,
            children: [
              Icon(
                item.icon,
                color: isActive ? widget.activeIconColor : widget.inactiveIconColor,
                size: isActive?  30 :25,
              ),
              if(isActive) ...[
                ScaleTransition(
                  scale: Tween<double>(begin: 0.0, end: 1.0).animate(
                    CurvedAnimation(parent: animation, curve: Curves.fastLinearToSlowEaseIn),
                  ),
                  child: Text(
                    item.label,
                    style: TextStyle(
                      fontSize: 14,
                      fontWeight: FontWeight.w600,
                      color: isActive ? widget.activeLabelColor : widget.inactiveLabelColor,
                    ),
                    softWrap: true,
                  ),
                ),
              ]
            ],
          ),
        ),
      ),
    );
  }
}

class NavBarItem {
  final IconData icon;
  final String label;

  NavBarItem({required this.icon, required this.label});
}
