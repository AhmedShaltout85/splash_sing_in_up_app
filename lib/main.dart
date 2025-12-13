import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
// import 'package:splash_sing_in_up_app/screens/login/login_screen.dart';
import 'package:splash_sing_in_up_app/screens/splash/splash_screen.dart';

import 'firebase_options.dart';
// import 'package:splash_sing_in_up_app/screens/splash/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
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
