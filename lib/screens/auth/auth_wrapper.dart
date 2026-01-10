// lib/screens/auth/auth_wrapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/screens/login/login_screen.dart';
import 'package:task_app/screens/task/task_screen.dart';
import 'package:task_app/screens/task/user_task_screen.dart';

class AuthWrapper extends StatefulWidget {
  const AuthWrapper({super.key});

  @override
  State<AuthWrapper> createState() => _AuthWrapperState();
}

class _AuthWrapperState extends State<AuthWrapper> {
  String? _currentUserEmail;

  // Check if user is admin based on email
  bool _isAdminUser(String? email) {
    if (email == null || email.isEmpty) return false;
    // Get username part before @
    final username = email.split('@').first.toLowerCase();
    return username == 'admin';
  }

  @override
  Widget build(BuildContext context) {
    return StreamBuilder<User?>(
      stream: FirebaseAuth.instance.authStateChanges(),
      builder: (context, snapshot) {
        // Show loading while checking auth state
        if (snapshot.connectionState == ConnectionState.waiting) {
          return const Scaffold(
            body: Center(child: CircularProgressIndicator()),
          );
        }

        // User is not logged in - show login screen
        if (!snapshot.hasData || snapshot.data == null) {
          // Reset current user email when logged out
          _currentUserEmail = null;
          return const LoginScreen();
        }

        // User is logged in - check role and navigate
        User user = snapshot.data!;
        String? newUserEmail = user.email;

        // If user changed, we need to rebuild with the correct screen
        if (_currentUserEmail != newUserEmail) {
          _currentUserEmail = newUserEmail;

          // Force rebuild to clear previous screen's state
          WidgetsBinding.instance.addPostFrameCallback((_) {
            if (mounted) {
              setState(() {});
            }
          });
        }

        // Check if admin based on email and return appropriate screen with key
        if (_isAdminUser(user.email)) {
          return TaskScreen(key: ValueKey('admin_${user.uid}')); // Admin screen
        } else {
          return UserTaskScreen(
            key: ValueKey('user_${user.uid}'),
          ); // Regular user screen
        }
      },
    );
  }
}
