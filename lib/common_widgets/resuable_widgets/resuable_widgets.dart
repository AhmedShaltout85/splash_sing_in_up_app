import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/common_widgets/resuable_widgets/reusable_toast.dart';

import '../../controller/task_providers.dart';
import '../custom_widgets/custom_bottom_sheet.dart';

void showSnackBar(String message, BuildContext context) => ScaffoldMessenger.of(
  context,
).showSnackBar(SnackBar(content: Text(message)));

//navigation function using MaterialPageRoute
void navigateTo(BuildContext context, Widget widget) =>
    Navigator.push(context, MaterialPageRoute(builder: (context) => widget));

//navigation function using pushReplacement
void navigateToReplacement(BuildContext context, Widget widget) =>
    Navigator.pushReplacement(
      context,
      MaterialPageRoute(builder: (context) => widget),
    );

//navigation function using pushNamed
void navigateToReplacementNamed(BuildContext context, String routeName) =>
    Navigator.pushNamed(context, routeName);

Widget gap({double? height, double? width}) =>
    SizedBox(height: height, width: width);

void showCustomBottomSheet({
  required BuildContext context,
  required List<String> appNames,
  required List<String> employeeNames,
}) {
  CustomBottomSheet.show(
    context: context,
    title: 'Task Information',
    fields: [
      TextFieldConfig(
        key: 'title',
        label: 'Task Title',
        hint: 'Enter task title',
        icon: Icons.title,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a task title';
          }
          return null;
        },
      ),
      DropdownFieldConfig(
        key: 'app-name',
        label: 'Enter app name',
        icon: Icons.apps,
        items: appNames,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a app name';
          }
          return null;
        },
      ),

      TextFieldConfig(
        key: 'assign-by',
        label: 'Assign By',
        hint: 'Enter assign by',
        icon: Icons.manage_accounts,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a assign by';
          }
          return null;
        },
      ),

      DropdownFieldConfig(
        key: 'assign-to',
        label: 'Assign To',
        items: employeeNames,
        icon: Icons.person,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select an assignee';
          }
          return null;
        },
      ),

      TextFieldConfig(
        key: 'visit-place',
        label: 'Visit Place',
        hint: 'Enter visit place',
        icon: Icons.location_on,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a visit place';
          }
          return null;
        },
      ),
      DropdownFieldConfig(
        key: 'task-periority',
        label: 'Enter task periority',
        items: ['High', 'Medium', 'Low'],
        icon: Icons.priority_high,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please select a task periority';
          }
          return null;
        },
      ),

      DropdownFieldConfig(
        key: 'co-operator',
        hint: 'Enter co-operator',
        icon: Icons.person,
        items: employeeNames,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a co-operators';
          }
          return null;
        },
        label: 'Co-operator',
      ),
      TextFieldConfig(
        key: 'expected-completion-date',
        label: 'Expected Completion Date',
        hint: 'Enter Expected Completion Date like 7, 15, 30 days',
        icon: Icons.date_range,
        keyboardType: TextInputType.number,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter expected completion date';
          }
          return null;
        },
      ),
      TextFieldConfig(
        key: 'task-note',
        label: 'Task Note',
        hint: 'Enter note',
        icon: Icons.note,
        maxLines: 3,

        keyboardType: TextInputType.multiline,
        validator: (value) {
          if (value == null || value.isEmpty) {
            return 'Please enter a note';
          }
          return null;
        },
      ),
    ],
    submitButtonText: 'Save',
    onSubmit: (values) async {
      log('Form submitted: $values');
      // Handle the submitted values
      try {
        // Don't set 'id' - let Firestore generate it
        await context.read<TaskProviders>().addTask({
          'id': DateTime.now().millisecondsSinceEpoch.toString(),
          'taskTitle': values['title'],
          'applicationName': values['app-name'],
          'taskNote': values['task-note'],
          'assignedBy': values['assign-by'],
          'assignedTo': values['assign-to'],
          'visitPlace': values['visit-place'],
          'taskPeriority': values['task-periority'],
          'coOperator': values['co-operator'],
          'taskStatus': true,
          'expectedCompletionDate': DateTime.now().add(
            Duration(
              days: int.parse(values['expected-completion-date'] as String),
            ),
          ),
          // Don't include createdAt/updatedAt - Firestore handles it
        });
        log('Task added successfully');
        ReusableToast.showToast(
          message: 'Task added successfully',
          bgColor: Colors.green,
          textColor: Colors.white,
          fontSize: 16,
        );
      } catch (e) {
        log('Error adding task: $e');
        ReusableToast.showToast(
          message: 'Error adding task: $e',
          bgColor: Colors.red,
          textColor: Colors.white,
          fontSize: 16,
        );
      }
    },
    onCancel: () {
      // Handle the cancel action
      Navigator.pop(context);
      log('Bottom sheet cancelled');
    },
  );
}
