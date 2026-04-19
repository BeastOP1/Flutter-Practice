import 'package:flutter/material.dart';
import 'package:flutter_learn/project/presentation/providers/auth_provider.dart'show authProvider, AuthStatus;
import 'package:flutter_learn/project/presentation/screens/auth/sign_up_screen.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:flutter_learn/project/core/utils/validators.dart';

class LoginScreen extends ConsumerStatefulWidget {
  const LoginScreen({super.key});

  @override
  ConsumerState<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends ConsumerState<LoginScreen> {
  bool _obscurePassword = true; // Default to hidden
  final _emailController = TextEditingController();
  final _passwordController = TextEditingController();
  final Color primaryColor = const Color(0xFF8A2373);

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  String? _emailError;
  String? _passwordError;

  bool _validate() {
    setState(() {
      _emailError = Validators.validateEmail(_emailController.text);
      _passwordError = Validators.validatePassword(_passwordController.text);
    });
    return _emailError == null && _passwordError == null;
  }

  Future<void> _handleLogin() async {
    if (!_validate()) return;

    await ref.read(authProvider.notifier).login(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
    );

    final state = ref.read(authProvider);
    if (!mounted) return;

    if (state.status == AuthStatus.authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Login Successful!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pushReplacementNamed(context, '/home');
    } else if (state.status == AuthStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage ?? 'Login failed'),
          backgroundColor: Colors.red,
        ),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    final authState = ref.watch(authProvider);
    final isLoading = authState.status == AuthStatus.loading;

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

                  // Email Field
                  _buildLabel("Email Address"),
                  TextField(
                    controller: _emailController,
                    enabled: !isLoading, // Disable while loading
                    decoration: InputDecoration(
                      hintText: "Enter your email",
                      errorText: _emailError,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/ic_mail.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            isLoading ? Colors.grey : primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),

                  const SizedBox(height: 30),

                  // Password Field
                  _buildLabel("Password"),
                  TextField(
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    enabled: !isLoading, // Disable while loading
                    decoration: InputDecoration(
                      hintText: "********",
                      errorText: _passwordError,
                      prefixIcon: Padding(
                        padding: const EdgeInsets.all(12.0),
                        child: SvgPicture.asset(
                          'assets/ic_lock.svg',
                          width: 20,
                          height: 20,
                          colorFilter: ColorFilter.mode(
                            isLoading ? Colors.grey : primaryColor,
                            BlendMode.srcIn,
                          ),
                        ),
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isLoading ? Colors.grey : Colors.grey.shade600,
                        ),
                        onPressed: isLoading
                            ? null
                            : () => setState(
                              () => _obscurePassword = !_obscurePassword,
                        ),
                      ),
                      enabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                      focusedBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: primaryColor),
                      ),
                      disabledBorder: UnderlineInputBorder(
                        borderSide: BorderSide(color: Colors.grey.shade300),
                      ),
                    ),
                  ),

                  _buildForgotPassword(isLoading),
                  const SizedBox(height: 20),

                  // Login Button with Loading State
                  _buildLoginButton(isLoading, _handleLogin),

                  const SizedBox(height: 50),
                  _buildSignupLink(isLoading),
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
            style: TextStyle(fontSize: 32, fontWeight: FontWeight.bold),
          ),
        ),
      ],
    );
  }

  Widget _buildLabel(String text) {
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(color: Colors.grey, fontSize: 14),
      ),
    );
  }

  Widget _buildForgotPassword(bool isLoading) {
    return Align(
      alignment: Alignment.center,
      child: TextButton(
        onPressed: isLoading ? null : () {
          // TODO: Implement forgot password
        },
        child: Text(
          "Forgot password?",
          style: TextStyle(
            color: isLoading ? Colors.grey : primaryColor,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),
    );
  }

  Widget _buildLoginButton(bool isLoading, VoidCallback onPressed) {
    return SizedBox(
      width: double.infinity,
      height: 55,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(
          backgroundColor: primaryColor,
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(10),
          ),
          disabledBackgroundColor: primaryColor.withOpacity(0.6),
        ),
        onPressed: isLoading ? null : onPressed,
        child: isLoading
            ? const SizedBox(
          height: 24,
          width: 24,
          child: CircularProgressIndicator(
            color: Colors.white,
            strokeWidth: 2,
          ),
        )
            : const Text(
          "Log In",
          style: TextStyle(color: Colors.white, fontSize: 18),
        ),
      ),
    );
  }

  Widget _buildSignupLink(bool isLoading) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.center,
      children: [
        Text(
          "Don't have an account? ",
          style: TextStyle(color: isLoading ? Colors.grey : Colors.black87),
        ),
        GestureDetector(
          onTap: isLoading
              ? null
              : () {
            Navigator.push(
              context,
              MaterialPageRoute(builder: (context) => const SignupScreen()),
            );
          },
          child: Text(
            "Sign Up",
            style: TextStyle(
              color: isLoading ? Colors.grey : primaryColor,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ],
    );
  }
}