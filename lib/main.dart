import 'package:expried_item_app/pages/login_home.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  runApp(const ExpriedApp());
}

class ExpriedApp extends StatefulWidget {
  const ExpriedApp({Key? key}) : super(key: key);

  @override
  State<ExpriedApp> createState() => _ExpriedAppState();
}

class _ExpriedAppState extends State<ExpriedApp> {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: '로그인 창',
      theme: ThemeData(
        primarySwatch: Colors.indigo,
      ),
      home: const LoginHome(),
    );
  }
  @override
  void initState() {
    Firebase.initializeApp();
    super.initState();
  }

  @override
  dispose() async {
    super.dispose();

  }
}