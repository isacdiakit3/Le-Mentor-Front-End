import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:le_mentor/pages/choix.dart';
import 'package:le_mentor/pages/etudiant/connexion.dart';
import 'package:le_mentor/pages/etudiant/nav_etudiant.dart';
import 'package:le_mentor/pages/mentor/classe_page.dart';
import 'package:le_mentor/pages/mentor/connexion.dart';
import 'package:le_mentor/pages/mentor/form_classe.dart';
import 'package:le_mentor/pages/mentor/inscription.dart';
import 'package:le_mentor/pages/mentor/nav_mentor.dart';
import 'package:le_mentor/pages/splash.dart';
import 'package:le_mentor/services/classe_service.dart';
import 'package:le_mentor/services/demande-service.dart';
import 'package:le_mentor/services/etudiant_service.dart';
import 'package:le_mentor/services/mentor_service.dart';
import 'package:le_mentor/services/message_service.dart';
import 'package:provider/provider.dart';

void main() {
  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => MentorService()),
        ChangeNotifierProvider(create: (context) => ClasseService()),
        ChangeNotifierProvider(create: (context) => MessageService()),
        ChangeNotifierProvider(create: (context) => EtudiantService()),
        ChangeNotifierProvider(create: (context) => DemandeMentoratService())
      ],
      child: const MyApp(),
    )
  );

}
class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Splash(),
      initialRoute: "/",
      routes: {
        "/navEtudiant":(context) => NavEtudiant(),
        "/navMentor":(context) => NavMentor(),
        "/connexionEtudiant":(context) => ConnexionEtudiant(),
        "/connexionMentor":(context) => ConnexionMentor(),
        "/choix":(context) => ChoixPage(),
        "/formClasse":(context) => FormClasse(),
      },
    );
  }
}
