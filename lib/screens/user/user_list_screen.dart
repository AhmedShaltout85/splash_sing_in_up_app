import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../../controller/user_provider.dart';
import '../../models/user_model.dart';

class UserListScreen extends StatefulWidget {
  const UserListScreen({super.key});

  @override
  State<UserListScreen> createState() => _UserListScreenState();
}

class _UserListScreenState extends State<UserListScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch users on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<UserProvider>().fetchUsers();
      // Or use real-time updates:
      // context.read<UserProvider>().listenToUsers();
    });
  }

  void _showAddUserDialog() {
    final displayNameController = TextEditingController();
    final emailController = TextEditingController();
    // final ageController = TextEditingController();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New User'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: displayNameController,
              decoration: const InputDecoration(labelText: 'Name'),
            ),
            TextField(
              controller: emailController,
              decoration: const InputDecoration(labelText: 'Email'),
            ),
            // TextField(
            //   // controller: ageController,
            //   decoration: const InputDecoration(labelText: 'Age'),
            //   keyboardType: TextInputType.number,
            // ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final user = UserModel(
                id: '',
                firstName: displayNameController.text.split(' ').first,
                lastName: displayNameController.text.split(' ').last,
                displayName: displayNameController.text,
                email: emailController.text,
                // photoURL: '',
                createdAt: DateTime.now(),
              );
              context.read<UserProvider>().addUser(user);
              Navigator.pop(context);
            },
            child: const Text('Add'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Manage Users', style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          IconButton(
            tooltip: 'Add User',
            padding: EdgeInsets.symmetric(horizontal: 20),
            icon: const Icon(Icons.person_add, color: Colors.blue),
            onPressed: _showAddUserDialog,
          ),
        ],
      ),
      body: Consumer<UserProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.users.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text('Error: ${provider.error}'),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchUsers();
                      log(provider.error.toString());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.users.isEmpty) {
            return const Center(child: Text('No users found'));
          }

          return ListView.builder(
            itemCount: provider.users.length,
            itemBuilder: (context, index) {
              final user = provider.users[index];
              return ListTile(
                title: Text(user.displayName),
                subtitle: Text('${user.email} - email: ${user.email}'),
                leading: CircleAvatar(
                  backgroundImage: NetworkImage(user.photoURL ?? ''),
                  radius: 30,
                ),
                trailing: Row(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    IconButton(
                      icon: const Icon(Icons.edit),
                      onPressed: () {
                        // Implement edit functionality
                        provider.updateUser(user.id, {'email': user.email});
                      },
                    ),
                    IconButton(
                      icon: const Icon(Icons.delete),
                      onPressed: () => provider.deleteUser(user.id),
                    ),
                  ],
                ),
              );
            },
          );
        },
      ),
    );
  }
}
