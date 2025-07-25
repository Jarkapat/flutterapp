import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter_slidable/flutter_slidable.dart';
import 'AddEmployee.dart';

class CRUDAPIPage extends StatelessWidget {
  final CollectionReference employees = FirebaseFirestore.instance.collection('employee');

  void deleteEmployee(String docId) {
    employees.doc(docId).delete();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(title: Text('Employee List')),
      body: StreamBuilder<QuerySnapshot>(
        stream: employees.snapshots(),
        builder: (context, snapshot) {
          if (snapshot.hasError) return Center(child: Text('Error: ${snapshot.error}'));
          if (snapshot.connectionState == ConnectionState.waiting) return Center(child: CircularProgressIndicator());

          final docs = snapshot.data!.docs;

          return ListView.builder(
            itemCount: docs.length,
            itemBuilder: (context, index) {
              final data = docs[index].data() as Map<String, dynamic>;
              final docId = docs[index].id;

              return Container(
                margin: EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                child: Slidable(
                  key: ValueKey(docId),
                  endActionPane: ActionPane(
                    motion: BehindMotion(), // หรือ ScrollMotion ก็ได้
                    extentRatio: 0.5, // 2 ปุ่ม x 0.25 = 0.5
                    children: [
                      SlidableAction(
                        onPressed: (_) {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => AddEmployeePage(
                                docId: docId,
                                existingData: data,
                              ),
                            ),
                          );
                        },
                        backgroundColor: Colors.blue,
                        foregroundColor: Colors.white,
                        icon: Icons.edit,
                        label: 'Edit',
                      ),
                      SlidableAction(
                        onPressed: (_) => deleteEmployee(docId),
                        backgroundColor: Colors.red,
                        foregroundColor: Colors.white,
                        icon: Icons.delete,
                        label: 'Delete',
                      ),
                    ],
                  ),
                  child: Container(
                    padding: EdgeInsets.all(8),
                    decoration: BoxDecoration(
                      border: Border.all(color: Colors.grey, width: 1.5),
                      borderRadius: BorderRadius.circular(8),
                    ),
                    child: ListTile(
                      title: Text("${data['first_name']} ${data['last_name']}"),
                      subtitle: Text(
                        "Email: ${data['email']} \nGender: ${data['gender']}",
                      ),
                      isThreeLine: true,
                    ),
                  ),
                ),
              );
            },
          );
        },
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: () {
          Navigator.push(
            context,
            MaterialPageRoute(builder: (context) => AddEmployeePage()),
          );
        },
        child: Icon(Icons.add),
        tooltip: 'Add Employee',
      ),
    );
  }
}
