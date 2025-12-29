// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';

import '../../common_widgets/custom_widgets/custom_drawer.dart';
import '../../common_widgets/custom_widgets/task_item_card.dart';
import '../../common_widgets/resuable_widgets/resuable_widgets.dart';
import '../../controller/app_name_provider.dart';
import '../../controller/employee_name_provider.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  @override
  void initState() {
    super.initState();
    // Fetch tasks on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      // Fetch tasks
      context.read<TaskProviders>().fetchTasks();
      // Fetch app names and employee names List<String>
      context.read<EmployeeNameProvider>().fetchEmployeeNamesAsStrings();
      //Fetch app names List<String>
      context.read<AppNameProvider>().fetchAppNamesAsStrings();
    });
  }

  @override
  Widget build(BuildContext context) {
    List<String> employeeNames = context
        .watch<EmployeeNameProvider>()
        .employeeNameStrings;
    List<String> appNames = context.watch<AppNameProvider>().appNameStrings;
    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks', style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
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
                      provider.fetchTasks();
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
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: () => showCustomBottomSheet(
          context: context,
          appNames: appNames,
          employeeNames: employeeNames,
        ),
        child: const Icon(Icons.add, color: Colors.white),
      ),
      drawer: const CustomDrawer(),
    );
  }
}
