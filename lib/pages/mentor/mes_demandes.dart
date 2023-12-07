import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/demande_mentorat.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/services/demande-service.dart';
import 'package:provider/provider.dart';

import '../../services/mentor_service.dart';
import '../constante.dart';

class MesDemandes extends StatefulWidget {
  const MesDemandes({Key? key, required this.mentor}) : super(key: key);

  final Mentor mentor;

  @override
  State<MesDemandes> createState() => _MesDemandesState();
}

class _MesDemandesState extends State<MesDemandes> {


  List<DemandeMentorat> demandes = [];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body:SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            FutureBuilder(
              future: Provider.of<DemandeMentoratService>(context, listen: false).lire(Provider.of<MentorService>(context,listen: false).mentor.id!),
              builder: (context, snapshot) {
                print(Provider.of<MentorService>(context,listen: false).mentor.id);
                if(snapshot.connectionState == ConnectionState.waiting){
                  return const CircularProgressIndicator();
                }

                if(snapshot.hasError){
                  return Text('Erreur : ${snapshot.error}');
                }
                print("${snapshot.data}");
                return ListView.builder(
                  itemCount: snapshot.data!.length,
                  shrinkWrap: true,
                  itemBuilder: (context, index) {
                    return buildCardDemande(snapshot.data![index]);
                  },
                );
              },
            )
          ],
        ),
      ),
    );
  }

  buildCardDemande(DemandeMentorat demandeMentorat){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(10),
        height: 100,
        decoration: BoxDecoration(
          color: Colors.white,
          borderRadius: BorderRadius.circular(15),
          boxShadow: [
            BoxShadow(
              color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
              spreadRadius: 5, // Étendue de l'ombre
              blurRadius: 7, // Flou de l'ombre
              offset: Offset(0, 3), // Décalage de l'ombre
            ),
          ],
        ),
        child: Row(

          children: [
            Container(
              width: 70,
              height: 70,
              margin: EdgeInsets.only(right: 15),
              child: CircleAvatar(
                backgroundColor: (myColor),
                child: Text(
                  "${demandeMentorat.etudiant!.prenom!.substring(0 ,1).toUpperCase()}${demandeMentorat.etudiant!.nom!.substring(0 ,1).toUpperCase()}",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                margin: EdgeInsets.only(right: 5),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text("${demandeMentorat.etudiant!.prenom} ${demandeMentorat.etudiant!.nom}",style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),

                  ],
                ),
              ),
            ),
            Container(
              margin: EdgeInsets.only(right: 5),
              child: ElevatedButton(
                  onPressed: (){

                  },
                  child: Text("Refuser" , style:  TextStyle( color: Colors.black),),
                style: ElevatedButton.styleFrom(backgroundColor: Colors.redAccent),

              ),
            ),
            ElevatedButton(
                onPressed: () async{
                 
                          await MentorService().accepter(demandeMentorat.id!) ;
                },
                child: Text("Accepter" , style:  TextStyle(color: Colors.white),),
              style: ElevatedButton.styleFrom(backgroundColor: (myColor)),
            ),
          ],
        ),
      ),
    );
  }
}
