import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/pages/etudiant/home_etudiant.dart';
import 'package:le_mentor/pages/etudiant/mentors.dart';
import 'package:le_mentor/pages/etudiant/mes_mentors.dart';
import 'package:le_mentor/pages/etudiant/profil.dart';

class NavEtudiant extends StatefulWidget {
  const NavEtudiant({Key? key}) : super(key: key);


  @override
  State<NavEtudiant> createState() => _NavEtudiantState();
}

class _NavEtudiantState extends State<NavEtudiant> {

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
            Text("Mentors"),
            Text("Mes Mentors"),
            Text("Mes Classes"),
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
          AccueilEtudiant(),
          Mentors(),
          MesMentors(),
          ProfilEtudiant()
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
                icon: Image.asset("assets/images/Send.png"),
                label: "recherche"
            ),
              BottomNavigationBarItem(
                  backgroundColor: (myColor),
                  icon: Image.asset("assets/images/Professor.png"),
                  label: "Mentors"
              ),
              BottomNavigationBarItem(
                  backgroundColor: (myColor),
                  icon: Image.asset("assets/images/Classroom.png"),
                  label: "Classes"
              ),
              BottomNavigationBarItem(
                  backgroundColor: (myColor),
                  icon: Image.asset("assets/images/User.png"),
                  label: "Profil"
              ),
            ],
          ),
        ),
      ),
    );

  }
}
