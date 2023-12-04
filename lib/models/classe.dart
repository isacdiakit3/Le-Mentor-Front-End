

import 'dart:math';

import 'mentor.dart';

class Classe{
  int? id;
  String? filiere;
  String? salle;
  int? effectif;
  String? image;
  Mentor? mentor;

  static final List<String> imagesList = [
    'assets/background/livre_telephone.png',
    'assets/background/rose_telephone.png',
  ];

  Classe({
    this.id,
    this.filiere,
    this.salle,
    this.effectif,
    this.mentor,
    String? image,
}):image = image ?? imagesList[Random().nextInt(imagesList.length)];

  factory Classe.fromJson(Map<String , dynamic> json){
    return Classe(
        id: json["id"] ?? 0,
        filiere: json["filiere"] ?? "",
        salle: json["salle"] ?? "",
        effectif: json["effectif"] ?? 0,
        image: json["image"] ?? "",
      mentor: Mentor.fromJson(json["mentor"])?? null
    );
  }

  Map<String , dynamic> toJson() => {
    "id" : id,
    "filiere" : filiere,
    "salle" : salle,
    "effectif" : effectif,
    "image" : image,
    "mentor" : mentor?.toJson()
  };
}