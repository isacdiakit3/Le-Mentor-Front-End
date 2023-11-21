import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_mentor/pages/choix.dart';
import 'package:le_mentor/pages/etudiant/connexion.dart';
import 'package:le_mentor/pages/etudiant/nav_etudiant.dart';
import 'package:le_mentor/pages/mentor/connexion.dart';
import 'package:le_mentor/pages/mentor/nav_mentor.dart';
import 'package:le_mentor/pages/splash.dart';

void main() {
  runApp(const MyApp());
}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      initialRoute: "/",
      routes: {
        "/navEtudiant":(context) => NavEtudiant(),
        "/navMentor":(context) => NavMentor(),
        "/connexionEtudiant":(context) => ConnexionEtudiant(),
        "/connexionMentor":(context) => ConnexionMentor(),
        "/choix":(context) => ChoixPage(),
      },
    );
  }
}
