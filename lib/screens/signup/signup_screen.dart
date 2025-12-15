import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/common_widgets/custom_widgets/custom_button.dart';
import 'package:splash_sing_in_up_app/common_widgets/custom_widgets/custom_text.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/resuable_widgets.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_dialog.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:splash_sing_in_up_app/newtorkl_repos/remote_repo/firebase_api_services.dart';
import 'package:splash_sing_in_up_app/utils/app_assets.dart';
import 'package:splash_sing_in_up_app/utils/app_colors.dart';

import '../../common_widgets/custom_widgets/custom_textfield_signup.dart';
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
    final double iconWH = 24;
    final double fontSize = 14;
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
                    fontSize: fontSize * 2,
                    fontWeight: FontWeight.bold,
                    color: AppColors.blackColor,
                  ),

                  gap(height: 8),

                  // Subtitle
                  CustomText(
                    text: 'Create an account on MNZL to get all features',
                    fontSize: fontSize,
                    fontWeight: FontWeight.normal,
                    color: AppColors.grayColor,
                  ),

                  gap(height: 35),

                  // First Name field
                  buildInputField(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    icon: Image.asset(AppAssets.user, width: iconWH),
                  ),

                  gap(height: 18),

                  // Last Name field
                  buildInputField(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    icon: Image.asset(AppAssets.user, width: iconWH),
                  ),

                  gap(height: 18),

                  // User Name field
                  buildInputField(
                    controller: _userNameController,
                    hintText: 'User Name',
                    icon: Image.asset(AppAssets.user, width: iconWH),
                  ),

                  gap(height: 18),

                  // Email field
                  buildInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Image.asset(AppAssets.mail, width: iconWH),
                  ),

                  gap(height: 18),

                  // Password field
                  buildInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Image.asset(AppAssets.lock, width: iconWH),
                    obscureText: true,
                  ),

                  gap(height: 18),

                  // Confirm Password field
                  buildInputField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: Image.asset(AppAssets.lock, width: iconWH),
                    obscureText: true,
                  ),

                  gap(height: 35),

                  // Create button
                  CustomElevatedButton(
                    text: 'CREATE',
                    color: AppColors.primaryColor,
                    textColor: AppColors.whiteColor,
                    fontSize: fontSize + 2,
                    height: 50,
                    width: 200,
                    onTap: () {
                      //create account on firebase by email and password
                      FirebaseApiSAuthServices.createUserWithEmailAndPassword(
                        emailAddress: _emailController.text.trim(),
                        password: _passwordController.text.trim(),
                      );
                      FirebaseApiSAuthServices.verifyEmail();
                      // ReusableToast.showToast(
                      //   message: 'Account created successfully',
                      //   bgColor: Colors.green,
                      //   textColor: Colors.white,
                      //   fontSize: fontSize,
                      // );
                      ReusableDialog.showAwesomeDialog(
                        context,
                        title: 'Account created successfully',
                        description:
                            'Please check your email to verify your account',
                        dialogType: DialogType.success,
                      );
                      // Handle create account
                      // navigateTo(context, LoginScreen());
                    },
                  ),

                  gap(height: 25),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomText(
                        text: 'Already have an account? ',
                        fontSize: fontSize,
                        fontWeight: FontWeight.normal,
                        color: AppColors.grayColor,
                      ),
                      GestureDetector(
                        onTap: () {
                          // Handle login
                          navigateTo(context, LoginScreen());
                        },
                        child: CustomText(
                          text: 'Login here',
                          fontSize: fontSize,
                          fontWeight: FontWeight.bold,
                          color: AppColors.blackColor,
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
