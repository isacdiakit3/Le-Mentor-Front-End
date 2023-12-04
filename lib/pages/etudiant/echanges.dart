import 'package:flutter/material.dart';


class EchangesEtudiant extends StatefulWidget {
  const EchangesEtudiant({Key? key}) : super(key: key);

  @override
  State<EchangesEtudiant> createState() => _EchangesEtudiantState();
}

class _EchangesEtudiantState extends State<EchangesEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Echanges"),
        ],
      ),
    );;
  }
}
