import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/newtorkl_repos/remote_repo/firebase_api_services.dart';
import 'package:splash_sing_in_up_app/utils/app_colors.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Home Screen'),
        actions: [
          IconButton(
            icon: Icon(Icons.logout, color: AppColors.blackColor),
            onPressed: () {
              //logout from firebase
              FirebaseApiSAuthServices.signOut();
            },
          ),
        ],
      ),
      body: Center(child: Text('Home Screen Body')),
    );
  }
}
