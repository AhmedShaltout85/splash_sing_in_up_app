import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/common_widgets/custom_widgets/custom_reusable_dialog.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:splash_sing_in_up_app/controller/app_name_provider.dart';
import 'package:splash_sing_in_up_app/controller/employee_name_provider.dart';

class AddEmployeeAppName extends StatefulWidget {
  final String title;
  const AddEmployeeAppName({super.key, required this.title});

  @override
  State<AddEmployeeAppName> createState() => _AddEmployeeAppNameState();
}

class _AddEmployeeAppNameState extends State<AddEmployeeAppName> {
  // Track which list to display
  String selectedView = 'Add-app-name'; // default view
  late String currentTitle; // Track current title

  @override
  void initState() {
    super.initState();

    // Initialize current title
    currentTitle = widget.title;

    // Set initial view based on title
    if (widget.title.toLowerCase() == 'added employees') {
      selectedView = 'Add-employee-name';
    } else if (widget.title.toLowerCase() == 'added applications') {
      selectedView = 'Add-app-name';
    }

    // Fetch tasks on screen load
    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  // Method to fetch data
  void _fetchData() {
    // Fetch employee names with full models (to get IDs)
    context.read<EmployeeNameProvider>().fetchAllEmployeeNames();
    // Fetch app names with full models (to get IDs)
    context.read<AppNameProvider>().fetchAllAppNames();
  }

  @override
  Widget build(BuildContext context) {
    // Use full models instead of just strings to access IDs
    final employeeNames = context.watch<EmployeeNameProvider>().employeeNames;
    final appNames = context.watch<AppNameProvider>().appNames;

    // Check if we should show only one list
    bool isAddedEmployees = widget.title.toLowerCase() == 'added employees';
    bool isAddedApplications =
        widget.title.toLowerCase() == 'added applications';

    return Scaffold(
      appBar: AppBar(
        title: Text(currentTitle, style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          //add app and user button
          IconButton(
            icon: Padding(
              padding: const EdgeInsets.all(8.0),
              child: const Icon(Icons.add, color: Colors.blue, size: 24),
            ),
            onPressed: () {
              //show dialog
              var radioOptionsList = ['Add-app-name', 'Add-employee-name'];
              CustomReusableDialog.show(
                context: context,
                title: 'Add: (app-name / employee-name)',
                radioOptions: radioOptionsList,
                initialSelectedOption: selectedView,
                textFieldLabelBuilder: (selectedOption) {
                  return selectedOption == 'Add-app-name'
                      ? 'Enter App Name'
                      : 'Enter Employee Name';
                },
                initialTextValue: '',
                onSave: (selectedOption, textValue) async {
                  log('Selected: $selectedOption');
                  log('Text: $textValue');

                  switch (selectedOption) {
                    case 'Add-app-name':
                      await context.read<AppNameProvider>().addAppName(
                        textValue,
                      );
                      setState(() {
                        selectedView = 'Add-app-name';
                        currentTitle = 'Added Applications';
                      });
                      // Refresh the list after adding
                      _fetchData();
                      ReusableToast.showToast(
                        message: 'App name $textValue added successfully',
                        bgColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16,
                      );
                      break;
                    case 'Add-employee-name':
                      await context
                          .read<EmployeeNameProvider>()
                          .addEmployeeName(textValue);
                      setState(() {
                        selectedView = 'Add-employee-name';
                        currentTitle = 'Added Employees';
                      });
                      // Refresh the list after adding
                      _fetchData();
                      ReusableToast.showToast(
                        message: 'Employee name $textValue added successfully',
                        bgColor: Colors.green,
                        textColor: Colors.white,
                        fontSize: 16,
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
        ],
      ),
      body: Column(
        children: [
          // Toggle buttons to switch between views (hidden if coming from specific menu)
          if (!isAddedEmployees && !isAddedApplications)
            Container(
              padding: EdgeInsets.all(16),
              child: Row(
                children: [
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedView = 'Add-app-name';
                          currentTitle = 'Added Applications';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedView == 'Add-app-name'
                            ? Colors.blue
                            : Colors.grey[300],
                        foregroundColor: selectedView == 'Add-app-name'
                            ? Colors.white
                            : Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('App Names'),
                    ),
                  ),
                  SizedBox(width: 16),
                  Expanded(
                    child: ElevatedButton(
                      onPressed: () {
                        setState(() {
                          selectedView = 'Add-employee-name';
                          currentTitle = 'Added Employees';
                        });
                      },
                      style: ElevatedButton.styleFrom(
                        backgroundColor: selectedView == 'Add-employee-name'
                            ? Colors.blue
                            : Colors.grey[300],
                        foregroundColor: selectedView == 'Add-employee-name'
                            ? Colors.white
                            : Colors.black,
                        padding: EdgeInsets.symmetric(vertical: 12),
                      ),
                      child: Text('Employee Names'),
                    ),
                  ),
                ],
              ),
            ),

          // Conditional list display
          Expanded(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 16.0),
              child: isAddedEmployees
                  ? _buildEmployeeNamesList(employeeNames)
                  : isAddedApplications
                  ? _buildAppNamesList(appNames)
                  : (selectedView == 'Add-app-name'
                        ? _buildAppNamesList(appNames)
                        : _buildEmployeeNamesList(employeeNames)),
            ),
          ),
        ],
      ),
    );
  }

  // Build App Names List
  Widget _buildAppNamesList(List<dynamic> appNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'App Names',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: appNames.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.apps, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'No app names added yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap the + button to add an app',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: appNames.length,
                  itemBuilder: (context, index) {
                    final appName = appNames[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 8),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.blue,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          appName.appName,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteConfirmation(
                              context,
                              'app',
                              appName.appName,
                              appName
                                  .id, // Pass the document ID instead of index
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  // Build Employee Names List
  Widget _buildEmployeeNamesList(List<dynamic> employeeNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          'Employee Names',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: Colors.blue,
          ),
        ),
        SizedBox(height: 10),
        Expanded(
          child: employeeNames.isEmpty
              ? Center(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(Icons.person, size: 64, color: Colors.grey[400]),
                      SizedBox(height: 16),
                      Text(
                        'No employee names added yet',
                        style: TextStyle(fontSize: 16, color: Colors.grey),
                      ),
                      SizedBox(height: 8),
                      Text(
                        'Tap the + button to add an employee',
                        style: TextStyle(fontSize: 14, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                )
              : ListView.builder(
                  itemCount: employeeNames.length,
                  itemBuilder: (context, index) {
                    final employeeName = employeeNames[index];
                    return Card(
                      margin: EdgeInsets.only(bottom: 8),
                      elevation: 2,
                      child: ListTile(
                        leading: CircleAvatar(
                          backgroundColor: Colors.green,
                          child: Text(
                            '${index + 1}',
                            style: TextStyle(
                              color: Colors.white,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        title: Text(
                          employeeName.employeeName,
                          style: TextStyle(fontSize: 16),
                        ),
                        trailing: IconButton(
                          icon: Icon(Icons.delete, color: Colors.red),
                          onPressed: () {
                            _showDeleteConfirmation(
                              context,
                              'employee',
                              employeeName.employeeName,
                              employeeName
                                  .id, // Pass the document ID instead of index
                            );
                          },
                        ),
                      ),
                    );
                  },
                ),
        ),
      ],
    );
  }

  void _showDeleteConfirmation(
    BuildContext context,
    String type,
    String name,
    String id, // Changed from int index to String id
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text('Delete ${type == 'app' ? 'App' : 'Employee'} Name'),
          content: Text('Are you sure you want to delete "$name"?'),
          actions: [
            TextButton(
              child: Text('Cancel'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            TextButton(
              child: Text('Delete', style: TextStyle(color: Colors.red)),
              onPressed: () async {
                if (type == 'app') {
                  // Pass document ID instead of index
                  await context.read<AppNameProvider>().deleteAppName(id);
                } else {
                  // Pass document ID instead of index
                  await context.read<EmployeeNameProvider>().deleteEmployeeName(
                    id,
                  );
                }
                Navigator.of(context).pop();
                // Refresh the list after deleting
                _fetchData();
                ReusableToast.showToast(
                  message: '$name deleted successfully',
                  bgColor: Colors.red,
                  textColor: Colors.white,
                  fontSize: 16,
                );
              },
            ),
          ],
        );
      },
    );
  }
}
