import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/controller/task_providers.dart';

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
  // Filter states
  String? selectedEmployee;
  String? selectedApp;
  bool? isActiveFilter; // null = all, true = active only, false = inactive only
  bool showFilters = false;

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

  // Filter tasks based on selected filters
  List<dynamic> getFilteredTasks(List<dynamic> tasks) {
    return tasks.where((task) {
      try {
        // Filter by employee (assignedTo)
        if (selectedEmployee != null && selectedEmployee!.isNotEmpty) {
          final taskEmployee = task.assignedTo?.toString() ?? '';
          if (taskEmployee != selectedEmployee) return false;
        }

        // Filter by application (applicationName)
        if (selectedApp != null && selectedApp!.isNotEmpty) {
          final taskApp = task.applicationName?.toString() ?? '';
          if (taskApp != selectedApp) return false;
        }

        // Filter by active status (taskStatus: true = active, false = inactive)
        if (isActiveFilter != null) {
          final taskActive = task.taskStatus ?? true;
          if (taskActive != isActiveFilter) return false;
        }

        return true;
      } catch (e) {
        log('Error filtering task: $e');
        return true; // Include task if there's an error
      }
    }).toList();
  }

  // Reset all filters
  void resetFilters() {
    setState(() {
      selectedEmployee = null;
      selectedApp = null;
      isActiveFilter = null;
    });
  }

  // Check if any filter is active
  bool get hasActiveFilters =>
      selectedEmployee != null || selectedApp != null || isActiveFilter != null;

  @override
  Widget build(BuildContext context) {
    // Get unique employee names and app names to avoid dropdown duplicates
    List<String> employeeNames = context
        .watch<EmployeeNameProvider>()
        .employeeNameStrings
        .toSet()
        .toList();
    List<String> appNames = context
        .watch<AppNameProvider>()
        .appNameStrings
        .toSet()
        .toList();

    return Scaffold(
      appBar: AppBar(
        title: const Text('Tasks', style: TextStyle(color: Colors.blue)),
        iconTheme: const IconThemeData(color: Colors.blue),
        actions: [
          // Filter toggle button
          Stack(
            children: [
              IconButton(
                tooltip: 'Filters',
                icon: const Icon(Icons.filter_list, color: Colors.blue),
                onPressed: () {
                  setState(() {
                    showFilters = !showFilters;
                  });
                },
              ),
              if (hasActiveFilters)
                Positioned(
                  right: 8,
                  top: 8,
                  child: Container(
                    padding: const EdgeInsets.all(4),
                    decoration: const BoxDecoration(
                      color: Colors.red,
                      shape: BoxShape.circle,
                    ),
                    child: const SizedBox(width: 8, height: 8),
                  ),
                ),
            ],
          ),
          IconButton(
            tooltip: 'Add Task',
            padding: const EdgeInsets.symmetric(horizontal: 20),
            icon: const Icon(Icons.add, color: Colors.blue),
            onPressed: () {
              showCustomBottomSheet(
                context: context,
                appNames: appNames,
                employeeNames: employeeNames,
              );
            },
          ),
        ],
      ),
      body: Column(
        children: [
          // Filter section
          AnimatedContainer(
            duration: const Duration(milliseconds: 300),
            height: showFilters ? null : 0,
            child: showFilters
                ? Container(
                    padding: const EdgeInsets.all(16),
                    decoration: BoxDecoration(
                      color: Colors.grey[100],
                      boxShadow: [
                        BoxShadow(
                          color: Colors.grey.withOpacity(0.3),
                          blurRadius: 4,
                          offset: const Offset(0, 2),
                        ),
                      ],
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            const Text(
                              'Filters',
                              style: TextStyle(
                                fontSize: 18,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            if (hasActiveFilters)
                              TextButton.icon(
                                onPressed: resetFilters,
                                icon: const Icon(Icons.clear_all, size: 18),
                                label: const Text('Clear All'),
                              ),
                          ],
                        ),
                        const SizedBox(height: 12),
                        Row(
                          children: [
                            // Employee filter
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedEmployee,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Assigned To',
                                  prefixIcon: const Icon(Icons.person),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                ),
                                items: [
                                  const DropdownMenuItem<String>(
                                    value: null,
                                    child: Text(
                                      'All',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  ...employeeNames.map((name) {
                                    return DropdownMenuItem<String>(
                                      value: name,
                                      child: Text(
                                        name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedEmployee = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 5),

                            // Application filter
                            Expanded(
                              child: DropdownButtonFormField<String>(
                                initialValue: selectedApp,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Application',
                                  prefixIcon: const Icon(Icons.apps),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                ),
                                items: [
                                  const DropdownMenuItem<String>(
                                    value: null,
                                    child: Text(
                                      'All',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  ...appNames.map((name) {
                                    return DropdownMenuItem<String>(
                                      value: name,
                                      child: Text(
                                        name,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    );
                                  }),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    selectedApp = value;
                                  });
                                },
                              ),
                            ),
                            const SizedBox(width: 5),

                            // Active status filter
                            Expanded(
                              child: DropdownButtonFormField<bool?>(
                                initialValue: isActiveFilter,
                                isExpanded: true,
                                decoration: InputDecoration(
                                  labelText: 'Status',
                                  prefixIcon: const Icon(Icons.toggle_on),
                                  border: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                  ),
                                  filled: true,
                                  fillColor: Colors.white,
                                  contentPadding: const EdgeInsets.symmetric(
                                    horizontal: 12,
                                    vertical: 14,
                                  ),
                                ),
                                items: const [
                                  DropdownMenuItem<bool?>(
                                    value: null,
                                    child: Text(
                                      'All',
                                      overflow: TextOverflow.ellipsis,
                                      style: TextStyle(fontSize: 13),
                                    ),
                                  ),
                                  DropdownMenuItem<bool?>(
                                    value: true,
                                    child: Text(
                                      'Active Only',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                  DropdownMenuItem<bool?>(
                                    value: false,
                                    child: Text(
                                      'Inactive Only',
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    isActiveFilter = value;
                                  });
                                },
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  )
                : const SizedBox.shrink(),
          ),

          // Task list
          Expanded(
            child: Consumer<TaskProviders>(
              builder: (context, provider, child) {
                if (provider.isLoading && provider.tasks.isEmpty) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (provider.error != null) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.error_outline,
                          size: 64,
                          color: Colors.red,
                        ),
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

                // Apply filters
                final filteredTasks = getFilteredTasks(provider.tasks);

                if (filteredTasks.isEmpty && hasActiveFilters) {
                  return Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const Icon(
                          Icons.search_off,
                          size: 64,
                          color: Colors.grey,
                        ),
                        const SizedBox(height: 16),
                        const Text(
                          'No tasks match your filters',
                          style: TextStyle(fontSize: 18, color: Colors.grey),
                        ),
                        const SizedBox(height: 8),
                        TextButton.icon(
                          onPressed: resetFilters,
                          icon: const Icon(Icons.clear_all),
                          label: const Text('Clear Filters'),
                        ),
                      ],
                    ),
                  );
                }

                return RefreshIndicator(
                  onRefresh: () => provider.fetchTasks(),
                  child: Column(
                    children: [
                      // Filter summary chip
                      if (hasActiveFilters)
                        Container(
                          padding: const EdgeInsets.symmetric(
                            horizontal: 16,
                            vertical: 8,
                          ),
                          child: Row(
                            children: [
                              const Icon(
                                Icons.info_outline,
                                size: 16,
                                color: Colors.blue,
                              ),
                              const SizedBox(width: 8),
                              Expanded(
                                child: Text(
                                  'Showing ${filteredTasks.length} of ${provider.tasks.length} tasks',
                                  style: const TextStyle(
                                    fontSize: 14,
                                    color: Colors.blue,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),

                      // Task list
                      Expanded(
                        child: ListView.builder(
                          itemCount: filteredTasks.length,
                          itemBuilder: (context, index) {
                            final task = filteredTasks[index];
                            log(
                              'Building TaskItemCard for task ID: ${task.taskPriority} at index $index with title: ${task.taskTitle}',
                            );
                            return TaskItemCard(task: task);
                          },
                        ),
                      ),
                    ],
                  ),
                );
              },
            ),
          ),
        ],
      ),
      drawer: const CustomDrawer(),
    );
  }
}
