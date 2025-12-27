// ignore_for_file: use_build_context_synchronously

import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';

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
        actions: [
          //add app and user button
          IconButton(
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () {
              //show dialog
              var radioOptionsList = ['Add-app-name', 'Add-user'];
              CustomReusableDialog.show(
                context: context,
                title: 'Add: (app-name / user)',
                radioOptions: radioOptionsList,
                initialSelectedOption: 'Add-app-name',
                textFieldLabelBuilder: (selectedOption) {
                  return selectedOption == 'Add-app-name'
                      ? 'Enter App Name'
                      : 'Enter User Name';
                },
                initialTextValue: '',
                onSave: (selectedOption, textValue) {
                  log('Selected: $selectedOption');
                  log('Text: $textValue');

                  switch (selectedOption) {
                    case 'Add-app-name':
                      context.read<AppNameProvider>().addAppName(textValue);
                      break;
                    case 'Add-user':
                      context.read<EmployeeNameProvider>().addEmployeeName(
                        textValue,
                      );
                      break;
                    default:
                      break;
                  }
                },
                onCancel: () {
                  log('Dialog cancelled');
                },
              );
            },
          ),
          //sign out button
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blue),
            onPressed: () async {
              try {
                await FirebaseApiSAuthServices.signOut();
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text('Logged out successfully')),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                log(e.toString());
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Logout error: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
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
                return TaskItemCard(task: task);
              },
            ),
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        // onPressed: _showAddTaskDialog,
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
