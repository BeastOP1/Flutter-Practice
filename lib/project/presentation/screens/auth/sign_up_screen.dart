import 'package:flutter/material.dart';
import 'package:flutter_learn/project/core/utils/validators.dart';
import 'package:flutter_learn/project/presentation/providers/auth_provider.dart' show authProvider, AuthStatus;
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_svg/flutter_svg.dart';

class SignupScreen extends ConsumerStatefulWidget {
  const SignupScreen({super.key});

  @override
  ConsumerState<SignupScreen> createState() => _SignupScreenState();
}

class _SignupScreenState extends ConsumerState<SignupScreen> {
  final Color primaryColor = const Color(0xFF8A2373);

  // Controllers
  final _fullNameController = TextEditingController();
  final _phoneController = TextEditingController();
  final _emailController = TextEditingController();
  final _universityIdController = TextEditingController();
  final _passwordController = TextEditingController();

  bool _obscurePassword = true;

  // Error states
  String? _fullNameError;
  String? _phoneError;
  String? _emailError;
  String? _universityIdError;
  String? _passwordError;

  @override
  void dispose() {
    _fullNameController.dispose();
    _phoneController.dispose();
    _emailController.dispose();
    _universityIdController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _validateAll() {
    setState(() {
      _fullNameError = Validators.validateFullName(_fullNameController.text);
      _phoneError = Validators.validatePhone(_phoneController.text);
      _emailError = Validators.validateEmail(_emailController.text);
      _universityIdError = Validators.validateUniversityId(_universityIdController.text);
      _passwordError = Validators.validatePassword(_passwordController.text);
    });

    return _fullNameError == null &&
        _phoneError == null &&
        _emailError == null &&
        _universityIdError == null &&
        _passwordError == null;
  }

  Future<void> _handleSignup() async {
    if (!_validateAll()) return;

    await ref.read(authProvider.notifier).signUp(
      email: _emailController.text.trim(),
      password: _passwordController.text.trim(),
      fullName: _fullNameController.text.trim(),
      universityId: _universityIdController.text.trim(),
      phoneNumber: _phoneController.text.trim(),
    );

    final state = ref.read(authProvider);
    if (!mounted) return;

    if (state.status == AuthStatus.authenticated) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(
          content: Text('Account created successfully!'),
          backgroundColor: Colors.green,
        ),
      );
      Navigator.pop(context);
    } else if (state.status == AuthStatus.error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(state.errorMessage ?? 'Signup failed'),
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
            Container(
              padding: const EdgeInsets.only(left: 18),
              alignment: Alignment.bottomLeft,
              height: 160,
              child: const Text(
                "Create Account",
                style: TextStyle(
                  fontSize: 38,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
            Padding(
              padding: const EdgeInsets.symmetric(horizontal: 30),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const SizedBox(height: 20),

                  // Full Name
                  _buildLabel("Full Name"),
                  _buildTextField(
                    controller: _fullNameController,
                    hint: "Enter your full name",
                    iconPath: 'assets/ic_user.svg',
                    errorText: _fullNameError,
                  ),
                  const SizedBox(height: 20),

                  // University ID
                  _buildLabel("University ID"),
                  _buildTextField(
                    controller: _universityIdController,
                    hint: "Enter your university ID",
                    iconPath: 'assets/ic_user.svg',
                    errorText: _universityIdError,
                  ),
                  const SizedBox(height: 20),

                  // Phone Number
                  _buildLabel("Phone Number"),
                  _buildTextField(
                    controller: _phoneController,
                    hint: "+92 000-000-000",
                    iconPath: 'assets/ic_phone.svg',
                    errorText: _phoneError,
                    keyboardType: TextInputType.phone,
                  ),
                  const SizedBox(height: 20),

                  // Email
                  _buildLabel("Email Address"),
                  _buildTextField(
                    controller: _emailController,
                    hint: "Enter your email",
                    iconPath: 'assets/ic_mail.svg',
                    errorText: _emailError,
                    keyboardType: TextInputType.emailAddress,
                  ),
                  const SizedBox(height: 20),

                  // Password
                  _buildLabel("Password"),
                  _buildTextField(
                    controller: _passwordController,
                    hint: "********",
                    iconPath: 'assets/ic_lock.svg',
                    errorText: _passwordError,
                    isPassword: true,
                    obscureText: _obscurePassword,
                    onToggleVisibility: () {
                      setState(() {
                        _obscurePassword = !_obscurePassword;
                      });
                    },
                  ),
                  const SizedBox(height: 40),

                  // Sign Up Button
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
                      onPressed: isLoading ? null : _handleSignup,
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
                        "Sign Up",
                        style: TextStyle(
                          color: Colors.white,
                          fontSize: 18,
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 30),

                  // Login Link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Text("Already have an account? "),
                      GestureDetector(
                        onTap: () => Navigator.pop(context),
                        child: Text(
                          "Log In",
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
      height: 0,
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
    return Padding(
      padding: const EdgeInsets.only(bottom: 8.0),
      child: Text(
        text,
        style: const TextStyle(
          color: Colors.grey,
          fontSize: 14,
        ),
      ),
    );
  }

  Widget _buildTextField({
    required TextEditingController controller,
    required String hint,
    required String iconPath,
    String? errorText,
    bool isPassword = false,
    bool obscureText = false,
    VoidCallback? onToggleVisibility,
    TextInputType keyboardType = TextInputType.text,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        TextField(
          controller: controller,
          obscureText: isPassword ? obscureText : false,
          keyboardType: keyboardType,
          decoration: InputDecoration(
            hintText: hint,
            prefixIcon: Padding(
              padding: const EdgeInsets.all(12.0),
              child: SvgPicture.asset(
                iconPath,
                width: 20,
                height: 20,
                colorFilter: ColorFilter.mode(primaryColor, BlendMode.srcIn),
                errorBuilder: (context, error, stackTrace) {
                  return Icon(Icons.error_outline, size: 20, color: primaryColor);
                },
              ),
            ),
            suffixIcon: isPassword
                ? IconButton(
              icon: Icon(
                obscureText ? Icons.visibility_off : Icons.visibility,
                color: Colors.grey,
              ),
              onPressed: onToggleVisibility,
            )
                : null,
            enabledBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.grey.shade300),
            ),
            focusedBorder: UnderlineInputBorder(
              borderSide: BorderSide(color: primaryColor),
            ),
            errorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            focusedErrorBorder: const UnderlineInputBorder(
              borderSide: BorderSide(color: Colors.red),
            ),
            errorText: errorText,
          ),
        ),
      ],
    );
  }
}
