
import 'package:flutter/material.dart';

import '../common/components/icon_button.dart';
import 'package:flutter_learn/project/presentation/screens/editprofile/EditProfileScreen.dart';
import 'package:flutter_learn/project/presentation/screens/changepassword/ChangePasswordScreen.dart';
import 'package:flutter_learn/project/presentation/screens/notificationdetail/NotificationScreen.dart';
import 'package:flutter_learn/project/presentation/screens/auth/log_in_screen.dart';
import 'package:flutter_learn/project/presentation/screens/help&support/SupportScreen.dart';




class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});

  @override
  State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen>
    with TickerProviderStateMixin {
  late AnimationController _headerCtrl;
  late AnimationController _cardsCtrl;
  late Animation<double> _headerAnim;
  late Animation<double> _cardsAnim;

  @override
  void initState() {
    super.initState();
    _headerCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 700));
    _cardsCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 900));

    _headerAnim = CurvedAnimation(parent: _headerCtrl, curve: Curves.easeOut);
    _cardsAnim =
        CurvedAnimation(parent: _cardsCtrl, curve: Curves.easeOutCubic);

    Future.delayed(const Duration(milliseconds: 80), () {
      _headerCtrl.forward();
    });
    Future.delayed(const Duration(milliseconds: 350), () {
      _cardsCtrl.forward();
    });
  }

  @override
  void dispose() {
    _headerCtrl.dispose();
    _cardsCtrl.dispose();
    super.dispose();
  }

  // ── data ──────────────────────────────────────
  static const _name = 'Hassan Farooq Siddiqi';
  static const _rollNo = 'BSSE-5A | su92-bsse,-s24-099';
  static const _dept = 'Software Engineering Dept';
  static const _cgpa = 3.0;
  static const _credits = 28;
  static const _totalCredits = 50;
  static const _semester = '5th';
  static const _batch = '2025–2029';

  static const Color _primary = Color(0xFF8B3A8F);
  static const Color _accent = Color(0xFFB5860D);
  static const Color _bg = Color(0xFFF4F3F8);

  // ─────────────────────────────────────────────
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: _bg,
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        child: Column(
          children: [
            FadeTransition(
              opacity: _headerAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                    begin: const Offset(0, -0.12), end: Offset.zero)
                    .animate(_headerAnim),
                child: _buildHeader(context),
              ),
            ),

            const SizedBox(height: 12),

            // ── STATS ROW
            FadeTransition(
              opacity: _cardsAnim,
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: _statsRow(),
              ),
            ),

            const SizedBox(height: 20),

            // ── INFO SECTION
            FadeTransition(
              opacity: _cardsAnim,
              child: SlideTransition(
                position: Tween<Offset>(
                    begin: const Offset(0, 0.08), end: Offset.zero)
                    .animate(_cardsAnim),
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      _sectionLabel('Academic Info'),
                      const SizedBox(height: 10),
                      _infoCard(children: [
                        _infoRow(Icons.badge_outlined,
                            'Roll Number', 'su92-bssem-s24-099', _primary),
                        _divider(),
                        _infoRow(Icons.school_outlined, 'Batch',
                            _batch, _accent),
                        _divider(),
                        _infoRow(Icons.layers_outlined, 'Current Semester',
                            '$_semester Semester', _primary),
                        _divider(),
                        _infoRow(Icons.location_city_outlined, 'Campus',
                            'Superior Gold Campus', _accent),
                      ]),

                      const SizedBox(height: 20),
                      _sectionLabel('Performance'),
                      const SizedBox(height: 10),
                      _performanceCard(),

                      const SizedBox(height: 20),
                      _sectionLabel('Settings & More'),
                      const SizedBox(height: 10),
                      _menuCard(),

                      const SizedBox(height: 30),
                    ],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  // ── HERO HEADER ──────────────────────────────
  Widget _buildHeader(BuildContext context) {
    final topPadding = MediaQuery.of(context).padding.top;
    return Container(
      height: 280 + topPadding,
      child: Stack(
        clipBehavior: Clip.none,
        children: [
          // ── background gradient shape
          ClipPath(
            clipper: _HeaderClipper(),
            child: Container(
              height: 230 + topPadding,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [Color(0xFF6A1B6E), Color(0xFF8B3A8F), Color(0xFFAD5FB5)],
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                ),
              ),
              child: Stack(
                children: [
                  Positioned(top: -30, right: -30, child: _decorCircle(140, Colors.white.withOpacity(0.07))),
                  Positioned(top: 50, right: 60, child: _decorCircle(60, Colors.white.withOpacity(0.06))),
                  Positioned(bottom: 30, left: -20, child: _decorCircle(100, _accent.withOpacity(0.15))),
                  Positioned.fill(child: CustomPaint(painter: _DotGridPainter())),
                ],
              ),
            ),
          ),

          // ── notification bell
          Positioned(
            top: topPadding + 14,
            right: 20,
            child: Stack(
              children: [
                const CustomIconButton(marginEnd: false),
                Positioned(
                  right: 4,
                  top: 0,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(color: Colors.red, shape: BoxShape.circle),
                    child: const Text("3", style: TextStyle(color: Colors.white, fontSize: 10, fontWeight: FontWeight.bold)),
                  ),
                ),
              ],
            ),
          ),

          // ── page title
          Positioned(
            top: topPadding + 20,
            left: 0,
            right: 0,
            child: const Center(
              child: Text('Profile', style: TextStyle(fontSize: 22, fontWeight: FontWeight.w500, color: Colors.white, letterSpacing: 0.3)),
            ),
          ),

          // ── AVATAR SECTION (Wrapped with Navigation)
          Positioned(
            bottom: 0,
            left: 0,
            right: 0,
            child: Column(
              children: [
                GestureDetector(
                  onTap: () => Navigator.push(context, MaterialPageRoute(builder: (context) => const EditProfileScreen())),
                  child: Stack(
                    alignment: Alignment.center,
                    children: [
                      Container(
                        width: 96,
                        height: 96,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          gradient: const SweepGradient(colors: [Color(0xFF8B3A8F), Color(0xFFB5860D), Color(0xFF8B3A8F)]),
                          boxShadow: [BoxShadow(color: _primary.withOpacity(0.4), blurRadius: 20, spreadRadius: 2)],
                        ),
                      ),
                      Container(
                        width: 90,
                        height: 90,
                        decoration: const BoxDecoration(color: Colors.white, shape: BoxShape.circle),
                      ),
                      Container(
                        width: 84,
                        height: 84,
                        decoration: BoxDecoration(shape: BoxShape.circle, color: _primary.withOpacity(0.15)),
                        child: ClipOval(child: Icon(Icons.person_rounded, size: 52, color: _primary)),
                      ),
                      Positioned(
                        bottom: 0,
                        right: 0,
                        child: Container(
                          width: 26,
                          height: 26,
                          decoration: BoxDecoration(
                            color: _accent,
                            shape: BoxShape.circle,
                            border: Border.all(color: Colors.white, width: 2),
                          ),
                          child: const Icon(Icons.edit_rounded, color: Colors.white, size: 13),
                        ),
                      ),
                    ],
                  ),
                ),
                const SizedBox(height: 10),
                Text(_name, style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w600, color: Color(0xFF1A1A2E))),
                const SizedBox(height: 4),
                Text(_rollNo, style: TextStyle(fontSize: 12, color: Colors.grey[600], fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(Icons.apartment_rounded, size: 16, color: _primary),
                    const SizedBox(width: 6),
                    Text(_dept, style: TextStyle(fontSize: 11, color: _primary, fontWeight: FontWeight.w600)),
                  ],
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

  Widget _statsRow() {
    return Row(
      children: [
        _statPill('CGPA', '$_cgpa', Icons.trending_up_rounded, _primary),
        const SizedBox(width: 10),
        _statPill('Credits', '$_credits/$_totalCredits',
            Icons.star_outline_rounded, _accent),
        const SizedBox(width: 10),
        _statPill('Semester', _semester, Icons.layers_rounded,
            const Color(0xFF2D5F8A)),
      ],
    );
  }

  Widget _statPill(
      String label, String value, IconData icon, Color color) {
    return Expanded(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 14, horizontal: 10),
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(18),
          boxShadow: [
            BoxShadow(
              color: color.withOpacity(0.15),
              blurRadius: 16,
              offset: const Offset(0, 6),
            )
          ],
          border: Border.all(color: color.withOpacity(0.2), width: 0.8),
        ),
        child: Column(
          children: [
            Container(
              width: 45,
              height: 45,
              decoration: BoxDecoration(
                color: color.withOpacity(0.12),
                shape: BoxShape.circle,
              ),
              child: Icon(icon, color: color, size: 20),
            ),
            const SizedBox(height: 6),
            Text(
              value,
              style: TextStyle(
                fontSize: 16,
                fontWeight: FontWeight.w800,
                color: color,
              ),
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: TextStyle(
                fontSize: 12,
                color: Colors.grey[500],
                fontWeight: FontWeight.w500,
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _sectionLabel(String label) {
    return Row(
      children: [
        Container(
          width: 4,
          height: 18,
          decoration: BoxDecoration(
            color: _primary,
            borderRadius: BorderRadius.circular(4),
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 14,
            fontWeight: FontWeight.w700,
            color: Color(0xFF1A1A2E),
            letterSpacing: 0.2,
          ),
        ),
      ],
    );
  }

  Widget _infoCard({required List<Widget> children}) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(children: children),
    );
  }

  Widget _infoRow(IconData icon, String label, String value, Color color) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 18, vertical: 13),
      child: Row(
        children: [
          Container(
            width: 45,
            height: 45,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              borderRadius: BorderRadius.circular(25),
            ),
            child: Icon(icon, color: color, size: 25),
          ),
          const SizedBox(width: 16),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(label,
                    style: TextStyle(
                        fontSize: 12,
                        color: Colors.grey[500],
                        fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(value,
                    style: const TextStyle(
                        fontSize: 14,
                        color: Color(0xFF1A1A2E),
                        fontWeight: FontWeight.w600)),
              ],
            ),
          ),
          Icon(Icons.chevron_right_rounded,
              color: Colors.grey[300], size: 25),
        ],
      ),
    );
  }

  Widget _divider() => Padding(
    padding: const EdgeInsets.only(left: 68, right: 18),
    child: Divider(height: 1, color: Colors.grey[100]),
  );

  Widget _performanceCard() {
    return Container(
      padding: const EdgeInsets.all(18),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [
            _primary.withOpacity(0.92),
            const Color(0xFF6A1B6E),
          ],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
        boxShadow: [
          BoxShadow(
            color: _primary.withOpacity(0.35),
            blurRadius: 20,
            offset: const Offset(0, 8),
          )
        ],
      ),
      child: Column(
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Overall CGPA',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              Text('${_cgpa.toStringAsFixed(1)} / 4.0',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _cgpa / 4.0,
              minHeight: 7,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFFB5860D)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('Credits Earned',
                  style: TextStyle(
                      color: Colors.white70,
                      fontSize: 12,
                      fontWeight: FontWeight.w500)),
              Text('$_credits / $_totalCredits',
                  style: const TextStyle(
                      color: Colors.white,
                      fontSize: 13,
                      fontWeight: FontWeight.w700)),
            ],
          ),
          const SizedBox(height: 8),
          ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: LinearProgressIndicator(
              value: _credits / _totalCredits,
              minHeight: 7,
              backgroundColor: Colors.white.withOpacity(0.2),
              valueColor:
              const AlwaysStoppedAnimation<Color>(Color(0xFF5FB5A0)),
            ),
          ),
          const SizedBox(height: 16),
          Row(
            children: [
              _miniStat('Passed', '10', Icons.check_circle_outline_rounded),
              _miniStatDivider(),
              _miniStat('Failed', '0', Icons.cancel_outlined),
              _miniStatDivider(),
              _miniStat('Pending', '3', Icons.hourglass_empty_rounded),
            ],
          ),
        ],
      ),
    );
  }

  Widget _miniStat(String label, String value, IconData icon) {
    return Expanded(
      child: Column(
        children: [
          Icon(icon, color: Colors.white60, size: 16),
          const SizedBox(height: 4),
          Text(value,
              style: const TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w800)),
          Text(label,
              style: const TextStyle(
                  color: Colors.white54, fontSize: 10)),
        ],
      ),
    );
  }

  Widget _miniStatDivider() => Container(
      width: 1, height: 36, color: Colors.white.withOpacity(0.15));

  // ── MENU CARD ────────────────────────────────
  Widget _menuCard() {
    final items = [
      (Icons.notifications_outlined, 'Notifications', _primary),
      (Icons.lock_outline_rounded, 'Change Password', _accent),
      (Icons.help_outline_rounded, 'Help & Support', const Color(0xFF2D5F8A)),
      (Icons.logout_rounded, 'Logout', Colors.red),
    ];

    return Container(
      padding: const EdgeInsets.symmetric(vertical: 16, horizontal: 4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(16),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 18,
            offset: const Offset(0, 6),
          )
        ],
      ),
      child: Column(
        children: List.generate(items.length, (i) {
          final item = items[i];
          return Column(
            children: [
              ListTile(
                leading: Container(
                  width: 45,
                  height: 45,
                  decoration: BoxDecoration(
                    color: item.$3.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: Icon(item.$1, color: item.$3, size: 25),
                ),
                title: Text(
                  item.$2,
                  style: TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.w600,
                    color: item.$3 == Colors.red ? Colors.red : const Color(0xFF1A1A2E),
                  ),
                ),
                trailing: item.$3 != Colors.red
                    ? Icon(Icons.chevron_right_rounded, color: Colors.grey[300], size: 25)
                    : null,
                dense: true,
                onTap: () {
                  // ── NAVIGATION LOGIC ──────────────────
                  switch (item.$2) {
                    case 'Notifications':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const NotificationScreen()));
                      break;
                    case 'Change Password':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const ChangePasswordScreen()));
                      break;
                    case 'Help & Support':
                      Navigator.push(context, MaterialPageRoute(builder: (context) => const SupportScreen()));
                      break;
                    case 'Logout':
                    // Logout ke liye hum replace use karte hain taake user back na aa sakay
                      Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (context) => const LoginScreen()),
                            (route) => false,
                      );
                      break;
                  }
                },
              ),
              if (i < items.length - 1)
                Padding(
                  padding: const EdgeInsets.only(left: 68, right: 18),
                  child: Divider(height: 1, color: Colors.grey[100]),
                ),
            ],
          );
        }),
      ),
    );
  }


  Widget _decorCircle(double size, Color color) => Container(
    width: size,
    height: size,
    decoration: BoxDecoration(
        color: color, shape: BoxShape.circle),
  );
}

class _HeaderClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()
      ..lineTo(0, size.height - 40)
      ..quadraticBezierTo(
          size.width * 0.5, size.height + 20, size.width, size.height - 40)
      ..lineTo(size.width, 0)
      ..close();
    return path;
  }

  @override
  bool shouldReclip(_) => false;
}

class _DotGridPainter extends CustomPainter {
  @override
  void paint(Canvas canvas, Size size) {
    final paint = Paint()
      ..color = Colors.white.withOpacity(0.08)
      ..style = PaintingStyle.fill;
    const spacing = 22.0;
    for (double x = spacing; x < size.width; x += spacing) {
      for (double y = spacing; y < size.height; y += spacing) {
        canvas.drawCircle(Offset(x, y), 1.5, paint);
      }
    }
  }

  @override
  bool shouldRepaint(_) => false;
}
