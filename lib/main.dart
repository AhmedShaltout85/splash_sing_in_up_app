import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:provider/provider.dart';

import 'controller/task_provider.dart';
import 'controller/user_provider.dart';
import 'firebase_options.dart';
import 'screens/home/home_screen.dart';
import 'screens/login/login_screen.dart';
import 'screens/signup/signup_screen.dart';
import 'screens/splash/splash_screen.dart';
import 'screens/task/task_screen.dart';
import 'screens/user/user_list_screen.dart';
import 'utils/app_route.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  //firebase initialization
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  // Hide status bar
  SystemChrome.setEnabledSystemUIMode(SystemUiMode.manual, overlays: []);
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UI Kit App',
      // onGenerateRoute: (settings) {
      //   switch (settings.name) {
      //     case AppRoute.splashRouteName:
      //       return MaterialPageRoute(
      //         builder: (context) => const SplashScreen(),
      //       );
      //     case AppRoute.loginRouteName:
      //       return MaterialPageRoute(builder: (context) => const LoginScreen());
      //     case AppRoute.homeRouteName:
      //       return MaterialPageRoute(builder: (context) => const HomeScreen());
      //     case AppRoute.signupRouteName:
      //       return MaterialPageRoute(
      //         builder: (context) => const SignUpScreen(),
      //       );
      //     case AppRoute.userRouteName:
      //       return MaterialPageRoute(
      //         builder: (context) => const UserListScreen(),
      //       );
      //     case AppRoute.taskRouteName:
      //       return MaterialPageRoute(builder: (context) => const TaskScreen());

      //     default:
      //       return MaterialPageRoute(
      //         builder: (context) => const SplashScreen(),
      //       );
      //   }
      // },
      home: const TaskScreen(),
    );
  }
}
