import 'package:flutter/material.dart';
import 'package:mobx_todo/pages/login_page.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Mobx ToDo',
      debugShowCheckedModeBanner: false,
      theme: ThemeData(
        primarySwatch: Colors.deepPurple,
        disabledColor: Colors.grey,
      ),
      home: const LoginPage(),
    );
  }
}