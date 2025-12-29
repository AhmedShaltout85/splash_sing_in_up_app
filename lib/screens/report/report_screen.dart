import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:provider/provider.dart';
import 'package:splash_sing_in_up_app/controller/app_name_provider.dart';
import 'package:splash_sing_in_up_app/controller/employee_name_provider.dart';
import 'package:splash_sing_in_up_app/controller/task_providers.dart';
import 'package:splash_sing_in_up_app/models/task.dart';

class ReportScreen extends StatefulWidget {
  const ReportScreen({super.key});

  @override
  State<ReportScreen> createState() => _ReportScreenState();
}

class _ReportScreenState extends State<ReportScreen> {
  DateTime? startDate;
  DateTime? endDate;
  String? selectedAssignee;
  String? selectedApplication;
  String? selectedStatus;

  // Status options list
  final List<String> statusList = ['All', 'Pending', 'Completed'];

  @override
  void initState() {
    super.initState();
    selectedAssignee = 'All';
    selectedApplication = 'All';
    selectedStatus = 'All';

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

  Future<void> _selectDate(BuildContext context, bool isStartDate) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2020),
      lastDate: DateTime(2030),
      builder: (context, child) {
        return Theme(
          data: Theme.of(context).copyWith(
            colorScheme: ColorScheme.light(
              primary: Colors.blue,
              onPrimary: Colors.white,
            ),
          ),
          child: child!,
        );
      },
    );

    if (picked != null) {
      setState(() {
        if (isStartDate) {
          startDate = picked;
        } else {
          endDate = picked;
        }
      });
    }
  }

  List<Task> getFilteredData(List<Task> tasks) {
    return tasks.where((task) {
      bool matchesDate = true;
      bool matchesAssignee = true;
      bool matchesApplication = true;
      bool matchesStatus = true;

      // Date filter - using task object properties
      if (startDate != null || endDate != null) {
        DateTime? taskDate = task.createdAt;

        if (startDate != null && taskDate.isBefore(startDate!)) {
          matchesDate = false;
        }
        if (endDate != null &&
            taskDate.isAfter(endDate!.add(Duration(days: 1)))) {
          matchesDate = false;
        }
      }

      // Assignee filter - using task object properties
      if (selectedAssignee != null && selectedAssignee != 'All') {
        matchesAssignee = task.assignedTo == selectedAssignee;
      }

      // Application filter - using task object properties
      if (selectedApplication != null && selectedApplication != 'All') {
        matchesApplication = task.applicationName == selectedApplication;
      }

      // Status filter - using task object properties
      if (selectedStatus != null && selectedStatus != 'All') {
        String taskStatusString = task.taskStatus ? 'Pending' : 'Completed';
        matchesStatus = taskStatusString == selectedStatus;
      }

      return matchesDate &&
          matchesAssignee &&
          matchesApplication &&
          matchesStatus;
    }).toList();
  }

  Future<void> _generatePDF(List<Task> filteredData) async {
    final pdf = pw.Document();

    // Load a font that supports Unicode (using system font)
    final font = await PdfGoogleFonts.notoSansRegular();
    final fontBold = await PdfGoogleFonts.notoSansBold();

    pdf.addPage(
      pw.MultiPage(
        pageFormat: PdfPageFormat.a4,
        margin: pw.EdgeInsets.all(32),
        theme: pw.ThemeData.withFont(base: font, bold: fontBold),
        build: (pw.Context context) {
          return [
            pw.Header(
              level: 0,
              child: pw.Text(
                'Activities Report',
                style: pw.TextStyle(
                  fontSize: 24,
                  fontWeight: pw.FontWeight.bold,
                ),
              ),
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Generated on: ${DateFormat('yyyy-MM-dd HH:mm').format(DateTime.now())}',
              style: pw.TextStyle(fontSize: 12, color: PdfColors.grey700),
            ),
            pw.SizedBox(height: 10),
            if (startDate != null || endDate != null)
              pw.Text(
                'Date Range: ${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate!) : 'N/A'} to ${endDate != null ? DateFormat('yyyy-MM-dd').format(endDate!) : 'N/A'}',
                style: pw.TextStyle(fontSize: 12),
              ),
            if (selectedAssignee != null && selectedAssignee != 'All')
              pw.Text(
                'Assignee: $selectedAssignee',
                style: pw.TextStyle(fontSize: 12),
              ),
            if (selectedApplication != null && selectedApplication != 'All')
              pw.Text(
                'Application Name: $selectedApplication',
                style: pw.TextStyle(fontSize: 12),
              ),
            if (selectedStatus != null && selectedStatus != 'All')
              pw.Text(
                'Status: $selectedStatus',
                style: pw.TextStyle(fontSize: 12),
              ),
            pw.SizedBox(height: 20),
            pw.Table(
              border: pw.TableBorder.all(color: PdfColors.grey400),
              children: [
                pw.TableRow(
                  decoration: pw.BoxDecoration(color: PdfColors.blue100),
                  children: [
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Date',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Task',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Assignee',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Application',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                    pw.Padding(
                      padding: pw.EdgeInsets.all(8),
                      child: pw.Text(
                        'Status',
                        style: pw.TextStyle(fontWeight: pw.FontWeight.bold),
                      ),
                    ),
                  ],
                ),
                ...filteredData.map((task) {
                  String date = 'N/A';
                  DateTime? taskDate = task.createdAt;
                  date = DateFormat('yyyy-MM-dd').format(taskDate);

                  String status = task.taskStatus ? 'Pending' : 'Completed';

                  return pw.TableRow(
                    children: [
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(date),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(task.taskTitle),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(task.assignedTo),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(task.applicationName),
                      ),
                      pw.Padding(
                        padding: pw.EdgeInsets.all(8),
                        child: pw.Text(status),
                      ),
                    ],
                  );
                }),
              ],
            ),
            pw.SizedBox(height: 20),
            pw.Text(
              'Total Records: ${filteredData.length}',
              style: pw.TextStyle(fontSize: 12, fontWeight: pw.FontWeight.bold),
            ),
          ];
        },
      ),
    );

    await Printing.layoutPdf(
      onLayout: (PdfPageFormat format) async => pdf.save(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Reports', style: TextStyle(color: Colors.blue)),
        iconTheme: IconThemeData(color: Colors.blue),
        actions: [
          Consumer<TaskProviders>(
            builder: (context, taskProvider, child) {
              final filteredData = getFilteredData(taskProvider.tasks);
              return IconButton(
                icon: Icon(Icons.download, color: Colors.blue),
                onPressed: filteredData.isEmpty
                    ? null
                    : () => _generatePDF(filteredData),
                tooltip: 'Download PDF',
              );
            },
          ),
        ],
      ),
      body: Consumer3<TaskProviders, EmployeeNameProvider, AppNameProvider>(
        builder: (context, taskProvider, employeeProvider, appProvider, child) {
          final tasks = taskProvider.tasks;
          final employeeNames = employeeProvider.employeeNameStrings;
          final appNames = appProvider.appNameStrings;
          final filteredData = getFilteredData(tasks);

          // Create dropdown lists with "All" option
          final assigneeList = ['All', ...employeeNames];
          final List<String> applicationList = ['All', ...appNames];

          // Check if providers are loading
          final isLoading =
              taskProvider.isLoading ||
              employeeProvider.isLoading ||
              appProvider.isLoading;

          if (isLoading) {
            return Center(child: CircularProgressIndicator(color: Colors.blue));
          }

          return Column(
            children: [
              // Search Filters Container
              Container(
                padding: EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.grey[100],
                  boxShadow: [
                    BoxShadow(
                      color: Colors.grey.withOpacity(0.2),
                      spreadRadius: 1,
                      blurRadius: 5,
                      offset: Offset(0, 2),
                    ),
                  ],
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Text(
                      'Search Filters',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.bold,
                        color: Colors.blue,
                      ),
                    ),
                    SizedBox(height: 16),
                    // Date Range Selection
                    Row(
                      children: [
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context, true),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'Start Date',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.blue,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                startDate != null
                                    ? DateFormat(
                                        'yyyy-MM-dd',
                                      ).format(startDate!)
                                    : 'Select Date',
                                style: TextStyle(
                                  color: startDate != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: InkWell(
                            onTap: () => _selectDate(context, false),
                            child: InputDecorator(
                              decoration: InputDecoration(
                                labelText: 'End Date',
                                border: OutlineInputBorder(),
                                prefixIcon: Icon(
                                  Icons.calendar_today,
                                  color: Colors.blue,
                                ),
                                contentPadding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 12,
                                ),
                              ),
                              child: Text(
                                endDate != null
                                    ? DateFormat('yyyy-MM-dd').format(endDate!)
                                    : 'Select Date',
                                style: TextStyle(
                                  color: endDate != null
                                      ? Colors.black
                                      : Colors.grey,
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    // First Row: Assignee and Application dropdowns
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue:
                                assigneeList.contains(selectedAssignee)
                                ? selectedAssignee
                                : 'All',
                            decoration: InputDecoration(
                              labelText: 'Assigned To',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.person,
                                color: Colors.blue,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            items: assigneeList.map((String assignee) {
                              return DropdownMenuItem<String>(
                                value: assignee,
                                child: Text(assignee),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedAssignee = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 12),
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue:
                                applicationList.contains(selectedApplication)
                                ? selectedApplication
                                : 'All',
                            decoration: InputDecoration(
                              labelText: 'Application Name',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(Icons.apps, color: Colors.blue),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            items: applicationList.map((String app) {
                              return DropdownMenuItem<String>(
                                value: app,
                                child: Text(app),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedApplication = newValue;
                              });
                            },
                          ),
                        ),
                      ],
                    ),
                    SizedBox(height: 16),
                    //                     // Status Dropdown
                    Row(
                      children: [
                        Expanded(
                          child: DropdownButtonFormField<String>(
                            initialValue: statusList.contains(selectedStatus)
                                ? selectedStatus
                                : 'All',
                            decoration: InputDecoration(
                              labelText: 'Task Status',
                              border: OutlineInputBorder(),
                              prefixIcon: Icon(
                                Icons.info_outline,
                                color: Colors.blue,
                              ),
                              contentPadding: EdgeInsets.symmetric(
                                horizontal: 12,
                                vertical: 12,
                              ),
                            ),
                            items: statusList.map((String status) {
                              return DropdownMenuItem<String>(
                                value: status,
                                child: Row(
                                  children: [
                                    if (status != 'All')
                                      Container(
                                        width: 12,
                                        height: 12,
                                        margin: EdgeInsets.only(right: 8),
                                        decoration: BoxDecoration(
                                          shape: BoxShape.circle,
                                          color: _getStatusColor(status),
                                        ),
                                      ),
                                    Text(status),
                                  ],
                                ),
                              );
                            }).toList(),
                            onChanged: (String? newValue) {
                              setState(() {
                                selectedStatus = newValue;
                              });
                            },
                          ),
                        ),
                        SizedBox(width: 12),

                        // Clear Filters Button
                        Expanded(
                          child: SizedBox(
                            height: 45,
                            child: ElevatedButton.icon(
                              onPressed: () {
                                setState(() {
                                  startDate = null;
                                  endDate = null;
                                  selectedAssignee = 'All';
                                  selectedApplication = 'All';
                                  selectedStatus = 'All';
                                });
                              },
                              icon: Icon(Icons.clear),
                              label: Text('Clear Filters'),
                              style: ElevatedButton.styleFrom(
                                backgroundColor: Colors.blue,
                                foregroundColor: Colors.white,
                                padding: EdgeInsets.symmetric(vertical: 12),
                                shape: RoundedRectangleBorder(
                                  borderRadius: BorderRadius.circular(8),
                                ),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              // Results Section
              Expanded(
                child: filteredData.isEmpty
                    ? Center(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Icon(
                              Icons.search_off,
                              size: 64,
                              color: Colors.grey,
                            ),
                            SizedBox(height: 16),
                            Text(
                              'No results found',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.grey,
                              ),
                            ),
                          ],
                        ),
                      )
                    : ListView.builder(
                        padding: EdgeInsets.all(16),
                        itemCount: filteredData.length,
                        itemBuilder: (context, index) {
                          final task = filteredData[index];

                          // Access task properties directly using dot notation
                          String taskName = task.taskTitle;
                          String assignee = task.assignedTo;
                          String appName = task.applicationName;
                          String status = task.taskStatus
                              ? 'Pending'
                              : 'Completed';

                          String date = 'N/A';
                          DateTime? taskDate = task.createdAt;
                          date = DateFormat('yyyy-MM-dd').format(taskDate);

                          return Card(
                            margin: EdgeInsets.only(bottom: 12),
                            elevation: 2,
                            child: ListTile(
                              contentPadding: EdgeInsets.all(16),
                              title: Text(
                                taskName,
                                style: TextStyle(
                                  fontWeight: FontWeight.bold,
                                  fontSize: 16,
                                ),
                              ),
                              subtitle: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  SizedBox(height: 8),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.apps,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(child: Text(appName)),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.person,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 4),
                                      Expanded(child: Text(assignee)),
                                    ],
                                  ),
                                  SizedBox(height: 4),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.calendar_today,
                                        size: 16,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(width: 4),
                                      Text(date),
                                    ],
                                  ),
                                ],
                              ),
                              trailing: Container(
                                padding: EdgeInsets.symmetric(
                                  horizontal: 12,
                                  vertical: 6,
                                ),
                                decoration: BoxDecoration(
                                  color: _getStatusColor(
                                    status,
                                  ).withOpacity(0.1),
                                  borderRadius: BorderRadius.circular(12),
                                  border: Border.all(
                                    color: _getStatusColor(status),
                                    width: 1,
                                  ),
                                ),
                                child: Text(
                                  status,
                                  style: TextStyle(
                                    color: _getStatusColor(status),
                                    fontWeight: FontWeight.bold,
                                    fontSize: 12,
                                  ),
                                ),
                              ),
                            ),
                          );
                        },
                      ),
              ),
            ],
          );
        },
      ),
    );
  }

  Color _getStatusColor(String status) {
    switch (status.toLowerCase()) {
      case 'completed':
      case 'done':
        return Colors.green;
      case 'in progress':
      case 'ongoing':
        return Colors.orange;
      case 'pending':
        return Colors.blue;
      case 'cancelled':
      case 'failed':
        return Colors.red;
      default:
        return Colors.grey;
    }
  }
}
