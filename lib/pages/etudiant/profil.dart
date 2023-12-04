import 'package:flutter/material.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/services/etudiant_service.dart';
import 'package:provider/provider.dart';

class ProfilEtudiant extends StatefulWidget {
  const ProfilEtudiant({Key? key }) : super(key: key);


  @override
  State<ProfilEtudiant> createState() => _ProfilEtudiantState();
}




class _ProfilEtudiantState extends State<ProfilEtudiant> {


   Etudiant etudiant = Etudiant();

  @override
  void initState(){
    super.initState();
    etudiant = Provider.of<EtudiantService>(context , listen: false).etudiant;
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
              backgroundImage: etudiant.photo != null ? NetworkImage("${etudiant.photo}") : null,
              child: etudiant.photo != null
                  ? Text(
                "${etudiant.prenom!.substring(0 ,1).toUpperCase()}${etudiant.nom!.substring(0 ,1).toUpperCase()}",
                style: TextStyle(fontSize: 30),
              )
                  : null,
            ),
          ),
          Text("${etudiant.prenom!.toUpperCase()} ${etudiant.nom!.toUpperCase()}", style: TextStyle(fontSize: 30,fontWeight: FontWeight.bold),),

          SizedBox(
            height: 60,
          ),
          Container(
            margin: EdgeInsets.all(20),
            child: Row(
              children: [
                Container(
                    margin: EdgeInsets.only(right: 40, left: 10),
                    child: Image.asset("assets/images/Placeholder.png",width: 60, height: 60,)
                ),
                Text("${etudiant.ville}",style: TextStyle(fontSize: 20),)
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
                Text("${etudiant.email}",style: TextStyle(fontSize: 20),)
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
}
