import 'package:flutter/material.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final _oldPassCtrl = TextEditingController();
  final _newPassCtrl = TextEditingController();
  final _confirmPassCtrl = TextEditingController();

  static const Color _primary = Color(0xFF8B3A8F);
  static const Color _accent = Color(0xFFB5860D);
  static const Color _bg = Color(0xFFF4F3F8);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      appBar: AppBar(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_new_rounded, color: Colors.black87, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text(
          'Security',
          style: TextStyle(color: Color(0xFF1A1A2E), fontWeight: FontWeight.w700, fontSize: 18),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Padding(
          padding: const EdgeInsets.all(24.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Change Password',
                style: TextStyle(fontSize: 24, fontWeight: FontWeight.w800, color: Color(0xFF1A1A2E)),
              ),
              const SizedBox(height: 8),
              Text(
                'Your new password must be different from previous used passwords.',
                style: TextStyle(fontSize: 14, color: Colors.grey[600], height: 1.5),
              ),

              const SizedBox(height: 35),

              // ── INPUT FIELDS
              _label('Current Password'),
              const SizedBox(height: 10),
              _passField(_oldPassCtrl, 'Enter current password'),

              const SizedBox(height: 20),

              _label('New Password'),
              const SizedBox(height: 10),
              _passField(_newPassCtrl, 'Enter new password'),

              const SizedBox(height: 20),

              _label('Confirm New Password'),
              const SizedBox(height: 10),
              _passField(_confirmPassCtrl, 'Re-type new password'),

              const SizedBox(height: 40),

              // ── UPDATE BUTTON
              SizedBox(
                width: double.infinity,
                height: 55,
                child: ElevatedButton(
                  onPressed: () {
                    // Yahan logic check karein (if new == confirm)
                    Navigator.pop(context);
                  },
                  style: ElevatedButton.styleFrom(
                    backgroundColor: _primary,
                    shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
                    elevation: 4,
                    shadowColor: _primary.withOpacity(0.3),
                  ),
                  child: const Text(
                    'Update Password',
                    style: TextStyle(color: Colors.white, fontWeight: FontWeight.w700, fontSize: 16),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _label(String text) => Text(
      text,
      style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w700, color: Color(0xFF1A1A2E))
  );

  Widget _passField(TextEditingController ctrl, String hint) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(15),
        boxShadow: [
          BoxShadow(color: Colors.black.withOpacity(0.02), blurRadius: 10, offset: const Offset(0, 4))
        ],
      ),
      child: TextField(
        controller: ctrl,
        obscureText: true, // Password hide karne ke liye
        decoration: InputDecoration(
          prefixIcon: const Icon(Icons.lock_outline_rounded, color: _primary, size: 22),
          suffixIcon: Icon(Icons.visibility_off_outlined, color: Colors.grey[400], size: 20),
          hintText: hint,
          hintStyle: TextStyle(color: Colors.grey[400], fontSize: 14),
          border: InputBorder.none,
          contentPadding: const EdgeInsets.all(18),
        ),
      ),
    );
  }
}