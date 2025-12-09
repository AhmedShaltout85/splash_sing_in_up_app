import 'package:flutter/material.dart';
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
                  Text(
                    'Let\'s Get Started!',
                    style: TextStyle(
                      fontSize: 28,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),

                  SizedBox(height: 8),

                  // Subtitle
                  Text(
                    'Create an account on MNZL to get all features',
                    textAlign: TextAlign.center,
                    style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                  ),

                  SizedBox(height: 35),

                  // First Name field
                  _buildInputField(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    icon: Image.asset('assets/images/user.png', width: 24),
                  ),

                  SizedBox(height: 18),

                  // Last Name field
                  _buildInputField(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    icon: Image.asset('assets/images/user.png', width: 24),
                  ),

                  SizedBox(height: 18),

                  // User Name field
                  _buildInputField(
                    controller: _userNameController,
                    hintText: 'User Name',
                    icon: Image.asset('assets/images/user.png', width: 24),
                  ),

                  SizedBox(height: 18),

                  // Email field
                  _buildInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Image.asset(
                      'assets/images/iconfinder_Mail_728953 1.png',
                      width: 24,
                    ),
                  ),

                  SizedBox(height: 18),

                  // Password field
                  _buildInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Image.asset('assets/images/lock.png', width: 24),
                    obscureText: true,
                  ),

                  SizedBox(height: 18),

                  // Confirm Password field
                  _buildInputField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: Image.asset('assets/images/lock.png', width: 24),
                    obscureText: true,
                  ),

                  SizedBox(height: 35),

                  // Create button
                  Container(
                    width: 200,
                    height: 50,
                    decoration: BoxDecoration(
                      gradient: LinearGradient(
                        colors: [Color(0xFF8CD6F7), Color(0xFF6BB8E3)],
                        begin: Alignment.topCenter,
                        end: Alignment.bottomCenter,
                      ),
                      borderRadius: BorderRadius.circular(10),
                      boxShadow: [
                        BoxShadow(
                          color: Color(0xFF8CD6F7).withOpacity(0.4),
                          blurRadius: 12,
                          offset: Offset(0, 6),
                        ),
                      ],
                    ),
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: () {
                          // Handle create account
                        },
                        borderRadius: BorderRadius.circular(10),
                        child: Center(
                          child: Text(
                            'CREATE',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 1.2,
                            ),
                          ),
                        ),
                      ),
                    ),
                  ),

                  SizedBox(height: 25),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(fontSize: 14, color: Colors.grey[700]),
                      ),
                      GestureDetector(
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => LoginScreen(),
                            ),
                          );
                        },
                        child: Text(
                          'Login here',
                          style: TextStyle(
                            fontSize: 14,
                            color: Colors.black,
                            fontWeight: FontWeight.bold,
                          ),
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

  Widget _buildInputField({
    required TextEditingController controller,
    required String hintText,
    required Image icon,
    bool obscureText = false,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: Color(0xFFF0F0F0),
        borderRadius: BorderRadius.circular(10),
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
          prefixIcon: icon,
          border: InputBorder.none,
          contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
        ),
      ),
    );
  }
}
