import 'package:flutter/material.dart';

import '../../custom_widgets/custom_logo_text.dart';
import '../../custom_widgets/custom_social_icon.dart';
import '../../custom_widgets/custom_text.dart';
import '../../custom_widgets/custom_text_field.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _usernameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();

  @override
  void dispose() {
    _usernameController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: SingleChildScrollView(
          child: Column(
            children: [
              // Decorative shapes at the top
              SizedBox(
                height: 120,
                width: double.infinity,
                child: Stack(
                  clipBehavior: Clip.none,
                  children: [
                    // Light blue shape (left side) - 8CD6F7
                    Positioned(
                      left: 40,
                      top: -130,
                      child: Transform.rotate(
                        angle: -15, // -15 degrees
                        child: Container(
                          height: 172,
                          width: 286,
                          decoration: BoxDecoration(
                            color: Color(0xFF7A9EAE),
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                    ),
                    // Gray-blue shape (right side) - 7A9EAE
                    Positioned(
                      right: 220,
                      top: -110,
                      child: Transform.rotate(
                        angle: -15, // -15 degrees
                        child: Container(
                          height: 171,
                          width: 307,
                          decoration: BoxDecoration(
                            color: Color(0xFF8CD6F7),
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              SizedBox(height: 20),

              // Logo
              CustomLogoText(),

              SizedBox(height: 15),

              // Welcome back text
              CustomText(
                text: 'Welcome back!',
                textAlign: TextAlign.center,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: Colors.black,
              ),

              SizedBox(height: 8),

              // Subtitle
              CustomText(
                text: 'Log in to existing LOGO account',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),

              SizedBox(height: 25),

              // Username field
              // CustomTextField(usernameController: _usernameController),
              CustomTextFiled(
                controller: _usernameController,
                obscureText: false,
                hintText: 'Username',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                prefixIcon: Image.asset(
                  'assets/images/user.png',
                  width: 22,
                  height: 22,
                ),
                color: Color(0xFFF0F0F0),
                textInputType: TextInputType.text,
              ),

              SizedBox(height: 15),

              // Password field
              CustomTextFiled(
                controller: _passwordController,
                obscureText: true,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                prefixIcon: Image.asset(
                  'assets/images/lock.png',
                  width: 22,
                  height: 22,
                ),
                color: Color(0xFFF0F0F0),
                textInputType: TextInputType.visiblePassword,
              ),
              SizedBox(height: 3),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: () {},
                    child: CustomText(
                      text: 'Forgot Password?',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: Colors.grey[700],
                    ),
                  ),
                ),
              ),

              SizedBox(height: 30),

              // Login button
              CustomButton(),

              SizedBox(height: 30),

              // Or sign up using text
              CustomText(
                text: 'Or sign up using',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: Colors.grey[600],
              ),

              SizedBox(height: 20),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Facebook button
                  CustomSocialIcon(
                    iconPath: 'assets/images/facebook.png',
                    onTap: () {},
                  ),

                  SizedBox(width: 24),

                  // Google button
                  CustomSocialIcon(
                    iconPath: 'assets/images/google.png',
                    onTap: () {},
                  ),

                  SizedBox(width: 24),

                  // Apple button
                  CustomSocialIcon(
                    iconPath: 'assets/images/apple.png',
                    onTap: () {},
                  ),
                ],
              ),

              SizedBox(height: 20),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Don\'t have an account? ',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: Colors.grey[700],
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to sign up screen
                    },
                    child: CustomText(
                      text: 'Sign Up',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),

              SizedBox(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}

// class CustomTextField extends StatelessWidget {
//   const CustomTextField({
//     super.key,
//     required TextEditingController usernameController,
//   }) : _usernameController = usernameController;

//   final TextEditingController _usernameController;

//   @override
//   Widget build(BuildContext context) {
//     return Padding(
//       padding: const EdgeInsets.symmetric(horizontal: 36.0),
//       child: Container(
//         decoration: BoxDecoration(
//           color: Color(0xFFF0F0F0),
//           borderRadius: BorderRadius.circular(8),
//         ),
//         child: TextField(
//           controller: _usernameController,
//           decoration: InputDecoration(
//             hintText: 'Username',
//             hintStyle: TextStyle(color: Colors.grey[600], fontSize: 16),
//             prefixIcon: Icon(
//               Icons.person_outline,
//               color: Colors.grey[700],
//               size: 22,
//             ),
//             border: InputBorder.none,
//             contentPadding: EdgeInsets.symmetric(horizontal: 20, vertical: 18),
//           ),
//         ),
//       ),
//     );
//   }
// }
