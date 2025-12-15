import 'dart:developer';

import 'package:awesome_dialog/awesome_dialog.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/common_widgets/custom_widgets/custom_button.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_dialog.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:splash_sing_in_up_app/newtorkl_repos/remote_repo/firebase_api_services.dart';
import 'package:splash_sing_in_up_app/utils/app_assets.dart';
import 'package:splash_sing_in_up_app/utils/app_colors.dart';

import '../../common_widgets/custom_widgets/custom_logo_text.dart';
import '../../common_widgets/custom_widgets/custom_social_icon.dart';
import '../../common_widgets/custom_widgets/custom_text.dart';
import '../../common_widgets/custom_widgets/custom_text_field.dart';
import '../../common_widgets/resuable_widgets/resuable_widgets.dart';
import '../../newtorkl_repos/remote_repo/google_auth_service.dart';
import '../../utils/app_route.dart';
import '../signup/signup_screen.dart';

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
    final double iconWH = 22;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
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
                            color: AppColors.primaryColor,
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
                            color: AppColors.secondaryColor,
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),

              gap(height: 20),

              // Logo
              CustomLogoText(),

              gap(height: 15),

              // Welcome back text
              CustomText(
                text: 'Welcome back!',
                textAlign: TextAlign.center,
                fontSize: 28,
                fontWeight: FontWeight.bold,
                color: AppColors.blackColor,
              ),

              gap(height: 8),

              // Subtitle
              CustomText(
                text: 'Log in to existing LOGO account',
                textAlign: TextAlign.center,
                fontSize: 14,
                fontWeight: FontWeight.normal,
                color: AppColors.grayColor,
              ),

              gap(height: 25),

              // Username field
              CustomTextFiled(
                controller: _usernameController,
                obscureText: false,
                hintText: 'Username',
                hintStyle: TextStyle(color: AppColors.grayColor, fontSize: 15),
                prefixIcon: Image.asset(
                  AppAssets.user,
                  width: iconWH,
                  height: iconWH,
                ),
                color: AppColors.lightGrayColor,
                textInputType: TextInputType.text,
              ),

              gap(height: 15),

              // Password field
              CustomTextFiled(
                controller: _passwordController,
                obscureText: true,
                hintText: 'Password',
                hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
                prefixIcon: Image.asset(
                  AppAssets.lock,
                  width: iconWH,
                  height: iconWH,
                ),
                color: AppColors.lightGrayColor,
                textInputType: TextInputType.visiblePassword,
              ),
              gap(height: 3),

              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: MaterialButton(
                    onPressed: () {
                      //reset password
                      FirebaseApiSAuthServices.resetPassword(
                        emailAddress: _usernameController.text.trim(),
                      );
                      //  FirebaseAuth.instance.sendPasswordResetEmail(
                      //   email: _usernameController.text,
                      // );
                      // ReusableToast.showToast(
                      //   message:
                      //       'Password reset email sent successfully, please check your email',
                      //   bgColor: Colors.green,
                      //   textColor: Colors.white,
                      //   fontSize: 16,
                      // );
                      ReusableDialog.showAwesomeDialog(
                        context,
                        title: 'Success',
                        description:
                            'Password reset email sent successfully, please check your email',
                        dialogType: DialogType.success,
                      );
                    },
                    child: CustomText(
                      text: 'Forgot Password?',
                      fontSize: 14,
                      fontWeight: FontWeight.w500,
                      color: AppColors.grayColor,
                    ),
                  ),
                ),
              ),

              gap(height: 30),

              // Login button
              CustomElevatedButton(
                text: 'LOG IN',
                fontSize: 16,
                fontWeight: FontWeight.bold,
                textColor: AppColors.whiteColor,
                onTap: () {
                  // Handle login
                  if (_usernameController.text.isNotEmpty &&
                      _passwordController.text.isNotEmpty &&
                      FirebaseAuth.instance.currentUser!.emailVerified) {
                    FirebaseAuth.instance.signInWithEmailAndPassword(
                      email: _usernameController.text,
                      password: _passwordController.text,
                    );
                    ReusableToast.showToast(
                      message: 'Login successful',
                      bgColor: Colors.green,
                      textColor: Colors.white,
                      fontSize: 16,
                    );
                    navigateToReplacementNamed(context, AppRoute.homeRouteName);
                  } else {
                    FirebaseAuth.instance.currentUser!.sendEmailVerification();
                    log('Please verify your email ${_usernameController.text}');
                    ReusableDialog.showAwesomeDialog(
                      context,
                      title: 'Error',
                      description: 'Please enter valid credentials',
                      dialogType: DialogType.error,
                    );
                    log('Please enter valid credentials');
                  }
                },
                color: AppColors.primaryColor,
                height: 50,
                width: 200,
              ),

              gap(height: 30),

              // Or sign up using text
              CustomText(
                text: 'Or sign up using',
                fontSize: 15,
                fontWeight: FontWeight.normal,
                color: AppColors.grayColor,
              ),

              gap(height: 20),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  // Facebook button
                  CustomSocialIcon(iconPath: AppAssets.facebook, onTap: () {}),

                  gap(width: 24),

                  // Google button
                  CustomSocialIcon(
                    iconPath: AppAssets.google,
                    onTap: () {
                      //googleSignIn

                      // check if user is already logged in
                      if (FirebaseAuth.instance.currentUser != null) {
                        navigateToReplacementNamed(
                          context,
                          AppRoute.homeRouteName,
                        );
                      } else {
                        GoogleSignInService.signInWithGoogle();
                        ReusableToast.showToast(
                          message: 'Login successful',
                          bgColor: AppColors.greenColor,
                          textColor: AppColors.whiteColor,
                          fontSize: 16,
                        );
                      }
                    },
                  ),

                  gap(width: 24),

                  // Apple button
                  CustomSocialIcon(iconPath: AppAssets.apple, onTap: () {}),
                ],
              ),

              gap(height: 20),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CustomText(
                    text: 'Don\'t have an account? ',
                    fontSize: 16,
                    fontWeight: FontWeight.w400,
                    color: AppColors.grayColor,
                  ),
                  GestureDetector(
                    onTap: () {
                      // Navigate to sign up screen
                      navigateTo(context, SignUpScreen());
                    },
                    child: CustomText(
                      text: 'Sign Up',
                      fontSize: 16,
                      fontWeight: FontWeight.bold,
                      color: AppColors.blackColor,
                    ),
                  ),
                ],
              ),

              gap(height: 20),
            ],
          ),
        ),
      ),
    );
  }
}
