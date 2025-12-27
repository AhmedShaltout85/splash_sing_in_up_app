import 'package:flutter/material.dart';

class ReportScreen extends StatelessWidget {
  const ReportScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports', style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
      ),
      body: const Center(
        child: Text(
          'Report Screen Content Goes Here (Reports)',
          style: TextStyle(fontSize: 18),
        ),
      ),
    );
  }
}
