
import 'package:flutter/material.dart';
import '../../../../core/utils/app_colors.dart' show AppColors;
import '../../common/components/icon_button.dart';

class ScheduleHeader extends StatelessWidget {
  final int notificationCount;
  final VoidCallback onNotificationTap;

  const ScheduleHeader({
    super.key,
    required this.notificationCount,
    required this.onNotificationTap,
  });

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 14),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          const Spacer(),
          const Text(
            'Schedule',
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: AppColors.textPrimary,
            ),
          ),
          const Spacer(),
          Stack(
            children: [
              CustomIconButton(onBackPress: onNotificationTap),
              if (notificationCount > 0)
                Positioned(
                  right: 4,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: AppColors.notification,
                      shape: BoxShape.circle,
                    ),
                    constraints: const BoxConstraints(minWidth: 16, minHeight: 16),
                    child: Text(
                      notificationCount > 9 ? '9+' : '$notificationCount',
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 10,
                        fontWeight: FontWeight.bold,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
            ],
          ),
        ],
      ),
    );
  }
}