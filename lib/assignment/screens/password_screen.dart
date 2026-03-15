// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
//
//
// class PasswordScreen extends StatelessWidget {
//   final VoidCallback onNext;
//
//   const PasswordScreen({super.key, required this.onNext});
//
//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       spacing: 16,
//       children: [
//         const Text(
//           "STEP 3/7",
//           style: TextStyle(
//             fontSize: 14,
//             color: Color(0xFF7265E3),
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         const Text(
//           "Set your password",
//           textAlign: TextAlign.center,
//           maxLines: 2,
//           style: TextStyle(
//             fontSize: 28,
//             color: Colors.black,
//             fontWeight: FontWeight.w500,
//           ),
//         ),
//
//         Container(
//           decoration: BoxDecoration(
//             border: Border.all(color: Colors.grey[100]!),
//             borderRadius: BorderRadius.circular(16),
//             color: Colors.white,
//             boxShadow: [
//               BoxShadow(
//                 blurRadius: 10,
//                 spreadRadius: 1,
//                 offset: Offset(0, 5),
//                 color: Colors.grey.shade200,
//               ),
//             ],
//           ),
//           margin: EdgeInsetsDirectional.symmetric(horizontal: 40),
//           padding: EdgeInsetsGeometry.all(8),
//           child: TextField(
//             keyboardType: TextInputType.visiblePassword,
//             decoration: InputDecoration(
//               border: InputBorder.none,
//               hintMaxLines: 1,
//               suffixIcon: Icon(Icons.visibility),
//               contentPadding: EdgeInsets.symmetric(horizontal: 16),
//             ),
//             stylusHandwritingEnabled: true,
//             style: TextStyle(
//               fontSize: 30,
//               letterSpacing: 6,
//               fontWeight: FontWeight.bold
//             ),
//             cursorHeight: 20,
//             obscuringCharacter: "*",
//             obscureText: true,
//
//             textAlign: TextAlign.center,
//             textAlignVertical: TextAlignVertical.center,
//             maxLines: 1,
//           ),
//         ),
//
//         LinearProgressIndicator(
//           trackGap: 8,
//           semanticsLabel: "",
//           stopIndicatorColor: Colors.redAccent,
//           color: Colors.orangeAccent,
//           value: 0.7,
//         ),
//         FilledButton(
//           onPressed: () {},
//           style: FilledButton.styleFrom(
//             backgroundColor: Color(0xFF7265E3),
//             padding: EdgeInsets.symmetric(horizontal: 80, vertical: 16),
//             shape: RoundedRectangleBorder(
//               borderRadius: BorderRadiusGeometry.circular(18),
//             ),
//           ),
//           child: Text(
//             "Verify Now",
//             style: TextStyle(
//               fontWeight: FontWeight.bold,
//               fontSize: 20,
//               letterSpacing: 0.2,
//               fontFamily: "Rubik",
//               color: Colors.white,
//             ),
//           ),
//         ),
//       ],
//     );
//   }
// }


import 'package:flutter/material.dart';

class PasswordStrengthWidget extends StatefulWidget {
  final ValueChanged<String>? onPasswordChanged;
  final VoidCallback? onContinue;

  const PasswordStrengthWidget({
    Key? key,
    this.onPasswordChanged,
    this.onContinue,
  }) : super(key: key);

  @override
  State<PasswordStrengthWidget> createState() => _PasswordStrengthWidgetState();
}

class _PasswordStrengthWidgetState extends State<PasswordStrengthWidget> {
  late TextEditingController _passwordController;
  bool _obscureText = true;
  String _password = '';

  // Validation checks
  late bool has8Chars;
  late bool has1Uppercase;
  late bool has1Symbol;
  late bool has1Number;

  @override
  void initState() {
    super.initState();
    _passwordController = TextEditingController();
    _initializeValidations();
  }

  void _initializeValidations() {
    has8Chars = false;
    has1Uppercase = false;
    has1Symbol = false;
    has1Number = false;
  }

  @override
  void dispose() {
    _passwordController.dispose();
    super.dispose();
  }

  void _updatePasswordValidation(String password) {
    setState(() {
      _password = password;
      has8Chars = password.length >= 8;
      has1Uppercase = password.contains(RegExp(r'[A-Z]'));
      has1Symbol = password.contains(RegExp(r'[!@#$%^&*()_+\-=\[\]{};:\'",.<>?]"));
      has1Number = password.contains(RegExp(r'[0-9]'));
    });
    widget.onPasswordChanged?.call(password);
  }

  double _calculateStrength() {
    int count = 0;
    if (has8Chars) count++;
    if (has1Uppercase) count++;
    if (has1Symbol) count++;
    if (has1Number) count++;

    return count / 4;
  }

  Color _getStrengthColor() {
    double strength = _calculateStrength();
    if (strength < 0.25) return Colors.red;
    if (strength < 0.5) return Colors.orange;
    if (strength < 0.75) return Colors.amber;
    return Colors.green;
  }

  String _getStrengthText() {
    double strength = _calculateStrength();
    if (strength < 0.25) return 'Weak';
    if (strength < 0.5) return 'Fair';
    if (strength < 0.75) return 'Good';
    return 'Strong';
  }

  bool _isPasswordValid() {
    return has8Chars && has1Uppercase && has1Symbol && has1Number;
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      padding: const EdgeInsets.symmetric(horizontal: 24),
      child: Column(
        spacing: 24,
        children: [
          // Step indicator
          const Text(
            "STEP 3/7",
            style: TextStyle(
              fontSize: 14,
              color: Color(0xFF7265E3),
              fontWeight: FontWeight.w500,
              letterSpacing: 1.2,
            ),
          ),

          // Title
          const Text(
            "Set your password",
            textAlign: TextAlign.center,
            maxLines: 2,
            style: TextStyle(
              fontSize: 28,
              color: Colors.black,
              fontWeight: FontWeight.w600,
            ),
          ),

          // Password input field
          Container(
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[100]!),
              borderRadius: BorderRadius.circular(16),
              color: Colors.white,
              boxShadow: [
                BoxShadow(
                  blurRadius: 10,
                  spreadRadius: 1,
                  offset: const Offset(0, 5),
                  color: Colors.grey.shade200,
                ),
              ],
            ),
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            child: TextField(
              controller: _passwordController,
              keyboardType: TextInputType.visiblePassword,
              obscureText: _obscureText,
              obscuringCharacter: "*",
              onChanged: _updatePasswordValidation,
              decoration: InputDecoration(
                border: InputBorder.none,
                contentPadding: EdgeInsets.zero,
                hintText: "Enter password",
                hintStyle: TextStyle(
                  color: Colors.grey[400],
                  fontSize: 16,
                ),
                suffixIcon: GestureDetector(
                  onTap: () {
                    setState(() {
                      _obscureText = !_obscureText;
                    });
                  },
                  child: Icon(
                    _obscureText ? Icons.visibility_off : Icons.visibility,
                    color: const Color(0xFF7265E3),
                  ),
                ),
              ),
              style: const TextStyle(
                fontSize: 18,
                letterSpacing: 4,
                fontWeight: FontWeight.bold,
              ),
              cursorHeight: 20,
              textAlign: TextAlign.center,
              textAlignVertical: TextAlignVertical.center,
              maxLines: 1,
            ),
          ),

          // Password strength indicator
          Column(
            spacing: 8,
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: LinearProgressIndicator(
                  value: _calculateStrength(),
                  minHeight: 8,
                  backgroundColor: Colors.grey[200],
                  valueColor: AlwaysStoppedAnimation<Color>(
                    _getStrengthColor(),
                  ),
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Strength: ${_getStrengthText()}",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStrengthColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  Text(
                    "${(_calculateStrength() * 100).toInt()}%",
                    style: TextStyle(
                      fontSize: 12,
                      color: _getStrengthColor(),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
            ],
          ),

          // Requirements checklist
          Container(
            decoration: BoxDecoration(
              color: Colors.grey[50],
              borderRadius: BorderRadius.circular(12),
              border: Border.all(color: Colors.grey[200]!),
            ),
            padding: const EdgeInsets.all(16),
            child: Column(
              spacing: 12,
              children: [
                Row(
                  spacing: 12,
                  children: [
                    _buildRequirementCheck(has8Chars),
                    const Text(
                      "8+ characters",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    _buildRequirementCheck(has1Uppercase),
                    const Text(
                      "1 uppercase",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
                Row(
                  spacing: 12,
                  children: [
                    _buildRequirementCheck(has1Symbol),
                    const Text(
                      "1 symbol",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                    const Spacer(),
                    _buildRequirementCheck(has1Number),
                    const Text(
                      "1 number",
                      style: TextStyle(
                        fontSize: 14,
                        color: Colors.black87,
                      ),
                    ),
                  ],
                ),
              ],
            ),
          ),

          // Continue button
          SizedBox(
            width: double.infinity,
            height: 56,
            child: FilledButton(
              onPressed: _isPasswordValid()
                  ? () {
                widget.onContinue?.call();
                ScaffoldMessenger.of(context).showSnackBar(
                  SnackBar(
                    content: Text('Password saved: ${_password.length} characters'),
                    backgroundColor: Colors.green,
                  ),
                );
              }
                  : null,
              style: FilledButton.styleFrom(
                backgroundColor: const Color(0xFF7265E3),
                disabledBackgroundColor: Colors.grey[300],
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(16),
                ),
              ),
              child: const Text(
                "Continue",
                style: TextStyle(
                  fontWeight: FontWeight.bold,
                  fontSize: 18,
                  color: Colors.white,
                ),
              ),
            ),
          ),

          const SizedBox(height: 16),
        ],
      ),
    );
  }

  Widget _buildRequirementCheck(bool isMet) {
    return Container(
      width: 20,
      height: 20,
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: isMet ? const Color(0xFF7265E3) : Colors.grey[300],
      ),
      child: isMet
          ? const Icon(
        Icons.check,
        size: 14,
        color: Colors.white,
      )
          : null,
    );
  }
}