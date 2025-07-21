import 'ExampleuiResult.dart';
import 'package:flutter/material.dart';
import 'RegisterData.dart';

class Exampleeui extends StatefulWidget {
  const Exampleeui({super.key});

  @override
  State<Exampleeui> createState() => _ExampleeuiState();
}

class _ExampleeuiState extends State<Exampleeui> {
  final TextEditingController _nameController = TextEditingController();

  String _result = '';
  String _selectedOption = 'IT'; // ค่า default dropdown
  String _gender = 'Male';
  bool _acceptTerm = false;
  DateTime? _selectedDate;

  final List<String> _options = ['IT', 'Digital', 'Network'];

  void _pickDate() async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: DateTime(2000, 1, 1),
      firstDate: DateTime(1900),
      lastDate: DateTime.now(),
    );
    if (picked != null) {
      setState(() {
        _selectedDate = picked;
      });
    }
  }

  void _register() {
    final name = _nameController.text.trim();

    if (name.isEmpty) {
      setState(() {
        _result = "Please fill in all fields.";
      });
    } else {
      setState(() {
        //_result = "Registered: $name ";
        final registerData = RegisterData(
          name: name,
          department: _selectedOption,
          gender: _gender,
          birthday: _selectedDate!,
          acceptTerms: _acceptTerm,
        ); //data
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => ExampleuiResultPage(data: registerData),
          ),
        );
      });
    }
  }

  void _cancel() {
    setState(() {
      _nameController.clear();
      _selectedOption = _options[0];
      _result = '';
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: const Text('Register')),
      // body: Padding(
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const Text("Name:", style: TextStyle(fontSize: 16)),
            TextField(
              controller: _nameController,
              decoration: const InputDecoration(hintText: 'Enter your name'),
            ),
            const SizedBox(height: 16),
            const Text("Department:", style: TextStyle(fontSize: 16)),
            DropdownButton<String>(
              value: _selectedOption,
              isExpanded: true,
              items: _options.map((String value) {
                return DropdownMenuItem<String>(
                  value: value,
                  child: Text(value),
                );
              }).toList(),
              onChanged: (String? newValue) {
                setState(() {
                  _selectedOption = newValue!;
                });
              },
            ),

            const SizedBox(height: 24),
            const Text("Gender:", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Radio<String>(
                  value: 'Male',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                const Text('Male'),

                Radio<String>(
                  value: 'Female',
                  groupValue: _gender,
                  onChanged: (value) {
                    setState(() {
                      _gender = value!;
                    });
                  },
                ),
                const Text('Female'),
              ],
            ),

            const SizedBox(height: 24),
            const Text("Birthday:", style: TextStyle(fontSize: 16)),
            Row(
              children: [
                Text(
                  _selectedDate == null
                      ? 'No date selected'
                      : "${_selectedDate!.day}/${_selectedDate!.month}/${_selectedDate!.year}",
                  style: const TextStyle(fontSize: 16),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _pickDate,
                  child: const Text("Select Date"),
                ),
              ],
            ),
            const SizedBox(height: 24),

            CheckboxListTile(
              title: const Text("I accept the terms and conditions"),
              value: _acceptTerm,
              onChanged: (value) {
                setState(() {
                  _acceptTerm = value!;
                });
              },
              controlAffinity: ListTileControlAffinity.leading,
            ),

            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: _register,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.blue,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Register'),
                ),
                const SizedBox(width: 16),
                ElevatedButton(
                  onPressed: _cancel,
                  style: ElevatedButton.styleFrom(
                    backgroundColor: Colors.grey,
                    foregroundColor: Colors.white,
                  ),
                  child: const Text('Cancel'),
                ),
              ],
            ),

            const SizedBox(height: 24),

            Text(
              _result,
              style: const TextStyle(color: Colors.green, fontSize: 16),
            ),
          ],
        ),
      ),
    );
  }
}
