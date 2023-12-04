

import 'dart:convert';

class Etudiant {
  int? id;
  String? prenom;
  String? nom;
  String? ville;
  String? email;
  String? password;
  String? photo;

  Etudiant({
    this.id,
    this.prenom,
    this.nom,
    this.ville,
    this.email,
    this.password,
    this.photo,
});

  factory Etudiant.fromJson(Map<String , dynamic> json) {
    return Etudiant(
    id: json["id"] ?? 0,
    prenom: json["prenom"] ?? "",
    nom: json["nom"] ?? "",
    ville: json["ville"]?? "",
    email: json["email"]?? "",
    password: json["password"]?? "",
    photo: json["photo"]?? "",
    );
  }

  Map<String , dynamic> toJson() => {
    "id": id,
    "prenom": prenom,
    "nom": nom,
    "ville": ville,
    "email": email,
    "password": password,
    "photo": photo,
  };
}