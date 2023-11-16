import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_mentor/pages/choix.dart';
import 'package:le_mentor/pages/splash.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash()
    );
  }
}
