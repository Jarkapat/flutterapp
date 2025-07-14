import 'package:flutter/material.dart';

class RegisterForm extends StatefulWidget {
  @override
  _RegisterFormState createState() => _RegisterFormState();
}

class _RegisterFormState extends State<RegisterForm> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _nameController = TextEditingController();

  String? _selectedDepartment;
  String? _gender;
  DateTime? birthday;
  bool _acceptedTerms = false;
  String _statusMessage = '';

  final List<String> _departments = ['IT', 'CS', 'Math', 'Physics'];

  Future<void> selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: birthday ?? DateTime(2025, 7, 7),
      firstDate: DateTime(1800),
      lastDate: DateTime.now(),
    );

    if (picked != null) {
      setState(() {
        birthday = picked;
      });
    }
  }

  void _register() {
    if (_formKey.currentState!.validate() && _acceptedTerms) {
      setState(() {
        _statusMessage = 'Registered: ${_nameController.text}';
      });
    } else {
      setState(() {
        _statusMessage = 'Please complete the form';
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text("Register")),
      body: Padding(
        padding: EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: ListView(
            children: [

              TextFormField(
                controller: _nameController,
                decoration: InputDecoration(labelText: 'Name'),
                validator: (value) => value!.isEmpty ? 'Name required' : null,
              ),
              SizedBox(height: 16),


              DropdownButtonFormField<String>(
                decoration: InputDecoration(labelText: 'Department'),
                value: _selectedDepartment,
                items: _departments.map((dept) {
                  return DropdownMenuItem(
                    value: dept,
                    child: Text(dept),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedDepartment = value;
                  });
                },
                validator: (value) =>
                    value == null ? 'Select department' : null,
              ),
              SizedBox(height: 16),


              Text('Gender'),
              RadioListTile<String>(
                title: Text('Male'),
                value: 'Male',
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
              ),
              RadioListTile<String>(
                title: Text('Female'),
                value: 'Female',
                groupValue: _gender,
                onChanged: (value) => setState(() => _gender = value),
              ),
              SizedBox(height: 16),

              // Birthday
              Row(
                children: [
                  Text(
                    birthday == null
                        ? 'Birthday: not selected'
                        : 'Birthday: ${birthday!.day}/${birthday!.month}/${birthday!.year}',
                  ),
                  Spacer(),
                  ElevatedButton(
                    onPressed: () => selectDate(context),
                    child: Text("Select Date"),
                  ),
                ],
              ),

              // Terms
              CheckboxListTile(
                title: Text("I accept the terms and conditions"),
                value: _acceptedTerms,
                onChanged: (value) {
                  setState(() {
                    _acceptedTerms = value!;
                  });
                },
              ),

              // Buttons
              Row(
                children: [
                  ElevatedButton(
                    onPressed: _register,
                    child: Text("Register"),
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blue,
                      foregroundColor: Colors.white),
                  ),
                  SizedBox(width: 16),
                  ElevatedButton(
                    onPressed: () => Navigator.pop(context),
                    child: Text("Cancel"),
                    style: ElevatedButton.styleFrom(
                        backgroundColor: Colors.grey,
                        foregroundColor: Colors.white),
                  ),
                ],
              ),

              // Status
              SizedBox(height: 16),
              Text(
                _statusMessage,
                style: TextStyle(color: Colors.green),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
