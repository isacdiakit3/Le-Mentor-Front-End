import 'package:flutter/material.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/pages/mentor/inscription.dart';
import 'package:le_mentor/services/mentor_service.dart';
import 'package:provider/provider.dart';


class ConnexionMentor extends StatefulWidget {
  const ConnexionMentor({Key? key}) : super(key: key);

  @override
  State<ConnexionMentor> createState() => _ConnexionMentorState();
}

class _ConnexionMentorState extends State<ConnexionMentor> {
  final _formkey = GlobalKey<FormState>();
  bool _obscureText = true;
  String email = "";
  String password = "";

  dynamic validationForm() async {
    if (_formkey.currentState?.validate() ?? false) {
      _formkey.currentState?.save();
      ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Envoi en cours"))
      );
      Map<String, String> userData = {
        "email": email.toString(),
        "password": password.toString(),
        // Ajoutez d'autres champs si nécessaire
      };
      print(userData);
      MentorService mentorService = MentorService();
      Mentor? currentMentor = await mentorService.connexion(context, email, password);
      Provider.of<MentorService>(context,listen: false).mentor=currentMentor!;
      if (currentMentor != null) {
        print(currentMentor);
        Navigator.pushNamed(context, '/navMentor');
      } else {
        ScaffoldMessenger.of(context).showSnackBar(
          const SnackBar(content: Text("Cet utilisateur n'existe pas")),
        );
        return "Cet utilisateur n'existe pas";
      }
    } else {
      debugPrint("error");
    }
  }

  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFF365E7D);
    Color gold = const Color(0xFFEAFD0B);
    return Scaffold(
        body: SingleChildScrollView(
                child: Container(
                  color: Colors.white,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image.asset("assets/images/Group_12.png"),
                      SizedBox(
                        height: 40,
                      ),
                      Container(
                        margin: EdgeInsets.all(20),
                        child: Form(
                            key: _formkey,
                            child: Column(
                              children: [
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Email",
                                      hintText: "Entrez votre adresse email",
                                      border: OutlineInputBorder(),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce champ ne dois pas etre vide";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) => email = value!,
                                    keyboardType: TextInputType.emailAddress,
                                    autocorrect: true,
                                    autofocus: true,
                                  ),
                                ),
                                Container(
                                  margin: EdgeInsets.only(bottom: 10),
                                  child: TextFormField(
                                    decoration: InputDecoration(
                                      labelText: "Mot de passe",
                                      hintText: "Entrez votre Mot de passe",
                                      border: OutlineInputBorder(),
                                      suffixIcon: IconButton(
                                        onPressed: () {
                                          setState(() {
                                            _obscureText =
                                            !_obscureText; // Inverser l'état du texte masqué
                                          });
                                        },
                                        icon: Icon(
                                          _obscureText
                                              ? Icons.visibility_off
                                              : Icons
                                              .visibility,
                                          // Choisir l'icône basée sur l'état du texte masqué
                                          color: Colors.grey,
                                        ),
                                      ),
                                    ),
                                    validator: (value) {
                                      if (value == null || value.isEmpty) {
                                        return "Ce champ ne dois pas etre vide";
                                      } else {
                                        return null;
                                      }
                                    },
                                    onSaved: (value) => password = value!,
                                    keyboardType: TextInputType.text,
                                    autocorrect: true,
                                    autofocus: true,
                                    obscureText: _obscureText,
                                  ),
                                ),
                                SizedBox(
                                  width: 180,
                                  height: 50,

                                  child: ElevatedButton(
                                    onPressed: validationForm,
                                    child: Text("Connexion",
                                      style: TextStyle(fontSize: 20),
                                      textAlign: TextAlign.center,),
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: (myColor),
                                    ),

                                  ),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Text("si vous n'avez pas de compte ?"),
                                GestureDetector(
                                    onTap: () {
                                      Navigator.push(context,
                                          MaterialPageRoute(
                                              builder: (context) =>
                                                  InscriptionMentor()));
                                    },
                                    child: Text(
                                      "inscrivez vous",
                                      style: TextStyle(
                                          color: (myColor),
                                          decoration: TextDecoration.underline),
                                    )
                                )
                              ],
                            )
                        ),
                      )
                    ],
                  ),
                )
            ),
    );
  }
}
