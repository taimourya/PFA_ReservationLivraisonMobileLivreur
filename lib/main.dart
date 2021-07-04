import 'package:flutter/material.dart';
import 'package:livreur/widgets/CommandeTrouver.dart';
import 'package:livreur/widgets/Home.dart';
import 'package:livreur/widgets/Login.dart';

// @dart=2.9
void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.red,
      ),
      home: Login(),
    );
  }
}