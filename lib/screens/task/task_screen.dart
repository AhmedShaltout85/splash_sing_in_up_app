import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';

import '../../common_widgets/custom_widgets/task_item_card.dart';
import '../../common_widgets/resuable_widgets/resuable_widgets.dart';
import '../../newtork_repos/remote_repo/firebase_api_services.dart';

class TaskScreen extends StatefulWidget {
  const TaskScreen({super.key});

  @override
  State<TaskScreen> createState() => _TaskScreenState();
}

class _TaskScreenState extends State<TaskScreen> {
  //   final taskTitleController = TextEditingController();
  //   final appNameController = TextEditingController();
  //   final taskNoteController = TextEditingController();
  //   final assignToController = TextEditingController();
  //   final assignByController = TextEditingController();
  //   final taskPeriorityController = TextEditingController();
  //   final visitPlaceController = TextEditingController();
  //   final coOperateController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // Fetch tasks on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<TaskProviders>().fetchTasks();
    });
  }

  //   @override
  //   void dispose() {
  //     taskTitleController.dispose();
  //     appNameController.dispose();
  //     taskNoteController.dispose();
  //     assignToController.dispose();
  //     assignByController.dispose();
  //     taskPeriorityController.dispose();
  //     visitPlaceController.dispose();
  //     coOperateController.dispose();
  //     super.dispose();
  //   }

  //   void _showAddTaskDialog() {
  //     // Clear previous input
  //     taskTitleController.clear();
  //     appNameController.clear();
  //     taskNoteController.clear();
  //     assignToController.clear();
  //     assignByController.clear();
  //     taskPeriorityController.clear();
  //     visitPlaceController.clear();
  //     coOperateController.clear();

  //     showDialog(
  //       context: context,
  //       builder: (context) => AlertDialog(
  //         title: const Text(
  //           'Add New Task',
  //           style: TextStyle(color: Colors.blue, fontWeight: FontWeight.bold),
  //         ),
  //         content: Column(
  //           mainAxisSize: MainAxisSize.min,
  //           children: [
  //             SizedBox(
  //               height: 30,
  //               width: MediaQuery.of(context).size.width * 0.85,
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 hintText: 'taskTitle',
  //                 controller: taskTitleController,
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 hintText: 'appName',
  //                 controller: appNameController,
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 hintText: 'taskNote',
  //                 controller: taskNoteController,
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),

  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 hintText: 'assignTo',
  //                 controller: assignToController,
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 controller: assignByController,
  //                 hintText: 'assignBy',
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 controller: taskPeriorityController,
  //                 hintText: 'taskPeriority',
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 controller: visitPlaceController,
  //                 hintText: 'visitPlace',
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //             Padding(
  //               padding: const EdgeInsets.all(5.0),
  //               child: CustomTextFiled(
  //                 controller: coOperateController,
  //                 hintText: 'coOperate',
  //                 prefixIcon: SizedBox.shrink(),
  //               ),
  //             ),
  //           ],
  //         ),
  //         actions: [
  //           TextButton(
  //             onPressed: () => Navigator.pop(context),
  //             child: const Text('Cancel'),
  //           ),
  //           ElevatedButton(
  //             onPressed: () async {
  //               // Validate input
  //               if (taskTitleController.text.trim().isEmpty) {
  //                 ScaffoldMessenger.of(context).showSnackBar(
  //                   const SnackBar(
  //                     content: Text('Please enter a title'),
  //                     backgroundColor: Colors.orange,
  //                   ),
  //                 );
  //                 return;
  //               }

  //               try {
  //                 // Don't set 'id' - let Firestore generate it
  //                 await context.read<TaskProviders>().addTask({
  //                   'id': DateTime.now().millisecondsSinceEpoch.toString(),
  //                   'taskTitle': taskTitleController.text,
  //                   'applicationName': appNameController.text,
  //                   'taskNote': taskNoteController.text,
  //                   'assignedTo': assignToController.text,
  //                   'assignedBy': assignByController.text,
  //                   'taskPeriority': taskPeriorityController.text,
  //                   'visitPlace': visitPlaceController.text,
  //                   'coOperator': coOperateController.text,

  //                   // Don't include createdAt/updatedAt - Firestore handles it
  //                 });

  //                 if (mounted) {
  //                   Navigator.pop(context);
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     const SnackBar(
  //                       content: Center(child: Text('Task added successfully')),
  //                       backgroundColor: Colors.green,
  //                     ),
  //                   );
  //                 }
  //               } catch (e) {
  //                 if (mounted) {
  //                   ScaffoldMessenger.of(context).showSnackBar(
  //                     SnackBar(
  //                       content: Text('Error: ${e.toString()}'),
  //                       backgroundColor: Colors.red,
  //                     ),
  //                   );
  //                 }
  //               }
  //             },
  //             child: const Text('Add'),
  //           ),
  //         ],
  //       ),
  //     );
  //   }

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
        // onPressed: _showAddTaskDialog,
        onPressed: () => showCustomBottomSheet(context),
        child: const Icon(Icons.add, color: Colors.white),
      ),
    );
  }
}
