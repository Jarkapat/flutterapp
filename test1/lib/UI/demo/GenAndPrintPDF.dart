import 'package:pdf/pdf.dart';
import 'package:pdf/widgets.dart' as pw;
import 'package:printing/printing.dart';
import 'RegisterData.dart'; 

Future<void> generateAndPrintPdf(RegisterData data) async {
  final pdf = pw.Document();

  pdf.addPage(
    pw.Page(
      build: (pw.Context context) => pw.Center(
        child: pw.Column(
          crossAxisAlignment: pw.CrossAxisAlignment.start,
          children: [
            pw.Text("Registration Summary", style: pw.TextStyle(fontSize: 24)),
            pw.SizedBox(height: 16),
            pw.Text("Name: ${data.name}"),
            pw.Text("Department: ${data.department}"),
            pw.Text("Gender: ${data.gender}"),
            pw.Text(
              "Birthday: ${data.birthday.day}/${data.birthday.month}/${data.birthday.year}",
            ),
            pw.Text("Accept Terms: ${data.acceptTerms ? 'Yes' : 'No'}"),
          ],
        ),
      ),
    ),
  );

  // show dialog for saving 
  await Printing.layoutPdf(
    onLayout: (PdfPageFormat format) async => pdf.save(),
  );
}
