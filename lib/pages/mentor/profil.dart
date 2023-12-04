import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/services/mentor_service.dart';
import 'package:provider/provider.dart';

class ProfilMentor extends StatefulWidget {
  const ProfilMentor({Key? key}) : super(key: key);

  @override
  State<ProfilMentor> createState() => _ProfilMentorState();
}

class _ProfilMentorState extends State<ProfilMentor> {

  Widget image(){
    return CircleAvatar(
      backgroundColor: Color(0xFF365E7D),
      foregroundColor: Colors.white,
      radius: 30,
    );
  }

  late Mentor mentor ;

  @override
  void initState(){
    super.initState();
    mentor = Provider.of<MentorService>(context , listen: false).mentor;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        children: [
          SizedBox(
            height: 20,
          ),
        Container(
          height: 100,
          width: 100,
          margin: EdgeInsets.only(bottom: 20),
          child: CircleAvatar(
            backgroundColor: Color(0xFF365E7D),
            foregroundColor: Colors.white,
            radius: 30,
            backgroundImage: mentor.photo != null ? NetworkImage("${mentor.photo}") : null,
            child: mentor.photo != null
                ? Text(
              "${mentor.prenom!.substring(0 ,1).toUpperCase()}${mentor.nom!.substring(0 ,1).toUpperCase()}",
              style: TextStyle(fontSize: 30),
            )
                : null,
          ),
        ),
          Text("${mentor.prenom!.toUpperCase()} ${mentor.nom!.toUpperCase()}", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 40, left: 10),
                    child: Image.asset("assets/images/Mortarboard.png",width: 60, height: 60,)
                ),
                Text("${mentor.qualification}",style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 40, left: 10),
                    child: Image.asset("assets/images/Placeholder.png",width: 60, height: 60,)
                ),
                Text("${mentor.ville}",style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 40, left: 10),
                    child: Image.asset("assets/images/Favourite.png",width: 60, height: 60,)
                ),
                Text("${mentor.certificat} étoiles",style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 40, left: 10),
                    child: Image.asset("assets/images/Email.png",width: 60, height: 60,)
                ),
                Text("${mentor.email}",style: TextStyle(fontSize: 20),)
              ],
            ),
          ),
          Container(
            width: 300,
            decoration: BoxDecoration(
                borderRadius:  BorderRadius.circular(15)
            ),
            child: ElevatedButton.icon(

              onPressed: (){},
              icon: Image.asset("assets/images/Exitdoor.png"),
              label: Text("Deconnexion"),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.grey , ),
            ),
          )
        ],
      ),
    );
  }
  
  profilUser(Mentor mentor){
    return Center(
      child: Container(
        child: Column(
          children: [
            Container(


            ),
            Text("${mentor.prenom!.toUpperCase()}"+"${mentor.nom!.toUpperCase()}")
          ],
        ),
      ),
    );
  }
}
