import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/task_provider.dart';
import 'package:splash_sing_in_up_app/models/task_model.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final taskTitleController = TextEditingController();
  final taskDescriptionController = TextEditingController();
  final taskNoteController = TextEditingController();
  @override
  void initState() {
    super.initState();
    // Fetch users on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProvider>().fetchTasks();
      // Or use real-time updates:
      // context.read<UserProvider>().listenToUsers();
    });
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    taskDescriptionController.dispose();
    taskNoteController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Add New Task'),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            TextField(
              controller: taskTitleController,
              decoration: const InputDecoration(labelText: 'Title'),
            ),
            TextField(
              controller: taskDescriptionController,
              decoration: const InputDecoration(labelText: 'Description'),
            ),
            TextField(
              controller: taskNoteController,
              decoration: const InputDecoration(labelText: 'Note'),
              keyboardType: TextInputType.number,
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final task = TaskModel(
                id: DateTime.now().toIso8601String(),
                taskTitle: taskTitleController.text,
                taskDescription: taskDescriptionController.text,
                notes: taskNoteController.text,
                dateTime: DateTime.now().toString(),
                status: true,
                assignedTo: 'Anonymous',
                assignedBy: 'Manager',
                createdAt: DateTime.now().toString(),
                updatedAt: DateTime.now().toString(),
              );

              context.read<TaskProvider>().addTask(task);
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
        title: const Text('Tasks', style: TextStyle(color: Colors.blue)),
        actions: [
          IconButton(
            icon: const Icon(Icons.logout, color: Colors.blue),
            onPressed: _showAddTaskDialog,
          ),
        ],
      ),
      body: Consumer<TaskProvider>(
        builder: (context, provider, child) {
          if (provider.isLoading && provider.tasks.isEmpty) {
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
                      provider.fetchTasks();
                      log(provider.error.toString());
                    },
                    child: const Text('Retry'),
                  ),
                ],
              ),
            );
          }

          if (provider.tasks.isEmpty) {
            return const Center(child: Text('No tasks found'));
          }

          return ListView.builder(
            itemCount: provider.tasks.length,
            itemBuilder: (context, index) {
              final task = provider.tasks[index];
              return Container(
                margin: const EdgeInsets.all(8.0),
                decoration: BoxDecoration(
                  border: Border.all(color: Colors.grey),
                  borderRadius: BorderRadius.circular(8.0),
                ),
                child: ListTile(
                  title: Text(
                    task.taskTitle,
                    style: const TextStyle(
                      fontSize: 17,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  subtitle: Text(
                    'Description: ${task.taskDescription} \n Note: ${task.notes} \n Status: ${task.status} \n Assigned To: ${task.assignedTo} \n Assigned By: ${task.assignedBy} \n Created At: ${task.createdAt} \n Updated At: ${task.updatedAt}',
                    style: const TextStyle(fontSize: 15),
                  ),
                  trailing: Row(
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      IconButton(
                        icon: const Icon(Icons.edit, color: Colors.green),
                        onPressed: () {
                          // Implement edit functionality
                          provider.updateTask(task.id, {
                            'status': task.status ? 'false' : 'true',
                          });
                        },
                      ),
                      IconButton(
                        icon: const Icon(Icons.delete, color: Colors.red),
                        onPressed: () {
                          provider.updateTask(task.id, {'status': false});
                          provider.fetchTasks();
                        },
                      ),
                    ],
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: Colors.blue,
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
