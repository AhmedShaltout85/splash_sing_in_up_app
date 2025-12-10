import 'package:flutter/material.dart';

import '../screens/signup/signup_screen.dart';

class CustomSocialIcon extends StatelessWidget {
  final void Function()? onTap;
  final String iconPath;
  const CustomSocialIcon({
    super.key,
    required this.iconPath,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Image.asset(iconPath, width: 40, height: 40, fit: BoxFit.contain),
    );
  }
}

class CustomButton extends StatelessWidget {
  const CustomButton({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 36.0),
      child: Container(
        width: 200,
        height: 50,
        decoration: BoxDecoration(
          color: Color(0xFF769DAD),
          borderRadius: BorderRadius.circular(8),
          boxShadow: [
            BoxShadow(
              color: Color(0xFF769DAD).withOpacity(0.4),
              blurRadius: 12,
              offset: Offset(0, 6),
            ),
          ],
        ),
        child: Material(
          color: Colors.transparent,
          child: InkWell(
            onTap: () {
              // Handle login
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => SignUpScreen()),
              );
            },
            borderRadius: BorderRadius.circular(8),
            child: Center(
              child: Text(
                'LOG IN',
                style: TextStyle(
                  color: Colors.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                  letterSpacing: 1.5,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
