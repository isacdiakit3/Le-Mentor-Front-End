import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/pages/mentor/echanges.dart';
import 'package:le_mentor/pages/mentor/participants.dart';
import 'package:le_mentor/pages/mentor/travaux.dart';


class ClasseMentor extends StatefulWidget {
  const ClasseMentor({Key? key, required this.classe}) : super(key: key);

  final Classe classe;

  @override
  State<ClasseMentor> createState() => _ClasseMentorState();
}

class _ClasseMentorState extends State<ClasseMentor> {

  int _currentIndex = 0;



  setCurrentIndex(int index){
    setState((){
      _currentIndex = index;
    });
  }
  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFF365E7D);
    Color gold = const Color(0xFFEAFD0B);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (myColor),
        centerTitle: true,
        title: Text(
          "${widget.classe.filiere}",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: [
       EchangesMentor(classe:widget.classe),
        TravauxMentor(classe:widget.classe),
        ParticipantsMentor(classe:widget.classe),
      ][_currentIndex],
      bottomNavigationBar: Container(
        child: BottomNavigationBar(
          type: BottomNavigationBarType.fixed,
          currentIndex: _currentIndex,
          onTap: (index) => setCurrentIndex(index),
          backgroundColor: (myColor),
          selectedItemColor: (gold),
          unselectedItemColor: Colors.white,
          selectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, fontSize: 20, ) ,
          unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal, color: Colors.black),
          selectedFontSize: 20,
          unselectedFontSize:15 ,
          elevation: 20,
          items: [
            BottomNavigationBarItem(
                backgroundColor: (myColor),
                icon: Image.asset("assets/images/message.png"),
                label: "Echanges"
            ),
            BottomNavigationBarItem(
                backgroundColor: (myColor),
                icon: Image.asset("assets/images/Checklist.png"),
                label: "Travaux"
            ),
            BottomNavigationBarItem(
                backgroundColor: (myColor),
                icon: Image.asset("assets/images/Raise_hand.png",),
                label: "Participants"
            ),
          ],
        ),
      ),
    );
  }

}
