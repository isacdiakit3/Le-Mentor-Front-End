import 'package:flutter/material.dart';

class MesEtudiants extends StatefulWidget {
  const MesEtudiants({Key? key}) : super(key: key);

  @override
  State<MesEtudiants> createState() => _MesEtudiantsState();
}

class _MesEtudiantsState extends State<MesEtudiants> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text("Mes etudiants")
        ],
      ),
    );
  }
}
