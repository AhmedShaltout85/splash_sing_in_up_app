import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/custom_widgets/custom_button.dart';
import 'package:splash_sing_in_up_app/custom_widgets/custom_text.dart';
import 'package:splash_sing_in_up_app/resuable_widgets/resuable_widgets.dart';
import '../../custom_widgets/custom_textfield_signup.dart';
import '../login/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _confirmPasswordController =
      TextEditingController();

  @override
  void dispose() {
    _firstNameController.dispose();
    _lastNameController.dispose();
    _userNameController.dispose();
    _emailController.dispose();
    _passwordController.dispose();
    _confirmPasswordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFFFFFFF),
      body: SafeArea(
        child: Center(
          child: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(
                horizontal: 30.0,
                vertical: 50.0,
              ),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  // Title
                  CustomText(
                    text: 'Let\'s Get Started!',
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.black,
                  ),

                  SizedBox(height: 8),

                  // Subtitle
                  CustomText(
                    text: 'Create an account on MNZL to get all features',
                    fontSize: 14,
                    fontWeight: FontWeight.normal,
                    color: Colors.grey[600],
                  ),

                  SizedBox(height: 35),

                  // First Name field
                  buildInputField(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    icon: Image.asset('assets/images/user.png', width: 24),
                  ),

                  SizedBox(height: 18),

                  // Last Name field
                  buildInputField(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    icon: Image.asset('assets/images/user.png', width: 24),
                  ),

                  SizedBox(height: 18),

                  // User Name field
                  buildInputField(
                    controller: _userNameController,
                    hintText: 'User Name',
                    icon: Image.asset('assets/images/user.png', width: 24),
                  ),

                  SizedBox(height: 18),

                  // Email field
                  buildInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Image.asset(
                      'assets/images/iconfinder_Mail_728953 1.png',
                      width: 24,
                    ),
                  ),

                  SizedBox(height: 18),

                  // Password field
                  buildInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Image.asset('assets/images/lock.png', width: 24),
                    obscureText: true,
                  ),

                  SizedBox(height: 18),

                  // Confirm Password field
                  buildInputField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: Image.asset('assets/images/lock.png', width: 24),
                    obscureText: true,
                  ),

                  SizedBox(height: 35),

                  // Create button
                  CustomElevatedButton(
                    text: 'CREATE',
                    color: Color(0xFF8CD6F7),
                    textColor: Colors.white,
                    fontSize: 16,
                    height: 50,
                    width: 200,
                    onTap: () {
                      // Handle create account
                      navigateTo(context, LoginScreen());
                    },
                  ),

                  SizedBox(height: 25),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an account? ',
                        fontSize: 14,
                        fontWeight: FontWeight.normal,
                        color: Colors.grey[700],
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle login
                          navigateTo(context, LoginScreen());
                        },
                        child: CustomText(
                          text: 'Login here',
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                          color: Colors.black,
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
