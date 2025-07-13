// main.dart
import 'package:flutter/material.dart';

import 'mytabbar.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      // Hide the debug banner
      debugShowCheckedModeBanner: false,
      title: 'Testing.com',
      // theme: ThemeData.light(),

      // home: const TabsScreen(),
      theme: ThemeData(
        primaryColor: Colors.deepPurple,
        tabBarTheme: TabBarThemeData(
          labelColor: Colors.white,
          unselectedLabelColor: Colors.white70,
          indicator: const UnderlineTabIndicator(
            borderSide: BorderSide(width: 4, color: Colors.purpleAccent),
          ),
        ),
      ),

      home: const MyTabBar(),
    );
  }
}
