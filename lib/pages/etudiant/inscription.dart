import 'dart:io';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/pages/etudiant/connexion.dart';
import 'package:le_mentor/services/etudiant_service.dart';
import 'package:http/http.dart' as http;
import 'package:image_picker/image_picker.dart';



class InscriptionEtudiant extends StatefulWidget {
  const InscriptionEtudiant({Key? key}) : super(key: key);

  @override
  State<InscriptionEtudiant> createState() => _InscriptionEtudiantState();
}

class _InscriptionEtudiantState extends State<InscriptionEtudiant> with SingleTickerProviderStateMixin {
  late AnimationController _controller;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  File? selectedImage;

  TextEditingController passwordController = TextEditingController();
  TextEditingController passwordConfirmController = TextEditingController();

  Widget image(){
    return CircleAvatar(
      backgroundColor: Color(0xFF365E7D),
      foregroundColor: Colors.white,
      radius: 30,
      backgroundImage: selectedImage != null ? FileImage(selectedImage!) : null,
      child: selectedImage == null ? Text("PHOTO") : null,
    );
  }

  String value = "";
  String prenom = "";
  String nom = "";
  String email = "";
  String ville = "";
  String password = "";
  String passwordConfirm = "";
  String photo = "";
  bool _obscureText = true;
  String imageBase64 = "";

  void validationForm() async {
    if (_formKey.currentState?.validate() ?? false) {
      _formKey.currentState?.save();

      Navigator.pushNamed(context, '/connexionEtudiant');
      debugPrint("ok");

      Etudiant etudiant = Etudiant(
        id: null,
        prenom: prenom,
        nom: nom,
        ville: ville,
        email: email,
        password: password,
        photo: "", // Sera défini ci-dessous
      );
      Map<String, dynamic> userData = {
        "prenom": prenom,
        "nom": nom,
        "email": email,
        "ville": ville,
        "password": password,
        // Ajoutez d'autres champs si nécessaire
      };
      EtudiantService etudiantService = EtudiantService();
      await etudiantService.inscrires(etudiant,selectedImage!);
    } else {
      debugPrint("Erreur : veuillez corriger les champs");
    }
  }

  void affichage(nom) {
    setState(() {
      value = "Bienvenue $nom";
    });
  }
  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this);
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    Color myColor = const Color(0xFF365E7D);
    Color gold = const Color(0xFFEAFD0B);
    return MaterialApp(
      home: Scaffold(
        body: SingleChildScrollView(
              child:Container(
                    margin: EdgeInsets.all(20),

                    child: Form(
                        key: _formKey,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: <Widget>[
                            Container(
                                width: 100,
                                height: 100,
                                margin: EdgeInsets.only(bottom: 10),
                                child: image()
                            ),
                            ElevatedButton(
                              onPressed: () async {
                                XFile? pickedImage = await ImagePicker().pickImage(source: ImageSource.gallery);
                                if (pickedImage != null) {
                                  selectedImage = File(pickedImage.path);
                                  setState(() {});
                                }
                              },
                              child: Icon(
                                Icons.image,color: (gold),
                              ),
                              style: ElevatedButton.styleFrom(backgroundColor: (myColor) ),
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            Text(
                              value,
                              style: TextStyle(fontSize: 20, color: Color(0xFF031B49)),
                              textAlign: TextAlign.center,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon:  Icon(
                                  Icons.person,
                                  color: (myColor),
                                  size: 20,
                                ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: "Prenom",
                                  hintText: "Entrez votre prenom",
                                  ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veillez entrez votre prenom";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => prenom = val!,
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              autofocus: true,
                              onChanged: affichage,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.person,
                                  color: (myColor),
                                  size: 20,
                                ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: "Nom",
                                  hintText: "Entrez votre nom",
                                  ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veillez entrez votre nom";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => nom = val!,
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              autofocus: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.gps_fixed_sharp,
                                  color: (myColor),
                                  size: 20,
                                ),
                                border: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(5)),
                                  labelText: "Ville",
                                  hintText: "Entrez votre ville",
                                  ),
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veillez entrez votre ville";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => ville = val!,
                              keyboardType: TextInputType.text,
                              autocorrect: true,
                              autofocus: true,
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.mail,
                                  color: (myColor),
                                  size: 20,
                                ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: "Email",
                                  hintText: "Entrez votre email",
                                  ),
                              keyboardType: TextInputType.emailAddress,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veillez entrez votre email";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => email = val!,
                            ),
                            // fin  adresse email
                            const SizedBox(
                              height: 10,
                            ),
                            // debut  mot de pass
                            TextFormField(
                              controller: passwordController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock_outline,
                                  color: (myColor),
                                  size: 20,
                                ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: "Nouveau mot de passe",
                                  hintText: "Entrez votre nouveau mot de passe",
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
                                          .visibility, // Choisir l'icône basée sur l'état du texte masqué
                                      color: Colors.grey,
                                    ),
                                  ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: _obscureText,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veillez entrez votre nouveau mot de passe";
                                }
                                if (val.length < 4) {
                                  return 'Le mot de passe doit contenir au moins 4 caractères';
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => password = val!,
                            ),
                            // fin mot de pass
                            const SizedBox(
                              height: 10,
                            ),
                            TextFormField(
                              controller: passwordConfirmController,
                              decoration: InputDecoration(
                                prefixIcon: Icon(
                                  Icons.lock,
                                  color: (myColor),
                                  size: 20,
                                ),
                                  border: OutlineInputBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  labelText: "Confirmer mot de passe",
                                  hintText: "Confirmer mot de passe",
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
                                          .visibility, // Choisir l'icône basée sur l'état du texte masqué
                                      color: Colors.grey,
                                    ),
                                  ),
                              ),
                              keyboardType: TextInputType.text,
                              obscureText: _obscureText,
                              validator: (val) {
                                if (val == null || val.isEmpty) {
                                  return "Veillez confirmer votre mot de passe";
                                }
                                if (val != passwordController.text) {
                                  return "les mots de passe ne correspondent pas";
                                } else {
                                  return null;
                                }
                              },
                              onSaved: (val) => passwordConfirm = val!,
                            ),
                            // fin confirme mot de passe
                            const SizedBox(
                              height: 10,
                            ),
                            ElevatedButton(
                              child: Text(
                                "Inscription",
                                style: TextStyle(
                                  fontSize: 15,
                                  fontWeight: FontWeight.bold,
                                  color: Colors.white,
                                ),
                                textAlign: TextAlign.center,
                              ),
                              onPressed: validationForm,
                              style: ElevatedButton.styleFrom(
                                  backgroundColor: (myColor),
                                  shape: RoundedRectangleBorder(
                                      borderRadius: BorderRadius.circular(5)),
                                  minimumSize: Size(300, 40)),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            Text("si vous avez deja un compte ?"),
                            GestureDetector(
                                onTap: () {
                                  Navigator.push(context,
                                      MaterialPageRoute(builder: (context) => ConnexionEtudiant()));
                                },
                                child: Text(
                                  "connecter vous",
                                  style: TextStyle(
                                      color: Colors.blue,
                                      decoration: TextDecoration.underline),
                                )
                            )
                          ],
                        )),
                  ),

              ),
            ),
      );
  }
}
