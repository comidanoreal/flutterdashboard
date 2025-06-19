import 'package:flutter/material.dart';
import 'preview_screen.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Dashboard Chat',
      theme: ThemeData(primarySwatch: Colors.blue),
      home: PreviewScreen(),
    );
  }
}

