import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:splash_sing_in_up_app/newtork_repos/remote_repo/firebase_api_services.dart';
import 'package:splash_sing_in_up_app/screens/report/report_screen.dart';
import 'package:splash_sing_in_up_app/screens/user/user_list_screen.dart';

import '../../screens/add_employee_app_name/add_employee_app_name.dart';

class CustomDrawer extends StatelessWidget {
  const CustomDrawer({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: Container(
        color: Colors.white,
        child: Column(
          children: [
            // Header with user info
            Container(
              width: double.infinity,
              padding: const EdgeInsets.fromLTRB(20, 60, 20, 20),
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.blue.shade700, Colors.blue.shade500],
                ),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.white,
                    child: Icon(
                      Icons.person,
                      size: 45,
                      color: Colors.blue.shade700,
                    ),
                  ),
                  const SizedBox(height: 15),
                  const Text(
                    'Login User',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 22,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 5),
                  Text(
                    'login-user@example.com',
                    style: TextStyle(
                      color: Colors.white.withOpacity(0.9),
                      fontSize: 14,
                    ),
                  ),
                ],
              ),
            ),

            // Menu items
            Expanded(
              child: ListView(
                padding: const EdgeInsets.symmetric(vertical: 10),
                children: [
                  _buildDrawerItem(
                    context,
                    icon: Icons.home,
                    title: 'Home',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to home
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.person_add,
                    title: 'Users Profiles',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to profile
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const UserListScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.settings,
                    title: 'Settings',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to settings
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.boy_rounded,
                    title: 'Added Employees',
                    onTap: () async {
                      Navigator.pop(context);
                      // Navigate to Added Employees with await to refresh when returning
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEmployeeAppName(
                            title: 'Added Employees',
                          ),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.desktop_mac_sharp,
                    title: 'Added Applications',
                    onTap: () async {
                      Navigator.pop(context);
                      // Navigate to Added Applications with await to refresh when returning
                      await Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const AddEmployeeAppName(
                            title: 'Added Applications',
                          ),
                        ),
                      );
                    },
                  ),
                  const Divider(height: 30),
                  _buildDrawerItem(
                    context,
                    icon: Icons.list_alt,
                    title: 'Reports',
                    onTap: () {
                      Navigator.pop(context);

                      // Navigate to reports
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const ReportScreen(),
                        ),
                      );
                    },
                  ),
                  _buildDrawerItem(
                    context,
                    icon: Icons.info_outline,
                    title: 'About',
                    onTap: () {
                      Navigator.pop(context);
                      // Navigate to about
                    },
                  ),
                ],
              ),
            ),

            // Logout button at bottom
            Container(
              padding: const EdgeInsets.all(15),
              decoration: BoxDecoration(
                border: Border(
                  top: BorderSide(color: Colors.grey.shade300, width: 1),
                ),
              ),
              child: _buildDrawerItem(
                context,
                icon: Icons.logout,
                title: 'Logout',
                iconColor: Colors.red,
                onTap: () {
                  Navigator.pop(context);
                  // Handle logout
                  _showLogoutDialog(context);
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildDrawerItem(
    BuildContext context, {
    required IconData icon,
    required String title,
    required VoidCallback onTap,
    Widget? trailing,
    Color? iconColor,
  }) {
    return ListTile(
      leading: Icon(icon, color: iconColor ?? Colors.blue.shade700, size: 26),
      title: Text(
        title,
        style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w500),
      ),
      trailing: trailing,
      onTap: onTap,
      contentPadding: const EdgeInsets.symmetric(horizontal: 20, vertical: 5),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(10)),
      hoverColor: Colors.blue.shade50,
    );
  }

  void _showLogoutDialog(BuildContext context) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Logout'),
        content: const Text('Are you sure you want to logout?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              Navigator.pop(context);
              // Perform logout
              // Add your logout logic here
              try {
                await FirebaseApiSAuthServices.signOut();
                ReusableToast.showToast(
                  message: 'Logged out successfully',
                  bgColor: Colors.green,
                  textColor: Colors.white,
                  fontSize: 16,
                );
              } catch (e) {
                log(e.toString());
                ReusableToast.showToast(
                  message: 'Logout error: ${e.toString()}',
                  bgColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16,
                );
              }
            },
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            child: const Text('Logout'),
          ),
        ],
      ),
    );
  }
}
