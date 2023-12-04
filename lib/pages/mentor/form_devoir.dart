import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_mentor/models/devoir.dart';
import 'package:le_mentor/services/devoir_service.dart';
import 'package:provider/provider.dart';

import '../../models/classe.dart';
import '../../services/classe_service.dart';
import '../../services/mentor_service.dart';


class FormDevoir extends StatefulWidget {
  const FormDevoir({Key? key , required this.classe}) : super(key: key);

  final Classe classe;
  @override
  State<FormDevoir> createState() => _FormDevoirState();
}

class _FormDevoirState extends State<FormDevoir> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color myColor = const Color(0xFF365E7D);
  Color gold = const Color(0xFFEAFD0B);

  File? pieceJointe;
  String titre = "";
  String description = "";
  String point = "";
  String? date = "";
  String? dateLimite = "" ;

  void validationForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      //Navigator.pushNamed(context, '/navMentor');
      debugPrint("ok");

      Devoir devoir = Devoir(
        id: null,
        titre: titre,
        description: description,
        point: point,
        date: null,
        dateLimite: dateLimite
      );

      Map<String, dynamic> userData = {
        "titre": titre,
        "description": description,
        "point" : point,
        "date" : date,
        "dateLimite" : dateLimite,
        "mentor": Provider.of<MentorService>(context, listen: false).mentor.toJson(),
        "classe": Provider.of<ClasseService>(context, listen: false).classe.toJson()
        // Ajoutez d'autres champs si nécessaire
      };
      DevoirService devoirService = DevoirService();
      print(Provider.of<MentorService>(context,listen : false).mentor.nom);
      devoir.mentor = Provider.of<MentorService>(context , listen: false).mentor;
      devoir.classe = widget.classe;
      await devoirService.creerDevoir(Provider.of<MentorService>(context,listen : false).mentor.id!,widget.classe.id! ,devoir , pieceJointe!);

    } else {
      debugPrint("Erreur : veuillez corriger les champs");
    }
  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Devoir"),
        backgroundColor: (myColor),
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
                      labelText: "  Titre",
                      hintText: "  Entrez un titre",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Veillez donner un titre à devoir";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => titre = val!,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    autofocus: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "  description",
                      hintText: "  Donnez une description",
                    ),
                    onSaved: (val) => description = val!,
                    keyboardType: TextInputType.text,
                    autocorrect: true,
                    autofocus: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "  Point",
                      hintText: "  le nombre de point du devoir",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Veillez donner une description à devoir";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => point = val! ,
                    keyboardType: TextInputType.number,
                    autocorrect: true,
                    autofocus: true,
                  ),
                ),
                Container(
                  margin: EdgeInsets.only(bottom: 10),
                  child: TextFormField(
                    decoration: InputDecoration(
                      labelText: "  Date limite",
                      hintText: "  la date limite du devoir",
                    ),
                    onSaved: (val) => dateLimite = val!,
                    keyboardType: TextInputType.datetime,
                    autocorrect: true,
                    autofocus: true,
                  ),
                ),

                SizedBox(
                  width: 400,
                  child: ElevatedButton(
                    onPressed: () async {
                      XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                      if (pickedImage != null) {
                        pieceJointe = File(pickedImage.path);
                        setState(() {});
                      }

                    },
                    child: Text(
                      "Ajoutez une pièce jointe",
                      style: TextStyle(
                        fontSize: 15,
                        fontWeight: FontWeight.bold,
                        color:(myColor),
                      ),
                    ),
                    style: ElevatedButton.styleFrom( shadowColor: Colors.black, backgroundColor: (gold), shape: RoundedRectangleBorder(
                        borderRadius:BorderRadius.circular(5)
                    )
                    ),
                  ),
                ),

                SizedBox(
                  width: 200,
                  child: ElevatedButton(
                    onPressed: validationForm,
                    child: Text("Attribuer", style: TextStyle(color: (gold)),),
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
