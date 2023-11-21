

import 'dart:convert';

class Etudiant {
  final int? id;
  final String prenom;
  final String nom;
  final String ville;
  final String email;
  final String password;
  final String photo;

  Etudiant({
    required this.id,
    required this.prenom,
    required this.nom,
    required this.ville,
    required this.email,
    required this.password,
    required this.photo,
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