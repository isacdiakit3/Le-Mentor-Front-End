import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_mentor/pages/choix.dart';
import 'package:le_mentor/pages/etudiant/connexion.dart';
import 'package:le_mentor/pages/etudiant/nav_etudiant.dart';
import 'package:le_mentor/pages/mentor/accueil.dart';
import 'package:le_mentor/pages/mentor/form_classe.dart';
import 'dart:async';
import 'mentor/nav_mentor.dart';

class Splash extends StatefulWidget {
  const Splash({Key? key}) : super(key: key);

  @override
  State<Splash> createState() => _SplashState();
}

class _SplashState extends State<Splash> {

  @override
  void initState() {
    super.initState();

    Timer(
      const  Duration(seconds:7),
          () =>
          Navigator.of(context).pushReplacement(
            MaterialPageRoute(
              builder: (_) => const ChoixPage(),
            ),
          ),
    );


  }


  @override
  Widget build(BuildContext context) {

    return Scaffold(
      backgroundColor: Colors.white,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
          Image.asset(
          'assets/images/Group_15.jpg',
        ),
          ],
        ),
      ),
    );
  }
}
