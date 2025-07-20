import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';

class AddEmployeePage extends StatefulWidget {
  final String? docId; // ถ้ามี แสดงว่าเป็นการแก้ไข
  final Map<String, dynamic>? existingData;

  AddEmployeePage({this.docId, this.existingData});

  @override
  _AddEmployeePageState createState() => _AddEmployeePageState();
}

class _AddEmployeePageState extends State<AddEmployeePage> {
  final TextEditingController _firstNameController = TextEditingController();
  final TextEditingController _lastNameController = TextEditingController();
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _genderController = TextEditingController();

  @override
  void initState() {
    super.initState();
    // ถ้ามีข้อมูลเดิม ให้ใส่ใน TextField
    if (widget.existingData != null) {
      _firstNameController.text = widget.existingData!['first_name'] ?? '';
      _lastNameController.text = widget.existingData!['last_name'] ?? '';
      _emailController.text = widget.existingData!['email'] ?? '';
      _genderController.text = widget.existingData!['gender'] ?? '';
    }
  }

  void _saveEmployee() async {
    final data = {
      'first_name': _firstNameController.text,
      'last_name': _lastNameController.text,
      'email': _emailController.text,
      'gender': _genderController.text,
    };

    if (widget.docId == null) {
      // เพิ่มข้อมูลใหม่
      await FirebaseFirestore.instance.collection('employee').add(data);
    } else {
      // อัปเดตข้อมูลเดิม
      await FirebaseFirestore.instance.collection('employee').doc(widget.docId).update(data);
    }

    Navigator.pop(context); // กลับไปหน้าหลัก
  }

  @override
  Widget build(BuildContext context) {
    final isEditMode = widget.docId != null;

    return Scaffold(
      appBar: AppBar(title: Text(isEditMode ? "Edit Employee" : "Add Employee")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            TextField(
              controller: _firstNameController,
              decoration: InputDecoration(labelText: 'First Name'),
            ),
            TextField(
              controller: _lastNameController,
              decoration: InputDecoration(labelText: 'Last Name'),
            ),
            TextField(
              controller: _emailController,
              decoration: InputDecoration(labelText: 'Email'),
            ),
            TextField(
              controller: _genderController,
              decoration: InputDecoration(labelText: 'Gender'),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: _saveEmployee,
              child: Text(isEditMode ? "Update" : "Save"),
            ),
          ],
        ),
      ),
    );
  }
}
