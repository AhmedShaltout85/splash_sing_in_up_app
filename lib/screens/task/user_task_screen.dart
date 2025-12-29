// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';
import 'package:splash_sing_in_up_app/newtork_repos/remote_repo/firebase_api_services.dart';

import '../../common_widgets/custom_widgets/task_item_card.dart';

class UserTaskScreen extends StatefulWidget {
  const UserTaskScreen({super.key});

  @override
  State<UserTaskScreen> createState() => _UserTaskScreenState();
}

class _UserTaskScreenState extends State<UserTaskScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch tasks
      context.read<TaskProviders>().fetchTasksByStatus(true);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          'Tasks Assigned to User',
          // 'Tasks Assigned to ${FirebaseAuth.instance.currentUser!.displayName}',
          style: TextStyle(color: Colors.blue),
        ),
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          Container(
            width: 28,
            height: 28,
            decoration: BoxDecoration(
              color: Colors.red,
              shape: BoxShape.circle,
            ),
            child: Center(
              child: Text(
                '${context.watch<TaskProviders>().tasks.length}',
                style: const TextStyle(color: Colors.white, fontSize: 12),
              ),
            ),
          ),
          IconButton(
            icon: const Icon(Icons.refresh, color: Colors.blue),
            onPressed: () {
              context.read<TaskProviders>().fetchTasksByStatus(true);
            },
          ),
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blue),
            onPressed: () {
              //logout from firebase
              if (FirebaseAuth.instance.currentUser != null) {
                FirebaseApiSAuthServices.signOut();
              }
            },
          ),
        ],
      ),
      body: Consumer<TaskProviders>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.tasks.isEmpty) {
            return const Center(child: CircularProgressIndicator());
          }

          if (provider.error != null) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  const Icon(Icons.error_outline, size: 64, color: Colors.red),
                  const SizedBox(height: 16),
                  Text(
                    'Error: ${provider.error}',
                    textAlign: TextAlign.center,
                    style: const TextStyle(fontSize: 16),
                  ),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () {
                      provider.fetchTasksByStatus(true);
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.tasks.isEmpty) {
            return const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(Icons.task_outlined, size: 64, color: Colors.grey),
                  SizedBox(height: 16),
                  Text(
                    'No tasks found',
                    style: TextStyle(fontSize: 18, color: Colors.grey),
                  ),
                  SizedBox(height: 8),
                  Text(
                    'Tap + to add a new task',
                    style: TextStyle(fontSize: 14, color: Colors.grey),
                  ),
                ],
              ),
            );
          }

          return RefreshIndicator(
            onRefresh: () => provider.fetchTasks(),
            child: ListView.builder(
              itemCount: provider.tasks.length,
              itemBuilder: (context, index) {
                final task = provider.tasks[index];
                log(
                  'Building TaskItemCard for task ID: ${task.taskPriority} at index $index with title: ${task.taskTitle}',
                );
                return TaskItemCard(task: task);
              },
            ),
          );
        },
      ),
    );
  }
}
