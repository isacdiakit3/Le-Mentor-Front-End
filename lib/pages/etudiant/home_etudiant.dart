import 'package:flutter/material.dart';


class AccueilEtudiant extends StatefulWidget {
  const AccueilEtudiant({Key? key}) : super(key: key);

  @override
  State<AccueilEtudiant> createState() => _AccueilEtudiantState();
}

class _AccueilEtudiantState extends State<AccueilEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text("Accueil"),
        ],
      ),
    );
  }
}
