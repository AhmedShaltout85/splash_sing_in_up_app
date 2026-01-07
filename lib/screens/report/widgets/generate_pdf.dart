import 'package:intl/intl.dart';
import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'package:task_app/models/task.dart';

Future<void> generatePDF({
  required List<Task> filteredData,
  DateTime? startDate,
  DateTime? endDate,
  String? selectedAssignee,
  String? selectedApplication,
  String? selectedStatus,
}) async {
  final pdf = pw.Document();
  final font = await PdfGoogleFonts.notoSansRegular();
  final fontBold = await PdfGoogleFonts.notoSansBold();
  final double headerFontSize = 8;
  final double contentFontSize = 6;
  final double cellPadding = 5;

  pw.TextStyle headerTextStyle = pw.TextStyle(
    font: fontBold,
    fontSize: headerFontSize,
  );

  pw.TextStyle contentTextStyle = pw.TextStyle(
    font: font,
    fontSize: contentFontSize,
  );

  pdf.addPage(
    pw.MultiPage(
      pageFormat: PdfPageFormat.a4,
      margin: const pw.EdgeInsets.all(32),
      theme: pw.ThemeData.withFont(base: font, bold: fontBold),
      build: (pw.Context context) {
        return [
          pw.Header(
            level: 0,
            child: pw.Text(
              'Activities Report',
              style: pw.TextStyle(fontSize: 24, fontWeight: pw.FontWeight.bold),
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
              'Date Range: ${startDate != null ? DateFormat('yyyy-MM-dd').format(startDate) : 'N/A'} to ${endDate != null ? DateFormat('yyyy-MM-dd').format(endDate) : 'N/A'}',
              style: pw.TextStyle(fontSize: headerFontSize),
            ),
          if (selectedAssignee != null && selectedAssignee != 'All')
            pw.Text(
              'Assignee: $selectedAssignee',
              style: pw.TextStyle(fontSize: headerFontSize),
            ),
          if (selectedApplication != null && selectedApplication != 'All')
            pw.Text(
              'Application Name: $selectedApplication',
              style: pw.TextStyle(fontSize: headerFontSize),
            ),
          if (selectedStatus != null && selectedStatus != 'All')
            pw.Text(
              'Status: $selectedStatus',
              style: pw.TextStyle(fontSize: headerFontSize),
            ),
          pw.SizedBox(height: 20),
          pw.Table(
            border: pw.TableBorder.all(color: PdfColors.grey400),
            children: [
              pw.TableRow(
                decoration: const pw.BoxDecoration(color: PdfColors.blue100),
                children: [
                  headerCell('Date', cellPadding, headerTextStyle),
                  headerCell('Task', cellPadding, headerTextStyle),
                  headerCell('App Name', cellPadding, headerTextStyle),
                  headerCell('Assignee', cellPadding, headerTextStyle),
                  headerCell('Assigned By', cellPadding, headerTextStyle),
                  headerCell('Visited Place', cellPadding, headerTextStyle),
                  headerCell('Status', cellPadding, headerTextStyle),
                  headerCell('Priority', cellPadding, headerTextStyle),
                  headerCell('Co-Operators', cellPadding, headerTextStyle),
                  headerCell('Completed-Date', cellPadding, headerTextStyle),
                ],
              ),
              ...filteredData.map((task) {
                String date = DateFormat('yyyy-MM-dd').format(task.createdAt);
                String status = task.taskStatus ? 'Pending' : 'Completed';
                return pw.TableRow(
                  children: [
                    contentCell(cellPadding, date, contentTextStyle),

                    contentCell(cellPadding, task.taskTitle, contentTextStyle),
                    contentCell(
                      cellPadding,
                      task.applicationName,
                      contentTextStyle,
                    ),
                    contentCell(cellPadding, task.assignedTo, contentTextStyle),
                    contentCell(cellPadding, task.assignedBy, contentTextStyle),
                    contentCell(cellPadding, task.visitPlace, contentTextStyle),
                    contentCell(cellPadding, status, contentTextStyle),
                    contentCell(
                      cellPadding,
                      task.taskPriority,
                      contentTextStyle,
                    ),
                    contentCell(
                      cellPadding,
                      task.coOperator
                          .toString()
                          .replaceAll('[', ' ')
                          .replaceAll(']', ' '),
                      contentTextStyle,
                    ),
                    contentCell(
                      cellPadding,
                      DateFormat(
                        'yyyy-MM-dd',
                      ).format(task.expectedCompletionDate),
                      contentTextStyle,
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

pw.Padding contentCell(
  double cellPadding,
  String label,
  pw.TextStyle contentTextStyle,
) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(cellPadding),
    child: pw.Text(label, style: contentTextStyle),
  );
}

pw.Padding headerCell(
  String label,
  double cellPadding,
  pw.TextStyle headerTextStyle,
) {
  return pw.Padding(
    padding: pw.EdgeInsets.all(cellPadding),
    child: pw.Text(label, style: headerTextStyle),
  );
}
