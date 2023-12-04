import 'dart:io';

import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/models/message.dart';
import 'package:le_mentor/pages/constante.dart';
import 'package:le_mentor/services/classe_service.dart';
import 'package:le_mentor/services/etudiant_service.dart';
import 'package:le_mentor/services/message_service.dart';
import 'package:provider/provider.dart';

import '../../services/mentor_service.dart';

class FormMessageMentor extends StatefulWidget {
  const FormMessageMentor({Key? key, required this.classe}) : super(key: key);

  final Classe classe;

  @override
  State<FormMessageMentor> createState() => _FormMessageMentorState();
}

class _FormMessageMentorState extends State<FormMessageMentor> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  Color myColor = const Color(0xFF365E7D);
  Color gold = const Color(0xFFEAFD0B);

  String value = "";
  String contenu = "";
  File? pieceJointe;

  void validationForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      debugPrint("ok");

      Message message = Message(
        id: null,
        contenu: contenu,
      );

      Map<String, dynamic> userData = {
        "contenu": contenu,
        "mentor": Provider.of<MentorService>(context, listen: false).mentor.toJson(),
        "classe": Provider.of<ClasseService>(context, listen: false).classe.toJson()
        // Ajoutez d'autres champs si nécessaire
      };
      MessageService messageService = MessageService();
      print(Provider.of<MentorService>(context,listen : false).mentor.nom);
      message.mentor = Provider.of<MentorService>(context , listen: false).mentor;
      message.classe = widget.classe;
      await messageService.creerMessage(Provider.of<MentorService>(context,listen : false).mentor.id!,widget.classe.id!, message ,pieceJointe!);
      Navigator.pop(context);

    } else {
      debugPrint("Erreur : veuillez corriger les champs");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          "Message",
          style: TextStyle(
            fontWeight: FontWeight.bold,
            fontSize: 25,
            color: Colors.white
          ),
        ),
        backgroundColor: (myColor),
        centerTitle: true,
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
                      labelText: "  Message",
                      hintText: "  Ecrivez votre message",
                    ),
                    validator: (val) {
                      if (val == null || val.isEmpty) {
                        return "Veillez entrez votre Message";
                      } else {
                        return null;
                      }
                    },
                    onSaved: (val) => contenu = val!,
                    keyboardType: TextInputType.text,
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
                    child: Text("Envoyez", style: TextStyle(color: (gold)),),
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
