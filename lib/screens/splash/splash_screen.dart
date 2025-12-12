import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/common_widgets/custom_widgets/custom_text.dart';
import 'package:splash_sing_in_up_app/utils/app_assets.dart';
import 'package:splash_sing_in_up_app/utils/app_colors.dart';

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
    final double fontSize = 20;
    return Scaffold(
      backgroundColor: AppColors.whiteColor,
      body: Stack(
        alignment: Alignment.center,
        children: [
          Positioned(
            top: kHeight * 0.0,
            child: Image.asset(
              AppAssets.splashLogo,
              height: kHeight * 0.8,
              width: kWidth * 0.8,
              fit: BoxFit.fill,
            ),
          ),

          Positioned(
            top: kHeight * 0.65,
            child: CustomText(
              text: 'LOREM IPSUM',
              fontSize: fontSize + 4,
              fontWeight: FontWeight.bold,
              color: AppColors.blackColor,
            ),
          ),

          Positioned(
            top: kHeight * 0.7,
            left: kWidth * 0.1,
            right: kWidth * 0.1,
            child: CustomText(
              text: 'Lorem Ipsum is a dummy text used as placeholder',
              fontSize: fontSize,
              textAlign: TextAlign.center,
              fontWeight: FontWeight.normal,
              color: AppColors.grayColor,
              maxLines: 2,
              softWrap: true,
            ),
          ),
        ],
      ),
    );
  }
}
