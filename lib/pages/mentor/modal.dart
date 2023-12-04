import 'package:flutter/material.dart';
import 'package:le_mentor/pages/mentor/form_devoir.dart';
import 'package:le_mentor/pages/mentor/form_quiz.dart';

import '../../models/classe.dart';


class Modal extends StatefulWidget {
  const Modal({Key? key ,required this.classe}) : super(key: key);

  final Classe classe;
  @override
  State<Modal> createState() => _ModalState();
}

class _ModalState extends State<Modal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      width: double.infinity,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.only(topLeft: Radius.circular(50) , topRight: Radius.circular(50) )
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FormDevoir(classe: widget.classe ,)));
            },
            child: Container(
              margin: EdgeInsets.only(bottom: 20 , top: 20),
              padding: EdgeInsets.all(10),
              child: Text("Devoir" , style:  TextStyle(fontSize: 40 , fontWeight: FontWeight.bold ,),),
            ),
          ),
          GestureDetector(
            onTap: (){
              Navigator.push(context, MaterialPageRoute(builder: (context)=> FormQuiz()));
            },
            child: Container(
              padding: EdgeInsets.all(10),
              margin: EdgeInsets.only(bottom: 20 , top: 20),
              child: Text("Question" , style:  TextStyle(fontSize: 40 , fontWeight: FontWeight.bold , ), ),
            ),
          )
        ],
      ),
    );
  }
}
