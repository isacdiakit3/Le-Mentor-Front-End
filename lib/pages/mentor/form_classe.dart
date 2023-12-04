import 'package:flutter/material.dart';
import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/services/classe_service.dart';
import 'package:http/http.dart' as http;
import 'package:le_mentor/services/mentor_service.dart';
import 'package:provider/provider.dart';

import '../../models/mentor.dart';


class FormClasse extends StatefulWidget {
  const FormClasse({Key? key  }) : super(key: key);




  @override
  State<FormClasse> createState() => _FormClasseState();
}

class _FormClasseState extends State<FormClasse> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color myColor = const Color(0xFF365E7D);
  Color gold = const Color(0xFFEAFD0B);

  String value = "";
  String filiere = "";
  String salle = "";
  int? effectif = 0;
  String? image = "";

  void validationForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      debugPrint("ok");

      Classe classe = Classe(
        id: null,
        filiere: filiere,
        salle: salle,
        effectif: effectif,
        image: image!,
      );

      Map<String, dynamic> userData = {
        "filiere": filiere,
        "salle": salle,
        "mentor": Provider.of<MentorService>(context, listen: false).mentor.toJson()
        // Ajoutez d'autres champs si nécessaire
      };
      ClasseService classeService = ClasseService();
      print(Provider.of<MentorService>(context,listen : false).mentor.nom);
      classe.mentor = Provider.of<MentorService>(context,listen : false).mentor;
      await classeService.creerClasse(Provider.of<MentorService>(context,listen : false).mentor.id!,classe);
      Navigator.pop(context);
    } else {
      debugPrint("Erreur : veuillez corriger les champs");
    }
  }


  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: (myColor),
        centerTitle: true,
        title: Text("Creation d'une Salle de classe",),
      ),
      body: SingleChildScrollView(
        child: Container(
          child: Form(
            key: _formKey,
            child: Column(
              children: [
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "  Filière",
                      hintText: "  Entrez votre filière",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Veillez entrez votre Filière";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => filiere = val!,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    autofocus: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 20),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "  Salle",
                      hintText: "  Entrez le numero de votre salle",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Veillez donner un numero à votre salle";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => salle = val!,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    autofocus: true,
                  ),
                ),
                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                      onPressed: validationForm,
                      child: Text("Créer", style: TextStyle(color: (gold)),),
                      style: ElevatedButton.styleFrom(
                        backgroundColor: (myColor)
                      ),
                  ),
                )

              ],
            ),
          ),
        ),
      ),
    );
  }
}
