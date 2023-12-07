import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/message.dart';
import 'package:le_mentor/pages/constante.dart';
import 'package:le_mentor/pages/mentor/form_devoir.dart';
import 'package:le_mentor/pages/mentor/message_mentor.dart';
import 'package:le_mentor/services/classe_service.dart';
import 'package:le_mentor/services/message_service.dart';
import 'package:provider/provider.dart';
import '../../models/classe.dart';
import '../../models/mentor.dart';
import '../../services/mentor_service.dart';

class EchangesMentor extends StatefulWidget {
  const EchangesMentor({Key? key , required this.classe}) : super(key: key);

  final Classe classe;
  @override
  State<EchangesMentor> createState() => _EchangesMentorState();

}

class _EchangesMentorState extends State<EchangesMentor> {

  late Mentor mentor ;
  @override
  void initState(){
    super.initState();
    mentor = Provider.of<MentorService>(context , listen: false).mentor;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Center(
          child: Container(
            padding: EdgeInsets.all(10),
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Container(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(50),

                  ),
                    child: Image.asset("assets/background/${widget.classe.image}")
                ),
                GestureDetector(
                  onTap: (){
                    Navigator.push(context, MaterialPageRoute(builder: (context)=> FormMessageMentor(classe: widget.classe), ));
                  },
                  child: Container(
                    margin: EdgeInsets.only(top: 10, bottom: 10),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(15),
                        boxShadow: [
                          BoxShadow(
                            color: Colors.grey.withOpacity(0.5), // Couleur de l'ombre
                            spreadRadius: 5, // Étendue de l'ombre
                            blurRadius: 7, // Flou de l'ombre
                            offset: Offset(0, 3), // Décalage de l'ombre
                          ),
                        ],
                      color: Colors.white
                    ),
                    child:Row(
                        children: [
                          Container(
                            width: 80,
                            height: 80,
                            margin: EdgeInsets.only(right: 30 , left: 20),
                            padding: EdgeInsets.all(8),
                            child: CircleAvatar(
                              backgroundColor: (myColor),
                              child: Text(
                                  "${widget.classe.mentor!.prenom!.substring(0 ,1).toUpperCase()}${widget.classe.mentor!.nom!.substring(0 ,1).toUpperCase()}",
                                  style: TextStyle(fontSize: 30,color: Colors.white),
                              ),

                            ),
                          ),
                          Text(
                            "Envoyer un message 📢",
                            style: TextStyle(color: (myColor) , fontSize: 20),
                          )

                        ],

                    ) ,
                  ),
                ),
                Text("Discussion instantanée"),
                Consumer<MessageService>(
                  builder: (context, messageService, child) {
                    print("object==========");
                    return FutureBuilder(
                      future: Provider.of<MessageService>(context, listen: false).lire(widget.classe.id!),
                      builder: (context, snapshot) {
                        print(Provider.of<ClasseService>(context,listen: false).classe.id);
                        if(snapshot.connectionState == ConnectionState.waiting){
                          return const CircularProgressIndicator();
                        }

                        if(snapshot.hasError){
                          return Text('Erreur : ${snapshot.error}');
                        }
                        print("${snapshot.data}");
                        return ListView.builder(
                          scrollDirection: Axis.vertical,
                          itemCount: snapshot.data!.length,
                          shrinkWrap: true,
                          reverse: true,
                          itemBuilder: (context, index) {
                            return SingleChildScrollView(
                              child: Container(
                                margin: EdgeInsets.all(10),
                                child: buildCardMessage(snapshot.data![index]),
                              ),
                            );


                          },
                        );

                      },
                    );
                  },
                )

              ],
            ),
          ),
        ),
      ),
    );
  }

  buildCardMessage(Message message){
    return GestureDetector(
      child: Container(

        padding: EdgeInsets.only(left: 10, right: 10 ,top: 5, bottom: 5),
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Padding(
              padding:  EdgeInsets.only(bottom: 5),

              child: Text(
                  "${message.mentor!.prenom!} ${message.mentor!.nom!}",
                style: TextStyle(
                  color: (myColor),
                  fontSize: 20,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text("${message.contenu}"),
            Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [Text("${message.date}")]
            )

          ],
        ),
      )
    );
  }
}
