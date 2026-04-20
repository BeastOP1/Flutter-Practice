// lib/presentation/screens/common/components/app_bar_component.dart
import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/screens/common/components/icon_button.dart';
import 'package:flutter_svg/flutter_svg.dart';

class LMSAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String userName;
  final String? avatarUrl;
  final VoidCallback? onBackPress;
  final VoidCallback? onMenuPress;

  const LMSAppBar({
    super.key,
    required this.userName,
    this.avatarUrl,
    this.onBackPress,
    this.onMenuPress,
  });

  @override
  Widget build(BuildContext context) {
    return AppBar(
      backgroundColor: Colors.white,
      actionsPadding: const EdgeInsets.all(0),
      centerTitle: false,
      primary: true,
      forceMaterialTransparency: true,
      title: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Text(
            "Welcome back,",
            style: TextStyle(
              fontSize: 14,
              fontWeight: FontWeight.normal,
              color: Color(0xFF7E848D),
            ),
            textAlign: TextAlign.start,
          ),
          Text(
            userName,
            style: const TextStyle(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Color(0xFF1D2939),
            ),
            maxLines: 1,
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.start,
          ),
        ],
      ),
      actions: [
        CustomIconButton(
          onBackPress: onBackPress,
          marginEnd: true,
        ),
      ],
      leading: GestureDetector(
        onTap: () {
          // Navigate to profile screen
          Navigator.pushNamed(context, '/profile');
        },
        child: Padding(
          padding: const EdgeInsets.only(left: 16, top: 8, bottom: 8),
          child: CircleAvatar(
            backgroundColor: const Color(0xFF8A2373).withOpacity(0.1),
            radius: 24,
            backgroundImage: avatarUrl != null && avatarUrl!.isNotEmpty
                ? NetworkImage(avatarUrl!)
                : null,
            child: avatarUrl == null || avatarUrl!.isEmpty
                ? _buildAvatarPlaceholder()
                : null,
          ),
        ),
      ),
      leadingWidth: 80,
      toolbarHeight: 70,
    );
  }

  Widget _buildAvatarPlaceholder() {
    // Extract first letter of user name
    String initial = 'S';
    if (userName.isNotEmpty && userName != 'Student') {
      final parts = userName.trim().split(' ');
      if (parts.length > 1) {
        initial = parts[0][0].toUpperCase() + parts[1][0].toUpperCase();
      } else {
        initial = userName[0].toUpperCase();
      }
    }

    return Text(
      initial,
      style: const TextStyle(
        fontSize: 18,
        fontWeight: FontWeight.bold,
        color: Color(0xFF8A2373),
      ),
    );
  }

  @override
  Size get preferredSize => const Size.fromHeight(70);
}