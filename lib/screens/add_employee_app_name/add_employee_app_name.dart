import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:task_app/common_widgets/custom_widgets/custom_reusable_dialog.dart';
import 'package:task_app/common_widgets/resuable_widgets/reusable_toast.dart';
import 'package:task_app/controller/app_name_provider.dart';
import 'package:task_app/controller/employee_name_provider.dart';

class AddEmployeeAppName extends StatefulWidget {
  final String title;
  const AddEmployeeAppName({super.key, required this.title});

  @override
  State<AddEmployeeAppName> createState() => _AddEmployeeAppNameState();
}

class _AddEmployeeAppNameState extends State<AddEmployeeAppName>
    with SingleTickerProviderStateMixin {
  String selectedView = 'Add-app-name';
  late String currentTitle;
  late AnimationController _animationController;
  late Animation<double> _fadeAnimation;
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();

    // Initialize animation controller
    _animationController = AnimationController(
      duration: const Duration(milliseconds: 300),
      vsync: this,
    );

    _fadeAnimation = CurvedAnimation(
      parent: _animationController,
      curve: Curves.easeInOut,
    );

    currentTitle = widget.title;

    if (widget.title.toLowerCase() == 'added employees') {
      selectedView = 'Add-employee-name';
    } else if (widget.title.toLowerCase() == 'added applications') {
      selectedView = 'Add-app-name';
    }

    WidgetsBinding.instance.addPostFrameCallback((_) {
      _fetchData();
    });
  }

  @override
  void dispose() {
    _animationController.dispose();
    super.dispose();
  }

  void _fetchData() async {
    setState(() => _isLoading = true);

    await Future.wait([
      context.read<EmployeeNameProvider>().fetchAllEmployeeNames(),
      context.read<AppNameProvider>().fetchAllAppNames(),
    ]);

    setState(() => _isLoading = false);
    _animationController.forward();
  }

  @override
  Widget build(BuildContext context) {
    final employeeNames = context.watch<EmployeeNameProvider>().employeeNames;
    final appNames = context.watch<AppNameProvider>().appNames;

    bool isAddedEmployees = widget.title.toLowerCase() == 'added employees';
    bool isAddedApplications =
        widget.title.toLowerCase() == 'added applications';

    return Scaffold(
      backgroundColor: Colors.grey[50],
      appBar: AppBar(
        elevation: 0,
        backgroundColor: Colors.white,
        title: Text(
          currentTitle,
          style: const TextStyle(
            color: Color(0xFF2196F3),
            fontWeight: FontWeight.w600,
            fontSize: 20,
          ),
        ),
        iconTheme: const IconThemeData(color: Color(0xFF2196F3)),
        actions: [
          Container(
            margin: const EdgeInsets.only(right: 8),
            child: Material(
              color: const Color(0xFF2196F3),
              borderRadius: BorderRadius.circular(12),
              child: InkWell(
                borderRadius: BorderRadius.circular(12),
                onTap: _showAddDialog,
                child: Container(
                  padding: const EdgeInsets.all(10),
                  child: const Icon(
                    Icons.add_rounded,
                    color: Colors.white,
                    size: 24,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
      body: _isLoading
          ? _buildLoadingState()
          : FadeTransition(
              opacity: _fadeAnimation,
              child: Column(
                children: [
                  if (!isAddedEmployees && !isAddedApplications)
                    _buildToggleButtons(),
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
            ),
    );
  }

  Widget _buildLoadingState() {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          const CircularProgressIndicator(
            valueColor: AlwaysStoppedAnimation<Color>(Color(0xFF2196F3)),
          ),
          const SizedBox(height: 16),
          Text(
            'Loading...',
            style: TextStyle(
              fontSize: 16,
              color: Colors.grey[600],
              fontWeight: FontWeight.w500,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButtons() {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(4),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Row(
        children: [
          Expanded(
            child: _buildToggleButton(
              'App Names',
              'Add-app-name',
              Icons.apps_rounded,
            ),
          ),
          const SizedBox(width: 4),
          Expanded(
            child: _buildToggleButton(
              'Employee Names',
              'Add-employee-name',
              Icons.people_rounded,
            ),
          ),
        ],
      ),
    );
  }

  Widget _buildToggleButton(String label, String view, IconData icon) {
    final isSelected = selectedView == view;
    return AnimatedContainer(
      duration: const Duration(milliseconds: 200),
      child: Material(
        color: isSelected ? const Color(0xFF2196F3) : Colors.transparent,
        borderRadius: BorderRadius.circular(8),
        child: InkWell(
          borderRadius: BorderRadius.circular(8),
          onTap: () {
            setState(() {
              selectedView = view;
              currentTitle = view == 'Add-app-name'
                  ? 'Added Applications'
                  : 'Added Employees';
            });
            _animationController.reset();
            _animationController.forward();
          },
          child: Container(
            padding: const EdgeInsets.symmetric(vertical: 12),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Icon(
                  icon,
                  size: 18,
                  color: isSelected ? Colors.white : Colors.grey[600],
                ),
                const SizedBox(width: 8),
                Text(
                  label,
                  style: TextStyle(
                    color: isSelected ? Colors.white : Colors.grey[600],
                    fontWeight: isSelected ? FontWeight.w600 : FontWeight.w500,
                    fontSize: 14,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildAppNamesList(List<dynamic> appNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.apps_rounded,
                  color: Color(0xFF2196F3),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'App Names',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF2196F3),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF2196F3).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${appNames.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF2196F3),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: appNames.isEmpty
              ? _buildEmptyState(
                  icon: Icons.apps_rounded,
                  title: 'No app names added yet',
                  subtitle: 'Tap the + button to add your first app',
                  color: const Color(0xFF2196F3),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: appNames.length,
                  itemBuilder: (context, index) {
                    final appName = appNames[index];
                    return _buildAnimatedListItem(
                      index: index,
                      child: _buildAppCard(appName, index),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildEmployeeNamesList(List<dynamic> employeeNames) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(vertical: 16),
          child: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.people_rounded,
                  color: Color(0xFF4CAF50),
                  size: 20,
                ),
              ),
              const SizedBox(width: 12),
              const Text(
                'Employee Names',
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.bold,
                  color: Color(0xFF4CAF50),
                ),
              ),
              const Spacer(),
              Container(
                padding: const EdgeInsets.symmetric(
                  horizontal: 12,
                  vertical: 6,
                ),
                decoration: BoxDecoration(
                  color: const Color(0xFF4CAF50).withOpacity(0.1),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  '${employeeNames.length}',
                  style: const TextStyle(
                    fontSize: 14,
                    fontWeight: FontWeight.bold,
                    color: Color(0xFF4CAF50),
                  ),
                ),
              ),
            ],
          ),
        ),
        Expanded(
          child: employeeNames.isEmpty
              ? _buildEmptyState(
                  icon: Icons.person_add_rounded,
                  title: 'No employee names added yet',
                  subtitle: 'Tap the + button to add your first employee',
                  color: const Color(0xFF4CAF50),
                )
              : ListView.builder(
                  physics: const BouncingScrollPhysics(),
                  itemCount: employeeNames.length,
                  itemBuilder: (context, index) {
                    final employeeName = employeeNames[index];
                    return _buildAnimatedListItem(
                      index: index,
                      child: _buildEmployeeCard(employeeName, index),
                    );
                  },
                ),
        ),
      ],
    );
  }

  Widget _buildAnimatedListItem({required int index, required Widget child}) {
    return TweenAnimationBuilder<double>(
      tween: Tween(begin: 0.0, end: 1.0),
      duration: Duration(milliseconds: 300 + (index * 50)),
      curve: Curves.easeOutCubic,
      builder: (context, value, child) {
        return Transform.translate(
          offset: Offset(0, 20 * (1 - value)),
          child: Opacity(opacity: value, child: child),
        );
      },
      child: child,
    );
  }

  Widget _buildAppCard(dynamic appName, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle tap if needed
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF2196F3), Color(0xFF1976D2)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF2196F3).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        appName.appName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Application',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      _showDeleteConfirmation(
                        context,
                        'app',
                        appName.appName,
                        appName.id,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmployeeCard(dynamic employeeName, int index) {
    return Container(
      margin: const EdgeInsets.only(bottom: 12),
      decoration: BoxDecoration(
        color: Colors.white,
        borderRadius: BorderRadius.circular(12),
        boxShadow: [
          BoxShadow(
            color: Colors.black.withOpacity(0.05),
            blurRadius: 10,
            offset: const Offset(0, 2),
          ),
        ],
      ),
      child: Material(
        color: Colors.transparent,
        child: InkWell(
          borderRadius: BorderRadius.circular(12),
          onTap: () {
            // Handle tap if needed
          },
          child: Padding(
            padding: const EdgeInsets.all(12),
            child: Row(
              children: [
                Container(
                  width: 48,
                  height: 48,
                  decoration: BoxDecoration(
                    gradient: const LinearGradient(
                      colors: [Color(0xFF4CAF50), Color(0xFF388E3C)],
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                    ),
                    borderRadius: BorderRadius.circular(12),
                    boxShadow: [
                      BoxShadow(
                        color: const Color(0xFF4CAF50).withOpacity(0.3),
                        blurRadius: 8,
                        offset: const Offset(0, 4),
                      ),
                    ],
                  ),
                  child: Center(
                    child: Text(
                      '${index + 1}',
                      style: const TextStyle(
                        color: Colors.white,
                        fontWeight: FontWeight.bold,
                        fontSize: 18,
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        employeeName.employeeName,
                        style: const TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Color(0xFF212121),
                        ),
                      ),
                      const SizedBox(height: 2),
                      Text(
                        'Employee',
                        style: TextStyle(fontSize: 12, color: Colors.grey[600]),
                      ),
                    ],
                  ),
                ),
                Material(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                  child: InkWell(
                    borderRadius: BorderRadius.circular(8),
                    onTap: () {
                      _showDeleteConfirmation(
                        context,
                        'employee',
                        employeeName.employeeName,
                        employeeName.id,
                      );
                    },
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      child: const Icon(
                        Icons.delete_outline_rounded,
                        color: Colors.red,
                        size: 22,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _buildEmptyState({
    required IconData icon,
    required String title,
    required String subtitle,
    required Color color,
  }) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Container(
            padding: const EdgeInsets.all(24),
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, size: 64, color: color.withOpacity(0.6)),
          ),
          const SizedBox(height: 24),
          Text(
            title,
            style: TextStyle(
              fontSize: 18,
              fontWeight: FontWeight.w600,
              color: Colors.grey[800],
            ),
          ),
          const SizedBox(height: 8),
          Text(
            subtitle,
            style: TextStyle(fontSize: 14, color: Colors.grey[600]),
            textAlign: TextAlign.center,
          ),
        ],
      ),
    );
  }

  void _showAddDialog() {
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
            await context.read<AppNameProvider>().addAppName(textValue);
            setState(() {
              selectedView = 'Add-app-name';
              currentTitle = 'Added Applications';
            });
            _fetchData();
            ReusableToast.showToast(
              message: 'App name $textValue added successfully',
              bgColor: Colors.green,
              textColor: Colors.white,
              fontSize: 16,
            );
            break;
          case 'Add-employee-name':
            await context.read<EmployeeNameProvider>().addEmployeeName(
              textValue,
            );
            setState(() {
              selectedView = 'Add-employee-name';
              currentTitle = 'Added Employees';
            });
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
  }

  void _showDeleteConfirmation(
    BuildContext context,
    String type,
    String name,
    String id,
  ) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(16),
          ),
          title: Row(
            children: [
              Container(
                padding: const EdgeInsets.all(8),
                decoration: BoxDecoration(
                  color: Colors.red.withOpacity(0.1),
                  borderRadius: BorderRadius.circular(8),
                ),
                child: const Icon(
                  Icons.delete_outline_rounded,
                  color: Colors.red,
                  size: 24,
                ),
              ),
              const SizedBox(width: 12),
              Text(
                'Delete ${type == 'app' ? 'App' : 'Employee'}',
                style: const TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ],
          ),
          content: Text(
            'Are you sure you want to delete "$name"? This action cannot be undone.',
            style: TextStyle(fontSize: 14, color: Colors.grey[700]),
          ),
          actions: [
            TextButton(
              child: Text(
                'Cancel',
                style: TextStyle(
                  color: Colors.grey[600],
                  fontWeight: FontWeight.w600,
                ),
              ),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.red,
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(8),
                ),
                padding: const EdgeInsets.symmetric(
                  horizontal: 20,
                  vertical: 12,
                ),
              ),
              child: const Text(
                'Delete',
                style: TextStyle(fontWeight: FontWeight.w600),
              ),
              onPressed: () async {
                if (type == 'app') {
                  await context.read<AppNameProvider>().deleteAppName(id);
                } else {
                  await context.read<EmployeeNameProvider>().deleteEmployeeName(
                    id,
                  );
                }
                Navigator.of(context).pop();
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
