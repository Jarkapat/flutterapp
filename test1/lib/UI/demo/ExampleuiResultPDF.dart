import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'RegisterData.dart';
import 'GenAndPrintPDF.dart';

class ExampleuiResultPage extends StatelessWidget {
  final RegisterData data;

  const ExampleuiResultPage({super.key, required this.data});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result Page")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Text(
          "Name: ${data.name}\n"
          "Department: ${data.department}\n"
          "Gender: ${data.gender}\n"
          "Birthday: ${data.birthday.day}/${data.birthday.month}/${data.birthday.year}\n"
          "Accept Terms: ${data.acceptTerms ? 'Yes' : 'No'}",
          style: const TextStyle(fontSize: 18),
        ),
      ),
      floatingActionButton: SpeedDial(
        icon: Icons.menu,
        activeIcon: Icons.close,
        backgroundColor: Colors.deepPurple,
        foregroundColor: Colors.white,
        children: [
          SpeedDialChild(
            child: const Icon(Icons.save),
            label: 'Save',
            onTap: () {
              ScaffoldMessenger.of(context).showSnackBar(
                const SnackBar(content: Text('Data was recorded to DB')),
              );
            },
          ),
          SpeedDialChild(
            child: const Icon(Icons.picture_as_pdf),
            label: 'export PDF',
            onTap: () async {
              await generateAndPrintPdf(data);
              ScaffoldMessenger.of(
                context,
              ).showSnackBar(const SnackBar(content: Text('PDF was Exported')));
            },
          ),
        ],
      ),
    );
  }
}
