import 'package:flutter/material.dart';

class AddEmployeeAppName extends StatelessWidget {
  final String title;
  const AddEmployeeAppName({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title, style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: Center(child: Text('$title Content Here')),
    );
  }
}
