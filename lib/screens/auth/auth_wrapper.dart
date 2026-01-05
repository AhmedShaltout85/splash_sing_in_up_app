// 1. CREATE: lib/screens/auth/auth_wrapper.dart
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:task_app/screens/login/login_screen.dart';
import 'package:task_app/screens/task/task_screen.dart';
import 'package:task_app/screens/task/user_task_screen.dart';

class AuthWrapper extends StatelessWidget {
  const AuthWrapper({super.key});

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
          return const LoginScreen();
        }

        // User is logged in - check role and navigate
        User user = snapshot.data!;

        // Check if admin based on email
        if (_isAdminUser(user.email)) {
          return const TaskScreen(); // Admin screen
        } else {
          return const UserTaskScreen(); // Regular user screen
        }
      },
    );
  }
}
