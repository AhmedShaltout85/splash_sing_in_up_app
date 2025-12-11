import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/utils/app_assets.dart';

import '../login/login_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(builder: (context) => const LoginScreen()),
        );
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final kHeight = size.height;
    final kWidth = size.width;
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          Image.asset(
            AppAssets.splashLogo,
            height: kHeight * 0.8,
            width: kWidth * 0.8,
          ),
          Text(
            'Lorem Ipsum',
            style: TextStyle(fontSize: 24, fontWeight: FontWeight.bold),
          ),
          Text(
            textAlign: TextAlign.center,
            'Lorem Ipsum is a dummy text used as placeholder',
            style: TextStyle(fontSize: 20),
          ),
        ],
      ),
    );
  }
}
