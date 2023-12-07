import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/pages/mentor/classe_page.dart';
import 'package:le_mentor/pages/mentor/form_classe.dart';
import 'package:le_mentor/pages/mentor/modal.dart';
import 'package:le_mentor/services/classe_service.dart';
import 'package:le_mentor/services/mentor_service.dart';
import 'package:provider/provider.dart';

class AccueilMentor extends StatefulWidget {
  const AccueilMentor({Key? key , required this.mentor}) : super(key: key);

  final Mentor mentor;
  @override
  State<AccueilMentor> createState() => _AccueilMentorState();
}

class _AccueilMentorState extends State<AccueilMentor> {

  final MentorService mentorService = MentorService();


  late ClasseService classeService;
  List<Classe> classe = [];

  @override
  void initState(){
    super.initState();
  }



  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFF365E7D);
    Color gold = const Color(0xFFEAFD0B);
    return Scaffold(
        body:Center(
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              FutureBuilder(
                  future: Provider.of<ClasseService>(context, listen: false).lire(Provider.of<MentorService>(context,listen: false).mentor.id!),
                  builder: (context, snapshot) {
                    print(Provider.of<MentorService>(context,listen: false).mentor.id);
                    if(snapshot.connectionState == ConnectionState.waiting){
                      return const CircularProgressIndicator();
                    }

                    if(snapshot.hasError){
                      return Text('Erreur : ${snapshot.error}');
                    }
                    print("${snapshot.data}");
                    return Expanded(

                      child: ListView.builder(
                        reverse: false,

                        scrollDirection: Axis.vertical,
                        itemCount: snapshot.data!.length,
                        shrinkWrap: true,
                        itemBuilder: (context, index) {
                          return buildCardClass(snapshot.data![index]);
                        },
                      ),
                    );
                  },
              )
            ],
          ),
        ),
      floatingActionButton: FloatingActionButton(
          onPressed: (){
            Navigator.push(context,MaterialPageRoute(builder: (context)=> const FormClasse()));
          },
          backgroundColor: Color(0xFF365E7D),
        child: Icon(Icons.add,color: Color(0xFFEAFD0B)),
      ),
    );
  }



  buildCardClass(Classe classe){
    int? nbreEleve = classe.effectif;
    return GestureDetector(
        onTap: (){
          Navigator.push(context, MaterialPageRoute(builder: (context) => ClasseMentor(classe: classe)));
        },

      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
        height: 200,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          image: DecorationImage(
            image: AssetImage("assets/background/${classe.image}"),
            fit: BoxFit.cover
          )
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Container(
              margin: EdgeInsets.only(bottom: 10),
              child: Text(
                classe.filiere!.toUpperCase(),
                style: TextStyle(
                  color: Colors.black,
                  fontSize: 30,
                  fontWeight: FontWeight.bold
                ),
              ),
            ),
            Text(
              classe.salle!,
              style: TextStyle(
                  color: Colors.white,
                  fontSize: 15,
                  fontWeight: FontWeight.normal
              ),
            ),
            Divider(
              height: 90,
              color: Colors.transparent,
            ),
        Text(
          "$nbreEleve élève",
          style: TextStyle(
              color: Colors.white,
              fontSize: 15,
              fontWeight: FontWeight.normal
          ),
        ),
          ],
        ),
      )
    );
  }
}
