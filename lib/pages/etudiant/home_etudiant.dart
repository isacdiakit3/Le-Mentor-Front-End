import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/demande_mentorat.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/pages/constante.dart';
import 'package:le_mentor/services/demande-service.dart';
import 'package:le_mentor/services/etudiant_service.dart';
import 'package:le_mentor/services/mentor_service.dart';
import 'package:provider/provider.dart';


class AccueilEtudiant extends StatefulWidget {
  const AccueilEtudiant({Key? key ,required this.etudiant}) : super(key: key);

  final Etudiant etudiant;



  @override
  State<AccueilEtudiant> createState() => _AccueilEtudiantState();
}

class _AccueilEtudiantState extends State<AccueilEtudiant> {


  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();

  late MentorService mentorService;
  final EtudiantService etudiantService = EtudiantService();


  List<Mentor> mentor = [];
  Image value1= Image.asset("assets/images/Vector.png");
  String status = "";
  String datetime = "";
  Text value2=Text("Demander", style: TextStyle(fontSize: 10));
  Text value3=Text("Mentorat", style: TextStyle(fontSize: 10));

  onChange(){
    setState(() {
     Image value1 = Image.asset("assets/images/ok.png");
     Text value2 = Text("Demande", style: TextStyle(fontSize: 10));
     Text value3 = Text("Envoyée", style: TextStyle(fontSize: 10));
    });
  }


  @override
  void initState(){
    super.initState();

  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              margin: EdgeInsets.all(10),
                child: TextField(
                  decoration: InputDecoration(
                    suffixIcon: Icon(Icons.search),
                    hintText: "Recherche de mentor ${Provider.of<EtudiantService>(context, listen: false).etudiant.nom} ",
                    border: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(15)
                    )
                  ),
                )
            ),
            FutureBuilder(
              future: Provider.of<MentorService>(context, listen: false).lire(),
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
                    itemCount: snapshot.data!.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      return buildCardMentor(snapshot.data![index]);
                    },
                  ),
                );
              },
            ),
          ],
        ),
      ),
    );
  }
  buildCardMentor(Mentor mentor){
    return GestureDetector(
      child: Container(
        padding: EdgeInsets.all(10),
        margin: EdgeInsets.all(5),
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
                  "${mentor.prenom!.substring(0 ,1).toUpperCase()}${mentor.nom!.substring(0 ,1).toUpperCase()}",
                  style: TextStyle(fontSize: 20,color: Colors.white),
                ),
              ),
            ),
            Expanded(
              child: Container(
                
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Text("${mentor.prenom} ${mentor.nom}",style: TextStyle(fontSize: 20 , fontWeight: FontWeight.bold),),
                    Text("${mentor.qualification} ",style: TextStyle(fontSize: 15 ),),
                    Text("${mentor.certificat} certificats",style: TextStyle(fontSize: 15 ),),
                  ],
                ),
              ),
            ),
        InkWell(
          onTap: () async {
              if (_formKey.currentState?.validate() ?? false) {
                _formKey.currentState?.save();

                // Navigator.pushNamed(context, '/connexionMentor');
                debugPrint("Erreur : veuillez corriger les champs");


              } else {

                debugPrint("ok");

                DemandeMentorat demandeMentorat = DemandeMentorat(
                  id: null,
                  status: status,
                  dateTime: datetime,
                );

                Map<String, dynamic> userData = {
                  "mentor": mentor,
                  "etudiant": Provider.of<EtudiantService>(context, listen: false).etudiant.toJson(),
                  // Ajoutez d'autres champs si nécessaire
                };

                DemandeMentoratService demandeMentoratService = DemandeMentoratService();
                demandeMentorat.mentor = mentor;
                demandeMentorat.etudiant = widget.etudiant;
                print("${Provider.of<EtudiantService>(context, listen: false).etudiant.id}");
                await demandeMentoratService.creerDemande(mentor.id!,Provider.of<EtudiantService>(context, listen: false).etudiant.id!,demandeMentorat);
                onChange();
              }

          },
          child: Container(
            alignment: Alignment.centerRight,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            mainAxisSize: MainAxisSize.min,
            children: [
              value1, // Ajoutez votre icône ici
              SizedBox(width: 8),
              value2 ,// Ajoutez un espace entre l'icône et le texte
              value3
            ],
          ),
            ),
        ),
          ],
        ),
      ),
    );
  }
}
