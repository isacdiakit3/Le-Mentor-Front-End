import 'package:flutter/material.dart';


class ParticipantsEtudiant extends StatefulWidget {
  const ParticipantsEtudiant({Key? key}) : super(key: key);

  @override
  State<ParticipantsEtudiant> createState() => _ParticipantsEtudiantState();
}

class _ParticipantsEtudiantState extends State<ParticipantsEtudiant> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Participants"),
        ],
      ),
    );;
  }
}
