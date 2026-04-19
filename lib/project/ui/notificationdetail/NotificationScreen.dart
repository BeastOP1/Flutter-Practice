import 'package:flutter/material.dart';
import '../common/components/icon_button.dart';

class NotificationScreen extends StatelessWidget {
  const NotificationScreen({super.key});

  // Theme Colors
  static const Color _primary = Color(0xFF8B3A8F);
  static const Color _bg = Color(0xFFF4F3F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: Padding(
          padding: const EdgeInsets.only(left: 10),
          child: CustomIconButton(
            iconData: Icons.arrow_back_ios_new,
            onBackPress: () => Navigator.pop(context),
          ),
        ),
        title: const Text(
          "Notifications",
          style: TextStyle(
              color: Color(0xFF1A1A2E),
              fontWeight: FontWeight.bold,
              fontSize: 18
          ),
        ),
        actions: [
          TextButton(
            onPressed: () {
              // Mark all read logic
            },
            child: const Text(
                "Mark all read",
                style: TextStyle(color: _primary, fontSize: 12)
            ),
          )
        ],
      ),
      body: ListView.separated(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        itemCount: 8, // Thora zyada data dikhane ke liye barha diya
        separatorBuilder: (context, index) => const SizedBox(height: 12),
        itemBuilder: (context, index) {
          return _buildNotificationCard(index);
        },
      ),
    );
  }

  // Notification Card Design
  Widget _buildNotificationCard(int index) {
    bool isUnread = index < 2; // Pehli 2 notifications unread dikhayengi

    return Container(
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.04),
            blurRadius: 15,
            offset: const Offset(0, 8),
          ),
        ],
        // Agar unread hai to border color purple hoga
        border: isUnread
            ? Border.all(color: _primary.withOpacity(0.3), width: 1.5)
            : null,
      ),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          // Icon with Gradient Background
          Container(
            width: 50,
            height: 50,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                colors: isUnread
                    ? [_primary, const Color(0xFFAD5FB5)]
                    : [Colors.grey.shade300, Colors.grey.shade400],
              ),
              shape: BoxShape.circle,
            ),
            child: const Icon(
                Icons.notifications_active_outlined,
                color: Colors.white,
                size: 24
            ),
          ),
          const SizedBox(width: 15),

          // Notification Content
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text(
                      index % 2 == 0 ? "New Assignment!" : "Exam Schedule Out",
                      style: const TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                          color: Color(0xFF1A1A2E)
                      ),
                    ),
                    Text(
                      "${index + 1}h ago",
                      style: TextStyle(fontSize: 10, color: Colors.grey.shade500),
                    ),
                  ],
                ),
                const SizedBox(height: 5),
                Text(
                  index % 2 == 0
                      ? "Sir Ali uploaded Assignment #08 for Computer Networks. Due date is 25th March."
                      : "Mid-term exams schedule for Spring 2026 has been uploaded. Check your portal.",
                  style: TextStyle(
                      fontSize: 12,
                      color: Colors.grey.shade600,
                      height: 1.4
                  ),
                ),
                // Unread Dot
                if (isUnread) ...[
                  const SizedBox(height: 10),
                  Container(
                    width: 8,
                    height: 8,
                    decoration: const BoxDecoration(
                        color: _primary,
                        shape: BoxShape.circle
                    ),
                  )
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}