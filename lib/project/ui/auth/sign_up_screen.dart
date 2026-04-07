import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends StatefulWidget {
  const SignupScreen({super.key});

  @override
  State<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends State<SignupScreen> {
  final Color primaryColor = const Color(0xFF8A2373);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _buildHeader(),
            Container(
              child: Text(
                "Welcome Back!",
                style: TextStyle(fontSize: 38, fontWeight: FontWeight.bold),
              ),
              padding: EdgeInsetsGeometry.only(left: 18),
              alignment: Alignment.bottomLeft,
              height: 160,
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),
                  _buildLabel("Full Name"),
                  _buildTextField("Enter your name", 'assets/ic_user.svg'),

                  const SizedBox(height: 20),
                  _buildLabel("Phone Number"),
                  _buildTextField("+92 000-000-000", 'assets/ic_phone.svg'),
                  const SizedBox(height: 20),
                  _buildLabel("Email Address"),
                  _buildTextField("Enter Address", 'assets/ic_mail.svg'),

                  const SizedBox(height: 20),
                  _buildLabel("Password"),
                  _buildTextField(
                    "********",
                    'assets/ic_lock.svg',
                    isPassword: true,
                  ),

                  const SizedBox(height: 40),

                  SizedBox(
                    width: double.infinity,
                    height: 55,
                    child: ElevatedButton(
                      style: ElevatedButton.styleFrom(
                        backgroundColor: primaryColor,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(10),
                        ),
                      ),
                      onPressed: () {
                        Navigator.pushNamed(context, '/home');
                      },
                      child: const Text(
                        "Sign Up",
                        style: TextStyle(color: Colors.white, fontSize: 18),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "LogIn",
                          style: TextStyle(
                            color: primaryColor,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 20),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildHeader() {
    return Container(
      height: 0, // Zero height
      child: OverflowBox(
        alignment: Alignment.topRight,
        maxHeight: double.infinity,
        maxWidth: double.infinity,
        child: Transform.translate(
          offset: const Offset(40, -30),
          child: SvgPicture.asset(
            'assets/su_logo.svg',
            width: 270,
            height: 270,
            color: const Color(0x1A8E2375),
            fit: BoxFit.contain,
          ),
        ),
      ),
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(color: Colors.grey, fontSize: 14));
  }

  Widget _buildTextField(
    String hint,
    String iconPath, {
    bool isPassword = false,
  }) {
    return TextField(
      obscureText: isPassword,
      decoration: InputDecoration(
        hintText: hint,
        prefixIcon: Padding(
          padding: const EdgeInsets.all(12.0),
          child: SvgPicture.asset(
            color: primaryColor,
            iconPath,
            width: 20,
            height: 20,
            errorBuilder: (context, error, stackTrace) {
              return const Icon(Icons.error_outline, size: 20);
            },
          ),
        ),

        enabledBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: Colors.grey.shade300),
        ),
        focusedBorder: UnderlineInputBorder(
          borderSide: BorderSide(color: primaryColor),
        ),
      ),
    );
  }
}
