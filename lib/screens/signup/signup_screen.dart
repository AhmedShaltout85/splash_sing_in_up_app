import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/custom_widgets/custom_button.dart';
import 'package:task_app/common_widgets/custom_widgets/custom_text.dart';
import 'package:task_app/common_widgets/resuable_widgets/resuable_widgets.dart';
import 'package:task_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:task_app/controller/employee_name_provider.dart';
import 'package:task_app/newtork_repos/remote_repo/firestore_services/firestore_db/add_new_user_to_db.dart';
import 'package:task_app/newtork_repos/remote_repo/firebase_email_password_services/firebase_api_services.dart';
import 'package:task_app/utils/app_assets.dart';
import 'package:task_app/utils/app_colors.dart';

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
                    onTap: () async {
                      if (_firstNameController.text.isNotEmpty &&
                          _lastNameController.text.isNotEmpty &&
                          _userNameController.text.isNotEmpty &&
                          _emailController.text.isNotEmpty &&
                          _passwordController.text.isNotEmpty &&
                          _confirmPasswordController.text.isNotEmpty &&
                          _passwordController.text ==
                              _confirmPasswordController.text) {
                        //create account on firebase by email and password
                        FirebaseApiSAuthServices.createUserWithEmailAndPassword(
                          emailAddress: _emailController.text.trim(),
                          password: _passwordController.text.trim(),
                        );
                        // Save user info to Firestore
                        await AddNewUserToDB.saveUser({
                          'firstName': _firstNameController.text.trim(),
                          'lastName': _lastNameController.text.trim(),
                          'displayName': _userNameController.text.trim(),
                          'email': _emailController.text.trim(),
                          'password': _passwordController.text.trim(),
                        });

                        await context
                            .read<EmployeeNameProvider>()
                            .addEmployeeName(_userNameController.text.trim());
                        ReusableToast.showToast(
                          message: 'Account created successfully!',
                          textColor: Colors.white,
                          fontSize: 16,
                          bgColor: Colors.green,
                        );
                        // Handle create account
                        navigateTo(context, LoginScreen());
                      } else {
                        ReusableToast.showToast(
                          message:
                              'Please fill all fields correctly to create an account.',
                          textColor: Colors.white,
                          fontSize: 16,
                          bgColor: Colors.red,
                        );
                      }
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
