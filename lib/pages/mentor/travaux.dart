import 'package:flutter/material.dart';
import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/pages/etudiant/profil.dart';
import 'package:le_mentor/pages/mentor/modal.dart';

import 'form_classe.dart';

class TravauxMentor extends StatefulWidget {
  const TravauxMentor({Key? key ,required this.classe}) : super(key: key);

  final Classe classe;
  @override
  State<TravauxMentor> createState() => _TravauxMentorState();
}

class _TravauxMentorState extends State<TravauxMentor> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          children: [
            Text("Travaux"),
          ],
        ),
      ),
      floatingActionButton: FloatingActionButton(
        onPressed: (){
          showModalBottomSheet(
            enableDrag: false,
              isDismissible: true,
              isScrollControlled: true,
              backgroundColor: Colors.white,
              context: context,
              builder: (context) => Modal(classe: widget.classe,));
         // Navigator.push(context,MaterialPageRoute(builder: (context)=> const FormClasse()));
        },
        backgroundColor: Color(0xFF365E7D),
        child: Icon(Icons.add,color: Color(0xFFEAFD0B)),
      ),
    );

  }
}
