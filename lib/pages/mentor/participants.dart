import 'package:flutter/material.dart';
import 'package:le_mentor/models/classe.dart';


class ParticipantsMentor extends StatefulWidget {
  const ParticipantsMentor({Key? key , required this.classe}) : super(key: key);

  final Classe classe;
  @override
  State<ParticipantsMentor> createState() => _ParticipantsMentorState();
}

class _ParticipantsMentorState extends State<ParticipantsMentor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          Text("Participants"),
        ],
      ),
    );
  }
}
