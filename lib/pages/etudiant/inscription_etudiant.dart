import 'package:flutter/material.dart';


class InscriptionEtudiant extends StatefulWidget {
  const InscriptionEtudiant({Key? key}) : super(key: key);

  @override
  State<InscriptionEtudiant> createState() => _InscriptionEtudiantState();
}

class _InscriptionEtudiantState extends State<InscriptionEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(

      body: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("inscription")
        ],
      ),
    );
  }
}
