import 'package:flutter/material.dart';

class ChoixPage extends StatefulWidget {
  const ChoixPage({Key? key}) : super(key: key);

  @override
  State<ChoixPage> createState() => _ChoixPageState();
}

class _ChoixPageState extends State<ChoixPage> {
  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFF365E7D);
    Color gold = const Color(0xFFEAFD0B);
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset("assets/images/Group_12.png"),
            Container(
              margin: EdgeInsets.only(top: 40, bottom: 10),
              child: SizedBox(
                width: 200,
                height: 50,
                child: ElevatedButton(
                    onPressed: (){
                      Navigator.pushNamed(context, "/connexionMentor");
                    },
                    child: Text(
                      "Mentor",
                      style: TextStyle(color: Colors.white, fontSize: 20),
                    ),
                  style:ElevatedButton.styleFrom(
                      backgroundColor: (myColor),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      shadowColor: Colors.black
                  ),
                ),
              ),
            ),
            SizedBox(
              height: 15,
            ),
            SizedBox(
              width: 200,
              height: 50,
              child: ElevatedButton(
                onPressed: (){
                  Navigator.pushNamed(context, "/connexionEtudiant");
                },
                child: Text(
                  "Elèves",
                  style: TextStyle(color: (myColor), fontSize: 20),
                ),
                style:ElevatedButton.styleFrom(
                    backgroundColor:Colors.white ,

                    shape: RoundedRectangleBorder(
                      borderRadius: BorderRadius.circular(10),
                    ),
                    side : BorderSide(color: (myColor), width: 1),
                    shadowColor: Colors.black
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(top: 40),
              child: SizedBox(
                child: Text("Veillez choisir votre statut pour continuer 👉",style: TextStyle(color: Colors.black,fontSize: 15),),
                height: 35,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
