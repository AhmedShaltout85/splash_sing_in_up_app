import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:splash_sing_in_up_app/screens/login/login_screen.dart';
import 'package:splash_sing_in_up_app/screens/splash/splash_screen.dart';
// import 'package:splash_sing_in_up_app/screens/splash/splash_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  // Hide status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Kit App',
      home: const SplashScreen(),
    );
  }
}
