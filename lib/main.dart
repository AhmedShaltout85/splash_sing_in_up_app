import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/task_providers.dart';
import 'package:task_app/controller/user_provider.dart';
import 'package:task_app/screens/auth/auth_wrapper.dart';
import 'package:task_app/screens/login/login_screen.dart';
import 'package:task_app/screens/splash/splash_screen.dart';
import 'package:task_app/screens/task/task_screen.dart';
import 'package:task_app/screens/task/user_task_screen.dart';
import 'package:task_app/screens/signup/signup_screen.dart';
import 'package:task_app/screens/home/home_screen.dart';
import 'package:task_app/utils/app_route.dart';

import 'controller/app_name_provider.dart';
import 'controller/employee_name_provider.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  // Initialize Firebase
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => TaskProviders()),
        ChangeNotifierProvider(create: (_) => AppNameProvider()),
        ChangeNotifierProvider(create: (_) => EmployeeNameProvider()),
        ChangeNotifierProvider(create: (_) => UserProvider()),
      ],
      child: MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Flutter Firebase App',
      theme: ThemeData(primarySwatch: Colors.blue, fontFamily: 'Cairo'),

      initialRoute: AppRoute.splashRouteName,
      routes: {
        AppRoute.splashRouteName: (context) => const SplashScreen(),
        AppRoute.loginRouteName: (context) => const LoginScreen(),
        AppRoute.signupRouteName: (context) => const SignUpScreen(),
        AppRoute.taskRouteName: (context) => const TaskScreen(),
        AppRoute.userTaskRouteName: (context) => const UserTaskScreen(),
        AppRoute.homeRouteName: (context) => const HomeScreen(),
        AppRoute.authWrapperRouteName: (context) => const AuthWrapper(),
      },
    );
  }
}
