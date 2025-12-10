import 'package:flutter/material.dart';

Widget buildInputField({
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
