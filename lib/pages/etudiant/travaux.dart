import 'package:flutter/material.dart';


class TravauxEtudiant extends StatefulWidget {
  const TravauxEtudiant({Key? key}) : super(key: key);

  @override
  State<TravauxEtudiant> createState() => _TravauxEtudiantState();
}

class _TravauxEtudiantState extends State<TravauxEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Travaux"),
        ],
      ),
    );;
  }
}
