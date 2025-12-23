import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/common_widgets/custom_widgets/custom_text_field.dart';
// import 'package:splash_sing_in_up_app/controller/task_provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';
import 'package:splash_sing_in_up_app/models/task.dart';

import '../../newtork_repos/remote_repo/firebase_api_services.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  final taskTitleController = TextEditingController();
  final appNameController = TextEditingController();
  final taskNoteController = TextEditingController();
  final assignToController = TextEditingController();
  final assignByController = TextEditingController();
  final taskPeriorityController = TextEditingController();
  final visitPlaceController = TextEditingController();
  final coOperateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch tasks on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProviders>().fetchTasks();
    });
  }

  @override
  void dispose() {
    taskTitleController.dispose();
    appNameController.dispose();
    taskNoteController.dispose();
    assignToController.dispose();
    assignByController.dispose();
    taskPeriorityController.dispose();
    visitPlaceController.dispose();
    coOperateController.dispose();
    super.dispose();
  }

  void _showAddTaskDialog() {
    // Clear previous input
    taskTitleController.clear();
    appNameController.clear();
    taskNoteController.clear();
    assignToController.clear();
    assignByController.clear();
    taskPeriorityController.clear();
    visitPlaceController.clear();
    coOperateController.clear();

    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text(
          'Add New Task',
          style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
        ),
        content: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SizedBox(
              height: 30,
              width: MediaQuery.of(context).size.width * 0.85,
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                hintText: 'taskTitle',
                controller: taskTitleController,
                prefixIcon: SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                hintText: 'appName',
                controller: appNameController,
                prefixIcon: SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                hintText: 'taskNote',
                controller: taskNoteController,
                prefixIcon: SizedBox.shrink(),
              ),
            ),

            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                hintText: 'assignTo',
                controller: assignToController,
                prefixIcon: SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                controller: assignByController,
                hintText: 'assignBy',
                prefixIcon: SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                controller: taskPeriorityController,
                hintText: 'taskPeriority',
                prefixIcon: SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                controller: visitPlaceController,
                hintText: 'visitPlace',
                prefixIcon: SizedBox.shrink(),
              ),
            ),
            Padding(
              padding: const EdgeInsets.all(5.0),
              child: CustomTextFiled(
                controller: coOperateController,
                hintText: 'coOperate',
                prefixIcon: SizedBox.shrink(),
              ),
            ),
          ],
        ),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () async {
              // Validate input
              if (taskTitleController.text.trim().isEmpty) {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('Please enter a title'),
                    backgroundColor: Colors.orange,
                  ),
                );
                return;
              }

              try {
                // Don't set 'id' - let Firestore generate it
                await context.read<TaskProviders>().addTask({
                  'id': DateTime.now().millisecondsSinceEpoch.toString(),
                  'taskTitle': taskTitleController.text,
                  'applicationName': appNameController.text,
                  'taskNote': taskNoteController.text,
                  'assignedTo': assignToController.text,
                  'assignedBy': assignByController.text,
                  'taskPeriority': taskPeriorityController.text,
                  'visitPlace': visitPlaceController.text,
                  'coOperator': coOperateController.text,

                  // Don't include createdAt/updatedAt - Firestore handles it
                });

                if (mounted) {
                  Navigator.pop(context);
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Center(child: Text('Task added successfully')),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
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
        onPressed: _showAddTaskDialog,
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}

class TaskItemCard extends StatelessWidget {
  final Task task;
  const TaskItemCard({super.key, required this.task});

  @override
  Widget build(BuildContext context) {
    final provider = Provider.of<TaskProviders>(context, listen: false);

    final colorList = <Color>[
      Colors.red.shade100,
      Colors.green.shade100,
      Colors.blue.shade100,
      Colors.purple.shade100,
      Colors.orange.shade100,
      Colors.yellow.shade100,
      Colors.pink.shade100,
      Colors.teal.shade100,
    ];

    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 12.0, vertical: 6.0),
      decoration: BoxDecoration(
        color: colorList[task.id.hashCode.abs() % colorList.length],
        border: Border.all(color: Colors.blue, width: 2.0),
        borderRadius: BorderRadius.circular(12.0),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.1),
            blurRadius: 4,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: ListTile(
        contentPadding: const EdgeInsets.all(12.0),
        title: Text(
          task.taskTitle,
          style: const TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.black87,
          ),
        ),
        subtitle: Padding(
          padding: const EdgeInsets.only(top: 8.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              if (task.assignedBy.isNotEmpty && task.assignedTo.isNotEmpty)
                Text(
                  'Assigned by: ${task.assignedBy} to ${task.assignedTo}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              if (task.applicationName.isNotEmpty)
                Text(
                  'Application Name: ${task.applicationName}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              if (task.notes?.isNotEmpty ?? false)
                Text(
                  'Note: ${task.notes}',
                  style: TextStyle(
                    fontSize: 17,
                    fontWeight: FontWeight.w600,
                    color: Colors.black.withOpacity(0.7),
                  ),
                ),
              const SizedBox(height: 4),
              Row(
                children: [
                  Icon(
                    task.taskStatus ? Icons.check_circle : Icons.cancel,
                    size: 16,
                    color: task.taskStatus ? Colors.green : Colors.red,
                  ),
                  const SizedBox(width: 4),
                  Text(
                    'Status: ${task.taskStatus ? "Active" : "Inactive"}',
                    style: TextStyle(
                      fontSize: 17,
                      color: Colors.black.withOpacity(0.6),
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ],
              ),
              Text(
                'Created: ${_formatDate(task.createdAt)}',
                style: TextStyle(
                  fontSize: 17,
                  fontWeight: FontWeight.w600,
                  color: Colors.black.withOpacity(0.5),
                ),
              ),
            ],
          ),
        ),
        trailing: Row(
          mainAxisSize: MainAxisSize.min,
          children: [
            // Toggle Status Button
            IconButton(
              icon: Icon(
                task.taskStatus ? Icons.toggle_on : Icons.toggle_off,
                color: task.taskStatus ? Colors.green : Colors.grey,
                size: 32,
              ),
              onPressed: () async {
                try {
                  await provider.updateTask(task.id, {
                    'status': !task.taskStatus,
                  });
                  await provider.fetchTasks();

                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Center(
                          child: Text(
                            task.taskStatus
                                ? 'Task marked as inactive'
                                : 'Task marked as active',
                          ),
                        ),
                        backgroundColor: Colors.green,
                        duration: const Duration(seconds: 2),
                      ),
                    );
                  }
                } catch (e) {
                  if (context.mounted) {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text('Error updating task: ${e.toString()}'),
                        backgroundColor: Colors.red,
                      ),
                    );
                  }
                }
              },
            ),
            // Delete Button
            IconButton(
              icon: const Icon(Icons.delete, color: Colors.red),
              onPressed: () {
                _showDeleteConfirmation(context, provider, task);
              },
            ),
          ],
        ),
      ),
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    TaskProviders provider,
    Task task,
  ) {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Task'),
        content: Text('Are you sure you want to delete "${task.taskTitle}"?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(backgroundColor: Colors.red),
            onPressed: () async {
              Navigator.pop(context);
              try {
                await provider.deleteTask(task.id);

                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    const SnackBar(
                      content: Text('Task deleted successfully'),
                      backgroundColor: Colors.green,
                    ),
                  );
                }
              } catch (e) {
                if (context.mounted) {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content: Text('Error deleting task: ${e.toString()}'),
                      backgroundColor: Colors.red,
                    ),
                  );
                }
              }
            },
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  String _formatDate(DateTime date) {
    return '${date.day}/${date.month}/${date.year} ${date.hour}:${date.minute.toString().padLeft(2, '0')}';
  }
}
