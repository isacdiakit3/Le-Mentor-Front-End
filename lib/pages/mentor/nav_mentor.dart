import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/pages/mentor/mes_demandes.dart';
import 'package:le_mentor/pages/mentor/mes_etudiants.dart';
import 'package:le_mentor/pages/mentor/profil.dart';
import 'package:le_mentor/services/mentor_service.dart';

import 'accueil.dart';

class NavMentor extends StatefulWidget {
  const NavMentor({Key? key,}) : super(key: key);


  @override
  State<NavMentor> createState() => _NavMentorState();
}

class _NavMentorState extends State<NavMentor> {

  final MentorService mentorService = MentorService();
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
    return MaterialApp(
        home:  Scaffold(
            appBar: AppBar(

              backgroundColor: (myColor),
              centerTitle: true,
              title: [
                Text("Mes Classes"),
                Text("Mes Elèves"),
                Text("Demandes de Mentorat"),
                Text("Profil"),
              ][_currentIndex],
              titleTextStyle: TextStyle(color: Colors.white , fontSize: 25 , fontWeight: FontWeight.bold),
              iconTheme: IconThemeData(color: Colors.white),

              actions: [
                GestureDetector(
                  onTap: () {

                  },
                  child: Image.asset(
                      "assets/images/CLOCHE.jpg"
                  ),
                )
              ],

            ),

            drawer: ListView(padding: EdgeInsets.zero,

              children: [
                DrawerHeader(
                    child:FractionallySizedBox(
                      widthFactor: 0.7,
                      child:Image.asset("assets/images/sideBar.jpg", fit: BoxFit.contain,),
                    )
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title:Row(
                      children:[
                        Image.asset(
                          "assets/images/home.jpg",
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 16,),
                        Text("Acceuil"),
                        SizedBox(width: 16,),
                      ],
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title:Row(
                      children:[
                        Image.asset(
                          "assets/images/home.jpg",
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 16,),
                        Text("Acceuil", style: TextStyle(fontSize: 20),),
                        SizedBox(width: 16,),
                      ],
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
                Container(
                  color: Colors.white,
                  child: ListTile(
                    title:Row(
                      children:[
                        Image.asset(
                          "assets/images/home.jpg",
                          width: 24,
                          height: 24,
                        ),
                        SizedBox(width: 16,),
                        Text("Acceuil"),
                        SizedBox(width: 16,),
                      ],
                    ),
                    onTap: (){
                      Navigator.pop(context);
                    },
                  ),
                ),
              ],
            ),
            body: [
              AccueilMentor(mentor: mentorService.mentor ,),
              MesEtudiants(mentor:mentorService.mentor ,),
              MesDemandes(mentor: mentorService.mentor),
              ProfilMentor()
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
                    icon: Image.asset("assets/images/Classroom.png"),
                    label: "Classes"
                  ),
                  BottomNavigationBarItem(
                      backgroundColor: (myColor),
                      icon: Image.asset("assets/images/Graduates.png"),
                      label: "Elèves"
                  ),
                  BottomNavigationBarItem(
                      backgroundColor: (myColor),
                      icon: Image.asset("assets/images/demande.png"),
                      label: "Demandes"
                  ),
                  BottomNavigationBarItem(
                      backgroundColor: (myColor),
                      icon: Image.asset("assets/images/User.png"),
                      label: "Profil"
                  ),
                ],
              ),
            ),

        )
    );




  }
  Widget drawer () {
    return Container(
      child: Column(

      ),
    );
  }
}
