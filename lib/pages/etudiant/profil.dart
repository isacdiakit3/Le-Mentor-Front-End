import 'package:flutter/material.dart';

class ProfilEtudiant extends StatefulWidget {
  const ProfilEtudiant({Key? key}) : super(key: key);

  @override
  State<ProfilEtudiant> createState() => _ProfilEtudiantState();
}

class _ProfilEtudiantState extends State<ProfilEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profil"),
        ],
      ),
    );
  }
}
