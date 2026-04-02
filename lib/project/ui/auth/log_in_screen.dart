
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_learn/project/ui/auth/sign_up_screen.dart';
import 'package:flutter_svg/flutter_svg.dart';


class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  bool _isPasswordVisible = false;
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

            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 40),

                  _buildLabel("Email Address"),
                  TextField(
                    decoration: InputDecoration(
                      hintText: "Enter your email",

                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/ic_mail.svg',
                          width: 20,
                          height: 20,
                          color: primaryColor,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(borderSide: BorderSide(color: Colors.grey.shade300)),
                      focusedBorder: UnderlineInputBorder(borderSide: BorderSide(color: primaryColor)),
                    ),
                  ),

                  const SizedBox(height: 30),

                  _buildLabel("Password"),
                  TextField(
                    obscureText: !_isPasswordVisible,
                    decoration: InputDecoration(
                      hintText: "********",

                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          color: primaryColor,
                          'assets/ic_lock.svg',
                          width: 20,
                          height: 20,
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _isPasswordVisible ? Icons.visibility : Icons.visibility_off,
                          color: Colors.grey,
                        ),
                        onPressed: () => setState(() => _isPasswordVisible = !_isPasswordVisible),
                      ),
                      enabledBorder: UnderlineInputBorder(
                          borderSide: BorderSide(
                              color: Colors.grey.shade300)
                      ),
                      focusedBorder: UnderlineInputBorder
                        (borderSide: BorderSide
                        (color: primaryColor)
                      ),
                    ),
                  ),

                  _buildForgotPassword(),
                  const SizedBox(height: 20),
                  _buildLoginButton((){
                    Navigator.pushNamed(context, '/home');
                  }),
                  const SizedBox(height: 50),
                  _buildSignupLink(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
  Widget _buildHeader() {
    return Stack(
      children: [
        Container(
          height: 250,
          decoration: const BoxDecoration(
            image: DecorationImage(
              image: AssetImage('assets/su_logo.png'),
              fit: BoxFit.contain,
              opacity: 0.1,
              alignment: Alignment.topLeft,
            ),
          ),
        ),
        const Positioned(
          top: 150,
          left: 30,
          child: Text(
            "Welcome Back!",
            style: TextStyle(
                fontSize: 32,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Text(text, style: const TextStyle(
        color: Colors.grey
        , fontSize: 14)
    );
  }

  Widget _buildForgotPassword() {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: () {},
        child: Text(
          "Forgot password",
          style: TextStyle(
              color: primaryColor,
              fontWeight: FontWeight.bold
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton( VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
              borderRadius: BorderRadius.circular(10)
          ),
        ),
        onPressed: onPressed,
        child: const Text("Log in",
            style: TextStyle(
                color: Colors.white,
                fontSize: 18)
        ),
      ),
    );
  }

  Widget _buildSignupLink() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        const Text("Don't have an account? "),
        GestureDetector(
          onTap: () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: Text(
            "Signup",
            style: TextStyle(
                color: primaryColor,
                fontWeight: FontWeight.bold
            ),
          ),
        ),
      ],
    );
  }
}