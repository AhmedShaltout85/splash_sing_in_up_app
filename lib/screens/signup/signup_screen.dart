// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:provider/provider.dart';
// import 'package:task_app/common_widgets/custom_widgets/custom_button.dart';
// import 'package:task_app/common_widgets/custom_widgets/custom_text.dart';
// import 'package:task_app/common_widgets/resuable_widgets/resuable_widgets.dart';
// import 'package:task_app/common_widgets/resuable_widgets/reusable_toast.dart';
// import 'package:task_app/controller/employee_name_provider.dart';
// import 'package:task_app/newtork_repos/remote_repo/firestore_services/firestore_db/add_new_user_to_db.dart';
// import 'package:task_app/newtork_repos/remote_repo/firestore_services/firebase_email_password_services/firebase_api_services.dart';
// import 'package:task_app/utils/app_assets.dart';
// import 'package:task_app/utils/app_colors.dart';

// import '../../common_widgets/custom_widgets/custom_textfield_signup.dart';
// import '../login/login_screen.dart';

// class SignUpScreen extends StatefulWidget {
//   const SignUpScreen({super.key});

//   @override
//   State<SignUpScreen> createState() => _SignUpScreenState();
// }

// class _SignUpScreenState extends State<SignUpScreen> {
//   final TextEditingController _firstNameController = TextEditingController();
//   final TextEditingController _lastNameController = TextEditingController();
//   final TextEditingController _userNameController = TextEditingController();
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   final TextEditingController _confirmPasswordController =
//       TextEditingController();

//   @override
//   void dispose() {
//     _firstNameController.dispose();
//     _lastNameController.dispose();
//     _userNameController.dispose();
//     _emailController.dispose();
//     _passwordController.dispose();
//     _confirmPasswordController.dispose();
//     super.dispose();
//   }

//   @override
//   Widget build(BuildContext context) {
//     final double iconWH = 24;
//     final double fontSize = 14;
//     return Scaffold(
//       backgroundColor: Color(0xFFFFFFFF),
//       body: SafeArea(
//         child: Center(
//           child: SingleChildScrollView(
//             child: Padding(
//               padding: const EdgeInsets.symmetric(
//                 horizontal: 30.0,
//                 vertical: 50.0,
//               ),
//               child: Column(
//                 mainAxisSize: MainAxisSize.min,
//                 children: [
//                   // Title
//                   CustomText(
//                     text: 'Let\'s Get Started!',
//                     fontSize: fontSize * 2,
//                     fontWeight: FontWeight.bold,
//                     color: AppColors.blackColor,
//                   ),

//                   gap(height: 8),

//                   // Subtitle
//                   CustomText(
//                     text: 'Create an account on MNZL to get all features',
//                     fontSize: fontSize,
//                     fontWeight: FontWeight.normal,
//                     color: AppColors.grayColor,
//                   ),

//                   gap(height: 35),

//                   // First Name field
//                   buildInputField(
//                     controller: _firstNameController,
//                     hintText: 'First Name',
//                     icon: Image.asset(AppAssets.user, width: iconWH),
//                   ),

//                   gap(height: 18),

//                   // Last Name field
//                   buildInputField(
//                     controller: _lastNameController,
//                     hintText: 'Last Name',
//                     icon: Image.asset(AppAssets.user, width: iconWH),
//                   ),

//                   gap(height: 18),

//                   // User Name field
//                   buildInputField(
//                     controller: _userNameController,
//                     hintText: 'User Name',
//                     icon: Image.asset(AppAssets.user, width: iconWH),
//                   ),

//                   gap(height: 18),

//                   // Email field
//                   buildInputField(
//                     controller: _emailController,
//                     hintText: 'Email',
//                     icon: Image.asset(AppAssets.mail, width: iconWH),
//                   ),

//                   gap(height: 18),

//                   // Password field
//                   buildInputField(
//                     controller: _passwordController,
//                     hintText: 'Password',
//                     icon: Image.asset(AppAssets.lock, width: iconWH),
//                     obscureText: true,
//                   ),

//                   gap(height: 18),

//                   // Confirm Password field
//                   buildInputField(
//                     controller: _confirmPasswordController,
//                     hintText: 'Confirm Password',
//                     icon: Image.asset(AppAssets.lock, width: iconWH),
//                     obscureText: true,
//                   ),

//                   gap(height: 35),

//                   // Create button
//                   CustomElevatedButton(
//                     text: 'CREATE',
//                     color: AppColors.primaryColor,
//                     textColor: AppColors.whiteColor,
//                     fontSize: fontSize + 2,
//                     height: 50,
//                     width: 200,
//                     onTap: () async {
//                       if (_firstNameController.text.isNotEmpty &&
//                           _lastNameController.text.isNotEmpty &&
//                           _userNameController.text.isNotEmpty &&
//                           _emailController.text.isNotEmpty &&
//                           _passwordController.text.isNotEmpty &&
//                           _confirmPasswordController.text.isNotEmpty &&
//                           _passwordController.text ==
//                               _confirmPasswordController.text) {
//                         //create account on firebase by email and password
//                         await FirebaseApiSAuthServices.createUserWithEmailAndPassword(
//                           emailAddress: _emailController.text.trim(),
//                           password: _passwordController.text.trim(),
//                         );
//                         // Save user info to Firestore
//                         await AddNewUserToDB.saveUser({
//                           'id': FirebaseAuth.instance.currentUser!.uid,
//                           'firstName': _firstNameController.text.trim(),
//                           'lastName': _lastNameController.text.trim(),
//                           'displayName': _userNameController.text.trim(),
//                           'email': _emailController.text.trim(),
//                           'password': _passwordController.text.trim(),
//                         });

//                         await context
//                             .read<EmployeeNameProvider>()
//                             .addEmployeeName(_userNameController.text.trim());
//                         ReusableToast.showToast(
//                           message: 'Account created successfully!',
//                           textColor: Colors.white,
//                           fontSize: 16,
//                           bgColor: Colors.green,
//                         );
//                         // Handle create account
//                         navigateTo(context, LoginScreen());
//                       } else {
//                         ReusableToast.showToast(
//                           message:
//                               'Please fill all fields correctly to create an account.',
//                           textColor: Colors.white,
//                           fontSize: 16,
//                           bgColor: Colors.red,
//                         );
//                       }
//                     },
//                   ),

//                   gap(height: 25),

//                   // Login link
//                   Row(
//                     mainAxisAlignment: MainAxisAlignment.center,
//                     children: [
//                       CustomText(
//                         text: 'Already have an account? ',
//                         fontSize: fontSize,
//                         fontWeight: FontWeight.normal,
//                         color: AppColors.grayColor,
//                       ),
//                       GestureDetector(
//                         onTap: () {
//                           // Handle login
//                           navigateTo(context, LoginScreen());
//                         },
//                         child: CustomText(
//                           text: 'Login here',
//                           fontSize: fontSize,
//                           fontWeight: FontWeight.bold,
//                           color: AppColors.blackColor,
//                         ),
//                       ),
//                     ],
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//     );
//   }
// }

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/custom_widgets/custom_button.dart';
import 'package:task_app/common_widgets/custom_widgets/custom_text.dart';
import 'package:task_app/common_widgets/resuable_widgets/resuable_widgets.dart';
import 'package:task_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:task_app/controller/employee_name_provider.dart';
import 'package:task_app/controller/theme_provider.dart';
import 'package:task_app/newtork_repos/remote_repo/firestore_services/firestore_db/add_new_user_to_db.dart';
import 'package:task_app/newtork_repos/remote_repo/firestore_services/firebase_email_password_services/firebase_api_services.dart';
import 'package:task_app/utils/app_assets.dart';

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

  bool _isLoading = false;

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
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;
    final colorScheme = Theme.of(context).colorScheme;

    final double iconWH = 24;
    final double fontSize = 14;

    return Scaffold(
      backgroundColor: isDark ? colorScheme.surface : const Color(0xFFFFFFFF),
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
                  // Logo or Icon (optional)
                  Container(
                    padding: const EdgeInsets.all(20),
                    decoration: BoxDecoration(
                      color: colorScheme.primary.withOpacity(0.1),
                      shape: BoxShape.circle,
                    ),
                    child: Icon(
                      Icons.person_add_rounded,
                      size: 60,
                      color: colorScheme.primary,
                    ),
                  ),

                  gap(height: 24),

                  // Title
                  Text(
                    'Let\'s Get Started!',
                    style: TextStyle(
                      fontSize: fontSize * 2,
                      fontWeight: FontWeight.bold,
                      color: isDark ? Colors.white : Colors.black87,
                    ),
                  ),

                  gap(height: 8),

                  // Subtitle
                  Text(
                    'Create an account on MNZL to get all features',
                    style: TextStyle(
                      fontSize: fontSize,
                      fontWeight: FontWeight.normal,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                    textAlign: TextAlign.center,
                  ),

                  gap(height: 35),

                  // First Name field
                  _buildThemedInputField(
                    controller: _firstNameController,
                    hintText: 'First Name',
                    icon: Icons.person_outline,
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),

                  gap(height: 18),

                  // Last Name field
                  _buildThemedInputField(
                    controller: _lastNameController,
                    hintText: 'Last Name',
                    icon: Icons.person_outline,
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),

                  gap(height: 18),

                  // User Name field
                  _buildThemedInputField(
                    controller: _userNameController,
                    hintText: 'User Name',
                    icon: Icons.badge_outlined,
                    isDark: isDark,
                    colorScheme: colorScheme,
                  ),

                  gap(height: 18),

                  // Email field
                  _buildThemedInputField(
                    controller: _emailController,
                    hintText: 'Email',
                    icon: Icons.email_outlined,
                    isDark: isDark,
                    colorScheme: colorScheme,
                    keyboardType: TextInputType.emailAddress,
                  ),

                  gap(height: 18),

                  // Password field
                  _buildThemedInputField(
                    controller: _passwordController,
                    hintText: 'Password',
                    icon: Icons.lock_outline,
                    isDark: isDark,
                    colorScheme: colorScheme,
                    obscureText: true,
                  ),

                  gap(height: 18),

                  // Confirm Password field
                  _buildThemedInputField(
                    controller: _confirmPasswordController,
                    hintText: 'Confirm Password',
                    icon: Icons.lock_outline,
                    isDark: isDark,
                    colorScheme: colorScheme,
                    obscureText: true,
                  ),

                  gap(height: 35),

                  // Create button
                  SizedBox(
                    width: double.infinity,
                    height: 54,
                    child: ElevatedButton(
                      onPressed: _isLoading
                          ? null
                          : () async {
                              if (_firstNameController.text.isNotEmpty &&
                                  _lastNameController.text.isNotEmpty &&
                                  _userNameController.text.isNotEmpty &&
                                  _emailController.text.isNotEmpty &&
                                  _passwordController.text.isNotEmpty &&
                                  _confirmPasswordController.text.isNotEmpty &&
                                  _passwordController.text ==
                                      _confirmPasswordController.text) {
                                setState(() => _isLoading = true);

                                try {
                                  // Create account on firebase
                                  await FirebaseApiSAuthServices.createUserWithEmailAndPassword(
                                    emailAddress: _emailController.text.trim(),
                                    password: _passwordController.text.trim(),
                                  );

                                  // Save user info to Firestore
                                  await AddNewUserToDB.saveUser({
                                    'id':
                                        FirebaseAuth.instance.currentUser!.uid,
                                    'firstName': _firstNameController.text
                                        .trim(),
                                    'lastName': _lastNameController.text.trim(),
                                    'displayName': _userNameController.text
                                        .trim(),
                                    'email': _emailController.text.trim(),
                                    'password': _passwordController.text.trim(),
                                  });

                                  await context
                                      .read<EmployeeNameProvider>()
                                      .addEmployeeName(
                                        _userNameController.text.trim(),
                                      );

                                  if (context.mounted) {
                                    ReusableToast.showToast(
                                      message: 'Account created successfully!',
                                      textColor: Colors.white,
                                      fontSize: 16,
                                      bgColor: Colors.green,
                                    );
                                    navigateTo(context, const LoginScreen());
                                  }
                                } catch (e) {
                                  if (context.mounted) {
                                    ReusableToast.showToast(
                                      message: 'Error: ${e.toString()}',
                                      textColor: Colors.white,
                                      fontSize: 16,
                                      bgColor: Colors.red,
                                    );
                                  }
                                } finally {
                                  if (mounted) {
                                    setState(() => _isLoading = false);
                                  }
                                }
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
                      style: ElevatedButton.styleFrom(
                        backgroundColor: colorScheme.primary,
                        foregroundColor: isDark ? Colors.black87 : Colors.white,
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(12),
                        ),
                        elevation: 2,
                      ),
                      child: _isLoading
                          ? SizedBox(
                              width: 24,
                              height: 24,
                              child: CircularProgressIndicator(
                                strokeWidth: 2.5,
                                color: isDark ? Colors.black87 : Colors.white,
                              ),
                            )
                          : Text(
                              'CREATE ACCOUNT',
                              style: TextStyle(
                                fontSize: fontSize + 2,
                                fontWeight: FontWeight.bold,
                                letterSpacing: 0.5,
                              ),
                            ),
                    ),
                  ),

                  gap(height: 25),

                  // Login link
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        'Already have an account? ',
                        style: TextStyle(
                          fontSize: fontSize,
                          fontWeight: FontWeight.normal,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          navigateTo(context, const LoginScreen());
                        },
                        child: Text(
                          'Login here',
                          style: TextStyle(
                            fontSize: fontSize,
                            fontWeight: FontWeight.bold,
                            color: colorScheme.primary,
                            decoration: TextDecoration.underline,
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

  Widget _buildThemedInputField({
    required TextEditingController controller,
    required String hintText,
    required IconData icon,
    required bool isDark,
    required ColorScheme colorScheme,
    bool obscureText = false,
    TextInputType? keyboardType,
  }) {
    return Container(
      decoration: BoxDecoration(
        color: isDark ? colorScheme.surface : Colors.white,
        borderRadius: BorderRadius.circular(12),
        border: isDark
            ? Border.all(color: Colors.grey.shade800, width: 1)
            : null,
        boxShadow: isDark
            ? null
            : [
                BoxShadow(
                  color: Colors.black.withOpacity(0.05),
                  blurRadius: 10,
                  offset: const Offset(0, 2),
                ),
              ],
      ),
      child: TextField(
        controller: controller,
        obscureText: obscureText,
        keyboardType: keyboardType,
        style: TextStyle(
          color: isDark ? Colors.white : Colors.black87,
          fontSize: 16,
        ),
        decoration: InputDecoration(
          hintText: hintText,
          hintStyle: TextStyle(
            color: isDark ? Colors.grey[600] : Colors.grey[400],
          ),
          prefixIcon: Icon(icon, color: colorScheme.primary, size: 22),
          border: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          enabledBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide.none,
          ),
          focusedBorder: OutlineInputBorder(
            borderRadius: BorderRadius.circular(12),
            borderSide: BorderSide(color: colorScheme.primary, width: 2),
          ),
          filled: true,
          fillColor: isDark
              ? colorScheme.surface.withOpacity(0.5)
              : Colors.white,
          contentPadding: const EdgeInsets.symmetric(
            horizontal: 16,
            vertical: 16,
          ),
        ),
      ),
    );
  }
}
