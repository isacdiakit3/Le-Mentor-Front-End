import 'package:flutter/material.dart';
import 'package:le_mentor/pages/etudiant/echanges.dart';
import 'package:le_mentor/pages/etudiant/participants.dart';
import 'package:le_mentor/pages/etudiant/travaux.dart';


class ClasseEtudiant extends StatefulWidget {
  const ClasseEtudiant({Key? key}) : super(key: key);

  @override
  State<ClasseEtudiant> createState() => _ClasseEtudiantState();
}

class _ClasseEtudiantState extends State<ClasseEtudiant> {
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
          "Classe",
          textAlign: TextAlign.center,
          style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
        ),
      ),
      body: [
        EchangesEtudiant(),
        TravauxEtudiant(),
        ParticipantsEtudiant(),
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
