import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:cloud_firestore/cloud_firestore.dart'; 
import 'RegisterData.dart';
import 'GenAndPrintPDF.dart';

class ExampleuiResultPage extends StatelessWidget {
  final RegisterData data;

  const ExampleuiResultPage({super.key, required this.data});

  Future<void> _saveToFirestore(BuildContext context) async {
    try {
      await FirebaseFirestore.instance.collection('RegisterData').add({
        'name': data.name,
        'department': data.department,
        'gender': data.gender,
        'birthday': data.birthday.toIso8601String(),
        'acceptTerms': data.acceptTerms,
        'createdAt': FieldValue.serverTimestamp(),
      });
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text('Data saved to Firebase!')),
      );
    } catch (e) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('Error saving data: $e')),
      );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text("Result Page")),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Name: ${data.name}\n"
              "Department: ${data.department}\n"
              "Gender: ${data.gender}\n"
              "Birthday: ${data.birthday.day}/${data.birthday.month}/${data.birthday.year}\n"
              "Accept Terms: ${data.acceptTerms ? 'Yes' : 'No'}",
              style: const TextStyle(fontSize: 18),
            ),
            const SizedBox(height: 30),

            ElevatedButton.icon(
              onPressed: () => _saveToFirestore(context),
              icon: const Icon(Icons.save),
              label: const Text('Save to Database'),
              style: ElevatedButton.styleFrom(
                minimumSize: const Size.fromHeight(50),
                backgroundColor: Colors.deepOrange,
                foregroundColor: Colors.white,
              ),
            ),
          ],
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
            onTap: () => _saveToFirestore(context),  // ใช้ฟังก์ชันเดียวกัน
          ),
          SpeedDialChild(
            child: const Icon(Icons.picture_as_pdf),
            label: 'Export PDF',
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
