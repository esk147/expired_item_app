import 'package:expried_item_app/pages/main_page.dart';
import 'package:flutter/material.dart';

void main() {
  runApp(const ExpriedApp());
}

class ExpriedApp extends StatelessWidget {
  const ExpriedApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const ExpriedMain(),
    );
  }
}