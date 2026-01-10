// import 'dart:developer';

// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:task_app/common_widgets/custom_widgets/custom_button.dart';
// import 'package:task_app/common_widgets/resuable_widgets/reusable_toast.dart';
// // import 'package:task_app/newtork_repos/remote_repo/facebook_auth_service.dart';
// import 'package:task_app/newtork_repos/remote_repo/firestore_services/firebase_email_password_services/firebase_api_services.dart';
// import 'package:task_app/utils/app_assets.dart';
// import 'package:task_app/utils/app_colors.dart';

// import '../../common_widgets/custom_widgets/custom_logo_text.dart';
// import '../../common_widgets/custom_widgets/custom_social_icon.dart';
// import '../../common_widgets/custom_widgets/custom_text.dart';
// import '../../common_widgets/custom_widgets/custom_text_field.dart';
// import '../../common_widgets/resuable_widgets/resuable_widgets.dart';
// import '../signup/signup_screen.dart';

// class LoginScreen extends StatefulWidget {
//   const LoginScreen({super.key});

//   @override
//   State<LoginScreen> createState() => _LoginScreenState();
// }

// class _LoginScreenState extends State<LoginScreen> {
//   final TextEditingController _emailController = TextEditingController();
//   final TextEditingController _passwordController = TextEditingController();
//   bool _isLoading = false;

//   @override
//   void dispose() {
//     _emailController.dispose();
//     _passwordController.dispose();
//     super.dispose();
//   }

//   // Email validation helper
//   bool _isValidEmail(String email) {
//     return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
//   }

//   // Login method - FIXED VERSION
//   // Future<void> _handleLogin() async {
//   //   String email = _emailController.text.trim();
//   //   String password = _passwordController.text.trim();

//   //   // Validation
//   //   if (email.isEmpty || password.isEmpty) {
//   //     ReusableToast.showToast(
//   //       message: 'Please enter both email and password',
//   //       bgColor: AppColors.redColor,
//   //       textColor: AppColors.whiteColor,
//   //       fontSize: 16,
//   //     );
//   //     return;
//   //   }

//   //   if (!_isValidEmail(email)) {
//   //     ReusableToast.showToast(
//   //       message: 'Please enter a valid email address',
//   //       bgColor: AppColors.redColor,
//   //       textColor: AppColors.whiteColor,
//   //       fontSize: 16,
//   //     );
//   //     return;
//   //   }

//   //   setState(() {
//   //     _isLoading = true;
//   //   });

//   //   try {
//   //     // Attempt to sign in
//   //     UserCredential userCredential = await FirebaseAuth.instance
//   //         .signInWithEmailAndPassword(email: email, password: password);

//   //     // Get the signed-in user
//   //     User? user = userCredential.user;

//   //     // Check if user exists (should always be true after successful sign in)
//   //     if (user == null) {
//   //       throw Exception('User authentication failed');
//   //     }

//   //     // Optional: Check if email is verified
//   //     // Uncomment this section if you want to enforce email verification
//   //     /*
//   //   if (!user.emailVerified) {
//   //     // Email not verified
//   //     await FirebaseAuth.instance.signOut();

//   //     if (mounted) {
//   //       ReusableToast.showToast(
//   //         message: 'Please verify your email before logging in. Check your inbox.',
//   //         bgColor: AppColors.orangeColor,
//   //         textColor: AppColors.whiteColor,
//   //         fontSize: 16,
//   //       );
//   //     }
//   //     setState(() {
//   //       _isLoading = false;
//   //     });
//   //     return;
//   //   }
//   //   */

//   //     // Success - Determine user role and navigate
//   //     if (mounted) {
//   //       ReusableToast.showToast(
//   //         message: 'Login successful',
//   //         bgColor: Colors.green,
//   //         textColor: Colors.white,
//   //         fontSize: 16,
//   //       );

//   //       // Check if user is admin based on email
//   //       bool isAdmin = _isAdminUser(user.email);

//   //       if (isAdmin) {
//   //         navigateToNamed(context, AppRoute.taskRouteName);
//   //       } else {
//   //         navigateToNamed(context, AppRoute.userTaskRouteName);
//   //       }
//   //     }
//   //   } on FirebaseAuthException catch (e) {
//   //     String errorMessage;

//   //     switch (e.code) {
//   //       case 'user-not-found':
//   //         errorMessage = 'No user found with this email';
//   //         break;
//   //       case 'wrong-password':
//   //         errorMessage = 'Incorrect password';
//   //         break;
//   //       case 'invalid-email':
//   //         errorMessage = 'Invalid email address';
//   //         break;
//   //       case 'user-disabled':
//   //         errorMessage = 'This account has been disabled';
//   //         break;
//   //       case 'too-many-requests':
//   //         errorMessage = 'Too many attempts. Please try again later';
//   //         break;
//   //       case 'invalid-credential':
//   //         errorMessage = 'Invalid email or password';
//   //         break;
//   //       case 'network-request-failed':
//   //         errorMessage = 'Network error. Please check your connection';
//   //         break;
//   //       default:
//   //         errorMessage = 'Login failed: ${e.message ?? "Unknown error"}';
//   //     }

//   //     if (mounted) {
//   //       ReusableToast.showToast(
//   //         message: errorMessage,
//   //         bgColor: AppColors.redColor,
//   //         textColor: AppColors.whiteColor,
//   //         fontSize: 16,
//   //       );
//   //     }

//   //     log('Login error: ${e.code} - ${e.message}');
//   //   } catch (e) {
//   //     if (mounted) {
//   //       ReusableToast.showToast(
//   //         message: 'An unexpected error occurred. Please try again.',
//   //         bgColor: AppColors.redColor,
//   //         textColor: AppColors.whiteColor,
//   //         fontSize: 16,
//   //       );
//   //     }

//   //     log('Unexpected error during login: $e');
//   //   } finally {
//   //     if (mounted) {
//   //       setState(() {
//   //         _isLoading = false;
//   //       });
//   //     }
//   //   }
//   // }
//   // The login method should just show success toast:
//   Future<void> _handleLogin() async {
//     String email = _emailController.text.trim();
//     String password = _passwordController.text.trim();

//     // ... your validation code ...
//     if (email.isEmpty || password.isEmpty) {
//       ReusableToast.showToast(
//         message: 'Please enter both email and password',
//         bgColor: AppColors.redColor,
//         textColor: AppColors.whiteColor,
//         fontSize: 16,
//       );
//       return;
//     }

//     if (!_isValidEmail(email)) {
//       ReusableToast.showToast(
//         message: 'Please enter a valid email address',
//         bgColor: AppColors.redColor,
//         textColor: AppColors.whiteColor,
//         fontSize: 16,
//       );
//       return;
//     }

//     setState(() {
//       _isLoading = true;
//     });

//     try {
//       UserCredential userCredential = await FirebaseAuth.instance
//           .signInWithEmailAndPassword(email: email, password: password);

//       User? user = userCredential.user;

//       if (user == null) {
//         throw Exception('User authentication failed');
//       }

//       // Success - Just show toast, AuthWrapper handles navigation
//       if (mounted) {
//         ReusableToast.showToast(
//           message: 'Login successful',
//           bgColor: Colors.green,
//           textColor: Colors.white,
//           fontSize: 16,
//         );

//         // AuthWrapper will automatically detect auth state change
//         // and navigate to appropriate screen - NO MANUAL NAVIGATION NEEDED
//       }
//     } on FirebaseAuthException catch (e) {
//       // ... your error handling ...
//       String errorMessage;

//       switch (e.code) {
//         case 'user-not-found':
//           errorMessage = 'No user found with this email';
//           break;
//         case 'wrong-password':
//           errorMessage = 'Incorrect password';
//           break;
//         case 'invalid-email':
//           errorMessage = 'Invalid email address';
//           break;
//         case 'user-disabled':
//           errorMessage = 'This account has been disabled';
//           break;
//         case 'too-many-requests':
//           errorMessage = 'Too many attempts. Please try again later';
//           break;
//         case 'invalid-credential':
//           errorMessage = 'Invalid email or password';
//           break;
//         case 'network-request-failed':
//           errorMessage = 'Network error. Please check your connection';
//           break;
//         default:
//           errorMessage = 'Login failed: ${e.message ?? "Unknown error"}';
//       }

//       if (mounted) {
//         ReusableToast.showToast(
//           message: errorMessage,
//           bgColor: AppColors.redColor,
//           textColor: AppColors.whiteColor,
//           fontSize: 16,
//         );
//       }

//       log('Login error: ${e.code} - ${e.message}');
//     } catch (e) {
//       if (mounted) {
//         ReusableToast.showToast(
//           message: 'An unexpected error occurred. Please try again.',
//           bgColor: AppColors.redColor,
//           textColor: AppColors.whiteColor,
//           fontSize: 16,
//         );
//       }

//       log('Unexpected error during login: $e');
//     } finally {
//       if (mounted) {
//         setState(() {
//           _isLoading = false;
//         });
//       }
//     }
//   }

//   // Helper method to check if user is admin
//   // bool _isAdminUser(String? email) {
//   //   if (email == null || email.isEmpty) return false;

//   //   // Get username part before @
//   //   final username = email.split('@').first.toLowerCase();

//   //   // Check if username is 'admin' or matches your admin criteria
//   //   return username == 'admin';

//   //   // Alternative: Check against a list of admin emails
//   //   // const adminEmails = ['admin@gmail.com', 'admin@example.com'];
//   //   // return adminEmails.contains(email.toLowerCase());
//   // }

//   @override
//   Widget build(BuildContext context) {
//     final double iconWH = 22;
//     return Scaffold(
//       backgroundColor: AppColors.whiteColor,
//       body: SafeArea(
//         child: SingleChildScrollView(
//           child: Column(
//             children: [
//               // Decorative shapes at the top
//               SizedBox(
//                 height: 120,
//                 width: double.infinity,
//                 child: Stack(
//                   clipBehavior: Clip.none,
//                   children: [
//                     // Light blue shape (left side) - 8CD6F7
//                     Positioned(
//                       left: 40,
//                       top: -130,
//                       child: Transform.rotate(
//                         angle: -15, // -15 degrees
//                         child: Container(
//                           height: 172,
//                           width: 286,
//                           decoration: BoxDecoration(
//                             color: AppColors.primaryColor,
//                             borderRadius: BorderRadius.circular(26),
//                           ),
//                         ),
//                       ),
//                     ),
//                     // Gray-blue shape (right side) - 7A9EAE
//                     Positioned(
//                       right: 220,
//                       top: -110,
//                       child: Transform.rotate(
//                         angle: -15, // -15 degrees
//                         child: Container(
//                           height: 171,
//                           width: 307,
//                           decoration: BoxDecoration(
//                             color: AppColors.secondaryColor,
//                             borderRadius: BorderRadius.circular(26),
//                           ),
//                         ),
//                       ),
//                     ),
//                   ],
//                 ),
//               ),

//               gap(height: 20),

//               // Logo
//               CustomLogoText(),

//               gap(height: 15),

//               // Welcome back text
//               CustomText(
//                 text: 'Welcome back!',
//                 textAlign: TextAlign.center,
//                 fontSize: 28,
//                 fontWeight: FontWeight.bold,
//                 color: AppColors.blackColor,
//               ),

//               gap(height: 8),

//               // Subtitle
//               CustomText(
//                 text: 'Log in to existing LOGO account',
//                 textAlign: TextAlign.center,
//                 fontSize: 14,
//                 fontWeight: FontWeight.normal,
//                 color: AppColors.grayColor,
//               ),

//               gap(height: 25),

//               // Email field (changed from Username)
//               CustomTextFiled(
//                 controller: _emailController,
//                 obscureText: false,
//                 hintText: 'Email',
//                 hintStyle: TextStyle(color: AppColors.grayColor, fontSize: 15),
//                 prefixIcon: Image.asset(
//                   AppAssets.user,
//                   width: iconWH,
//                   height: iconWH,
//                 ),
//                 color: AppColors.lightGrayColor,
//                 textInputType: TextInputType.emailAddress,
//               ),

//               gap(height: 15),

//               // Password field
//               CustomTextFiled(
//                 controller: _passwordController,
//                 obscureText: true,
//                 hintText: 'Password',
//                 hintStyle: TextStyle(color: Colors.grey[600], fontSize: 15),
//                 prefixIcon: Image.asset(
//                   AppAssets.lock,
//                   width: iconWH,
//                   height: iconWH,
//                 ),
//                 color: AppColors.lightGrayColor,
//                 textInputType: TextInputType.visiblePassword,
//               ),
//               gap(height: 3),

//               Padding(
//                 padding: const EdgeInsets.symmetric(horizontal: 30.0),
//                 child: Align(
//                   alignment: Alignment.centerRight,
//                   child: MaterialButton(
//                     onPressed: () async {
//                       String email = _emailController.text.trim();

//                       if (email.isEmpty) {
//                         ReusableToast.showToast(
//                           message: 'Please enter your email address',
//                           bgColor: AppColors.redColor,
//                           textColor: AppColors.whiteColor,
//                           fontSize: 16,
//                         );
//                         return;
//                       }

//                       if (!_isValidEmail(email)) {
//                         ReusableToast.showToast(
//                           message: 'Please enter a valid email address',
//                           bgColor: AppColors.redColor,
//                           textColor: AppColors.whiteColor,
//                           fontSize: 16,
//                         );
//                         return;
//                       }

//                       try {
//                         await FirebaseApiSAuthServices.resetPassword(
//                           emailAddress: email,
//                         );

//                         if (mounted) {
//                           ReusableToast.showToast(
//                             message:
//                                 'Password reset email sent successfully, please check your email',
//                             bgColor: AppColors.greenColor,
//                             textColor: AppColors.whiteColor,
//                             fontSize: 16,
//                           );
//                         }
//                       } catch (e) {
//                         if (mounted) {
//                           ReusableToast.showToast(
//                             message:
//                                 'Failed to send reset email. Please try again.',
//                             bgColor: AppColors.redColor,
//                             textColor: AppColors.whiteColor,
//                             fontSize: 16,
//                           );
//                         }
//                         log('Password reset error: $e');
//                       }
//                     },
//                     child: CustomText(
//                       text: 'Forgot Password?',
//                       fontSize: 14,
//                       fontWeight: FontWeight.w500,
//                       color: AppColors.grayColor,
//                     ),
//                   ),
//                 ),
//               ),

//               gap(height: 30),

//               // Login button
//               CustomElevatedButton(
//                 text: _isLoading ? 'LOGGING IN...' : 'LOG IN',
//                 fontSize: 16,
//                 fontWeight: FontWeight.bold,
//                 textColor: AppColors.whiteColor,
//                 onTap: _isLoading ? () {} : _handleLogin,
//                 color: _isLoading
//                     ? AppColors.grayColor
//                     : AppColors.primaryColor,
//                 height: 50,
//                 width: 200,
//               ),

//               gap(height: 30),

//               // Or sign up using text
//               CustomText(
//                 text: 'Or sign up using',
//                 fontSize: 15,
//                 fontWeight: FontWeight.normal,
//                 color: AppColors.grayColor,
//               ),

//               gap(height: 20),

//               // Social login buttons
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   // Facebook button
//                   CustomSocialIcon(
//                     iconPath: AppAssets.facebook,
//                     onTap: () async {
//                       // Check if user is already logged in
//                       //   if (FirebaseAuth.instance.currentUser != null) {
//                       //     navigateToReplacementNamed(
//                       //       context,
//                       //       AppRoute.homeRouteName,
//                       //     );
//                       //     return;
//                       //   }

//                       //   try {
//                       //     await FacebookAuthService.login();

//                       //     if (FirebaseAuth.instance.currentUser != null &&
//                       //         mounted) {
//                       //       ReusableToast.showToast(
//                       //         message: 'Login successful',
//                       //         bgColor: AppColors.greenColor,
//                       //         textColor: AppColors.whiteColor,
//                       //         fontSize: 16,
//                       //       );

//                       //       navigateToReplacementNamed(
//                       //         context,
//                       //         AppRoute.homeRouteName,
//                       //       );
//                       //     }
//                       //   } catch (e) {
//                       //     log('Error logging in with Facebook: $e');
//                       //     if (mounted) {
//                       //       ReusableToast.showToast(
//                       //         message: 'Failed to login with Facebook',
//                       //         bgColor: AppColors.redColor,
//                       //         textColor: AppColors.whiteColor,
//                       //         fontSize: 16,
//                       //       );
//                       //     }
//                       //   }
//                     },
//                   ),

//                   gap(width: 24),

//                   // Google button
//                   CustomSocialIcon(
//                     iconPath: AppAssets.google,
//                     onTap: () async {
//                       // Check if user is already logged in
//                       //   if (FirebaseAuth.instance.currentUser != null) {
//                       //     navigateToReplacementNamed(
//                       //       context,
//                       //       AppRoute.homeRouteName,
//                       //     );
//                       //     return;
//                       //   }

//                       //   try {
//                       //     // await GoogleSignInService.signInWithGoogle();

//                       //     if (FirebaseAuth.instance.currentUser != null &&
//                       //         mounted) {
//                       //       ReusableToast.showToast(
//                       //         message: 'Login successful',
//                       //         bgColor: AppColors.greenColor,
//                       //         textColor: AppColors.whiteColor,
//                       //         fontSize: 16,
//                       //       );

//                       //       navigateToReplacementNamed(
//                       //         context,
//                       //         AppRoute.homeRouteName,
//                       //       );
//                       //     }
//                       //   } catch (e) {
//                       //     log('Error logging in with Google: $e');
//                       //     if (mounted) {
//                       //       ReusableToast.showToast(
//                       //         message: 'Failed to login with Google',
//                       //         bgColor: AppColors.redColor,
//                       //         textColor: AppColors.whiteColor,
//                       //         fontSize: 16,
//                       //       );
//                       //     }
//                       //   }
//                     },
//                   ),

//                   gap(width: 24),

//                   // Apple button
//                   CustomSocialIcon(
//                     iconPath: AppAssets.apple,
//                     onTap: () {
//                       // TODO: Implement Apple Sign In
//                       ReusableToast.showToast(
//                         message: 'Apple Sign In coming soon',
//                         bgColor: AppColors.grayColor,
//                         textColor: AppColors.whiteColor,
//                         fontSize: 16,
//                       );
//                     },
//                   ),
//                 ],
//               ),

//               gap(height: 20),

//               // Sign up link
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   CustomText(
//                     text: 'Don\'t have an account? ',
//                     fontSize: 16,
//                     fontWeight: FontWeight.w400,
//                     color: AppColors.grayColor,
//                   ),
//                   GestureDetector(
//                     onTap: () {
//                       // Navigate to sign up screen
//                       navigateTo(context, SignUpScreen());
//                     },
//                     child: CustomText(
//                       text: 'Sign Up',
//                       fontSize: 16,
//                       fontWeight: FontWeight.bold,
//                       color: AppColors.blackColor,
//                     ),
//                   ),
//                 ],
//               ),

//               gap(height: 20),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:task_app/controller/theme_provider.dart';
import 'package:task_app/newtork_repos/remote_repo/firestore_services/firebase_email_password_services/firebase_api_services.dart';
import 'package:task_app/utils/app_assets.dart';
import 'package:task_app/utils/app_colors.dart';

import '../../common_widgets/resuable_widgets/resuable_widgets.dart';
import '../signup/signup_screen.dart';

class LoginScreen extends StatefulWidget {
  const LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  bool _isLoading = false;
  bool _obscurePassword = true;

  @override
  void dispose() {
    _emailController.dispose();
    _passwordController.dispose();
    super.dispose();
  }

  bool _isValidEmail(String email) {
    return RegExp(r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$').hasMatch(email);
  }

  Future<void> _handleLogin() async {
    String email = _emailController.text.trim();
    String password = _passwordController.text.trim();

    if (email.isEmpty || password.isEmpty) {
      ReusableToast.showToast(
        message: 'Please enter both email and password',
        bgColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        fontSize: 16,
      );
      return;
    }

    if (!_isValidEmail(email)) {
      ReusableToast.showToast(
        message: 'Please enter a valid email address',
        bgColor: AppColors.redColor,
        textColor: AppColors.whiteColor,
        fontSize: 16,
      );
      return;
    }

    setState(() {
      _isLoading = true;
    });

    try {
      UserCredential userCredential = await FirebaseAuth.instance
          .signInWithEmailAndPassword(email: email, password: password);

      User? user = userCredential.user;

      if (user == null) {
        throw Exception('User authentication failed');
      }

      if (mounted) {
        ReusableToast.showToast(
          message: 'Login successful',
          bgColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    } on FirebaseAuthException catch (e) {
      String errorMessage;

      switch (e.code) {
        case 'user-not-found':
          errorMessage = 'No user found with this email';
          break;
        case 'wrong-password':
          errorMessage = 'Incorrect password';
          break;
        case 'invalid-email':
          errorMessage = 'Invalid email address';
          break;
        case 'user-disabled':
          errorMessage = 'This account has been disabled';
          break;
        case 'too-many-requests':
          errorMessage = 'Too many attempts. Please try again later';
          break;
        case 'invalid-credential':
          errorMessage = 'Invalid email or password';
          break;
        case 'network-request-failed':
          errorMessage = 'Network error. Please check your connection';
          break;
        default:
          errorMessage = 'Login failed: ${e.message ?? "Unknown error"}';
      }

      if (mounted) {
        ReusableToast.showToast(
          message: errorMessage,
          bgColor: AppColors.redColor,
          textColor: AppColors.whiteColor,
          fontSize: 16,
        );
      }

      log('Login error: ${e.code} - ${e.message}');
    } catch (e) {
      if (mounted) {
        ReusableToast.showToast(
          message: 'An unexpected error occurred. Please try again.',
          bgColor: AppColors.redColor,
          textColor: AppColors.whiteColor,
          fontSize: 16,
        );
      }

      log('Unexpected error during login: $e');
    } finally {
      if (mounted) {
        setState(() {
          _isLoading = false;
        });
      }
    }
  }

  @override
  Widget build(BuildContext context) {
    final themeProvider = Provider.of<ThemeProvider>(context);
    final isDark = themeProvider.isDark;
    final colorScheme = Theme.of(context).colorScheme;

    return Scaffold(
      backgroundColor: isDark ? colorScheme.surface : Colors.white,
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
                    Positioned(
                      left: 40,
                      top: -130,
                      child: Transform.rotate(
                        angle: -15,
                        child: Container(
                          height: 172,
                          width: 286,
                          decoration: BoxDecoration(
                            color: colorScheme.primary,
                            borderRadius: BorderRadius.circular(26),
                          ),
                        ),
                      ),
                    ),
                    Positioned(
                      right: 220,
                      top: -110,
                      child: Transform.rotate(
                        angle: -15,
                        child: Container(
                          height: 171,
                          width: 307,
                          decoration: BoxDecoration(
                            color: colorScheme.secondary,
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
              Container(
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: colorScheme.primary.withOpacity(0.1),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.task_alt,
                  size: 60,
                  color: colorScheme.primary,
                ),
              ),

              gap(height: 15),

              // Welcome back text
              Text(
                'Welcome back!',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: isDark ? Colors.white : Colors.black87,
                ),
              ),

              gap(height: 8),

              // Subtitle
              Text(
                'Log in to your existing account',
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.normal,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),

              gap(height: 25),

              // Email field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
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
                    controller: _emailController,
                    keyboardType: TextInputType.emailAddress,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Email',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                      prefixIcon: Icon(
                        Icons.email_outlined,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
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
                ),
              ),

              gap(height: 15),

              // Password field
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Container(
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
                    controller: _passwordController,
                    obscureText: _obscurePassword,
                    style: TextStyle(
                      color: isDark ? Colors.white : Colors.black87,
                      fontSize: 16,
                    ),
                    decoration: InputDecoration(
                      hintText: 'Password',
                      hintStyle: TextStyle(
                        color: isDark ? Colors.grey[600] : Colors.grey[400],
                      ),
                      prefixIcon: Icon(
                        Icons.lock_outline,
                        color: colorScheme.primary,
                        size: 22,
                      ),
                      suffixIcon: IconButton(
                        icon: Icon(
                          _obscurePassword
                              ? Icons.visibility_off
                              : Icons.visibility,
                          color: isDark ? Colors.grey[400] : Colors.grey[600],
                        ),
                        onPressed: () {
                          setState(() {
                            _obscurePassword = !_obscurePassword;
                          });
                        },
                      ),
                      border: OutlineInputBorder(
                        borderRadius: BorderRadius.circular(12),
                        borderSide: BorderSide.none,
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
                ),
              ),

              gap(height: 3),

              // Forgot password
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: Align(
                  alignment: Alignment.centerRight,
                  child: TextButton(
                    onPressed: () async {
                      String email = _emailController.text.trim();

                      if (email.isEmpty) {
                        ReusableToast.showToast(
                          message: 'Please enter your email address',
                          bgColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                          fontSize: 16,
                        );
                        return;
                      }

                      if (!_isValidEmail(email)) {
                        ReusableToast.showToast(
                          message: 'Please enter a valid email address',
                          bgColor: AppColors.redColor,
                          textColor: AppColors.whiteColor,
                          fontSize: 16,
                        );
                        return;
                      }

                      try {
                        await FirebaseApiSAuthServices.resetPassword(
                          emailAddress: email,
                        );

                        if (mounted) {
                          ReusableToast.showToast(
                            message:
                                'Password reset email sent successfully, please check your email',
                            bgColor: AppColors.greenColor,
                            textColor: AppColors.whiteColor,
                            fontSize: 16,
                          );
                        }
                      } catch (e) {
                        if (mounted) {
                          ReusableToast.showToast(
                            message:
                                'Failed to send reset email. Please try again.',
                            bgColor: AppColors.redColor,
                            textColor: AppColors.whiteColor,
                            fontSize: 16,
                          );
                        }
                        log('Password reset error: $e');
                      }
                    },
                    child: Text(
                      'Forgot Password?',
                      style: TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w500,
                        color: colorScheme.primary,
                      ),
                    ),
                  ),
                ),
              ),

              gap(height: 30),

              // Login button
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30.0),
                child: SizedBox(
                  width: double.infinity,
                  height: 54,
                  child: ElevatedButton(
                    onPressed: _isLoading ? null : _handleLogin,
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
                        : const Text(
                            'LOG IN',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.bold,
                              letterSpacing: 0.5,
                            ),
                          ),
                  ),
                ),
              ),

              gap(height: 30),

              // Or sign up using text
              Text(
                'Or sign up using',
                style: TextStyle(
                  fontSize: 15,
                  fontWeight: FontWeight.normal,
                  color: isDark ? Colors.grey[400] : Colors.grey[600],
                ),
              ),

              gap(height: 20),

              // Social login buttons
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildSocialButton(
                    icon: Icons.facebook,
                    color: const Color(0xFF1877F2),
                    isDark: isDark,
                    colorScheme: colorScheme,
                    onTap: () {
                      ReusableToast.showToast(
                        message: 'Facebook Sign In coming soon',
                        bgColor: AppColors.grayColor,
                        textColor: AppColors.whiteColor,
                        fontSize: 16,
                      );
                    },
                  ),
                  gap(width: 24),
                  _buildSocialButton(
                    icon: Icons.g_mobiledata,
                    color: const Color(0xFFDB4437),
                    isDark: isDark,
                    colorScheme: colorScheme,
                    onTap: () {
                      ReusableToast.showToast(
                        message: 'Google Sign In coming soon',
                        bgColor: AppColors.grayColor,
                        textColor: AppColors.whiteColor,
                        fontSize: 16,
                      );
                    },
                  ),
                  gap(width: 24),
                  _buildSocialButton(
                    icon: Icons.apple,
                    color: isDark ? Colors.white : Colors.black,
                    isDark: isDark,
                    colorScheme: colorScheme,
                    onTap: () {
                      ReusableToast.showToast(
                        message: 'Apple Sign In coming soon',
                        bgColor: AppColors.grayColor,
                        textColor: AppColors.whiteColor,
                        fontSize: 16,
                      );
                    },
                  ),
                ],
              ),

              gap(height: 20),

              // Sign up link
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Don\'t have an account? ',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w400,
                      color: isDark ? Colors.grey[400] : Colors.grey[600],
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      navigateTo(context, const SignUpScreen());
                    },
                    child: Text(
                      'Sign Up',
                      style: TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                        color: colorScheme.primary,
                        decoration: TextDecoration.underline,
                      ),
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

  Widget _buildSocialButton({
    required IconData icon,
    required Color color,
    required bool isDark,
    required ColorScheme colorScheme,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(12),
      child: Container(
        padding: const EdgeInsets.all(12),
        decoration: BoxDecoration(
          color: isDark ? colorScheme.surface : Colors.white,
          borderRadius: BorderRadius.circular(12),
          border: isDark
              ? Border.all(color: Colors.grey.shade800, width: 1)
              : Border.all(color: Colors.grey.shade300, width: 1),
          boxShadow: isDark
              ? null
              : [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  ),
                ],
        ),
        child: Icon(icon, size: 28, color: color),
      ),
    );
  }
}
