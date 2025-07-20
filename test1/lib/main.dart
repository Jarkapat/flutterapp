// import 'package:flutter/material.dart';
// import 'ui/Forms/formregis.dart'; 

// void main() {
//   runApp(MyApp());
// }

// class MyApp extends StatelessWidget {
//   @override
//   Widget build(BuildContext context) {
//     return MaterialApp(
//       title: 'Register App',
//       theme: ThemeData(primarySwatch: Colors.deepPurple),
//       home: RegisterForm(), //
//       debugShowCheckedModeBanner: false,
//     );
//   }
// }
import 'package:flutter/foundation.dart'; // สำหรับ kIsWeb
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'ui/condb/CRUDAPI.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  if (kIsWeb) {
    await Firebase.initializeApp(
      options: const FirebaseOptions(
        apiKey: "",
        authDomain: "",
        projectId: "",
        storageBucket: "",
        messagingSenderId: "",
        appId: "",
        measurementId: ""
      ),
    );
  } else {
    await Firebase.initializeApp();
  }

  // await Firebase.initializeApp();
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Firebase CRUD',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: CRUDAPIPage(), // call here
    );
  }
}
