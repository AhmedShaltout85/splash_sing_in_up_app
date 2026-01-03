// // lib/main.dart
// import 'package:flutter/material.dart';
// import 'package:hive_flutter/hive_flutter.dart';
// import 'package:provider/provider.dart';
// import 'package:firebase_core/firebase_core.dart';
// import 'package:splash_sing_in_up_app/controller/task_provider.dart';
// import 'package:splash_sing_in_up_app/newtork_repos/local_repos/firestore_service.dart';
// import 'package:splash_sing_in_up_app/newtork_repos/local_repos/task_repository.dart';
// import 'firebase_options.dart';
// import 'models/task_model.dart';
// import 'newtork_repos/local_repos/local_database_service.dart';
// import 'screens/task/task_list_screen.dart';
// import 'services/connectivity_service.dart';

// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();

//   // Initialize Hive
//   await Hive.initFlutter();

//   // Register Hive adapters
//   Hive.registerAdapter(TaskModelAdapter());

//   // Initialize Firebase
//   await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);

//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   const MyApp({super.key});

//   @override
//   Widget build(BuildContext context) {
//     return MultiProvider(
//       providers: [
//         Provider<LocalDatabaseService>(create: (_) => LocalDatabaseService()),
//         Provider<FirestoreService>(create: (_) => FirestoreService()),
//         Provider<ConnectivityService>(create: (_) => ConnectivityService()),
//         Provider<TaskRepository>(
//           create: (context) => TaskRepository(
//             localDb: context.read<LocalDatabaseService>(),
//             firestore: context.read<FirestoreService>(),
//             connectivity: context.read<ConnectivityService>(),
//           ),
//         ),
//         ChangeNotifierProvider<TaskProvider>(
//           create: (context) => TaskProvider(context.read<TaskRepository>()),
//         ),
//       ],
//       child: MaterialApp(
//         debugShowCheckedModeBanner: false,
//         title: 'Offline-First Task App',
//         theme: ThemeData(
//           primarySwatch: Colors.blue,
//           appBarTheme: const AppBarTheme(
//             backgroundColor: Colors.white,
//             elevation: 2,
//             iconTheme: IconThemeData(color: Colors.blue),
//             titleTextStyle: TextStyle(
//               color: Colors.blue,
//               fontSize: 20,
//               fontWeight: FontWeight.bold,
//             ),
//           ),
//         ),
//         home: const TaskListScreen(),
//       ),
//     );
//   }
// }

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';
import 'package:splash_sing_in_up_app/controller/user_provider.dart';
import 'package:splash_sing_in_up_app/screens/auth/auth_wrapper.dart';
import 'package:splash_sing_in_up_app/screens/login/login_screen.dart';
import 'package:splash_sing_in_up_app/screens/splash/splash_screen.dart';
import 'package:splash_sing_in_up_app/screens/task/task_screen.dart';
import 'package:splash_sing_in_up_app/screens/task/user_task_screen.dart';
import 'package:splash_sing_in_up_app/screens/signup/signup_screen.dart';
import 'package:splash_sing_in_up_app/screens/home/home_screen.dart';
import 'package:splash_sing_in_up_app/utils/app_route.dart';

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
      theme: ThemeData(primarySwatch: Colors.blue),

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
