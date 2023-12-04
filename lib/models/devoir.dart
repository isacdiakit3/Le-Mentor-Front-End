


import 'package:le_mentor/models/classe.dart';

import 'mentor.dart';

class Devoir {
  int? id;
  String? titre;
  String? description;
  String? pieceJointe;
  String? point;
  String? date;
  String? dateLimite;
  Mentor? mentor;
  Classe? classe;

  Devoir({
    this.id,
    this.titre,
    this.description,
    this.pieceJointe,
    this.point,
    this.date,
    this.dateLimite,
    this.mentor,
    this.classe
  });

  factory Devoir.fromJson(Map<String, dynamic> json) {
    return Devoir(
      id: json["id"] ?? 0,
      titre: json["titre"] ?? "",
      description: json["description"] ?? "",
      pieceJointe: json["pieceJointe"] ?? "",
      point: json["point"] ?? 0,
      date: json["date"] ?? "",
      dateLimite: json["dateLimite"] ?? "",
      mentor: Mentor.fromJson(json["mentor"]),
      classe: Classe.fromJson(json["classe"]),
    );
  }

  Map<String , dynamic> toJson() => {
    "id":id,
    "titre" : titre,
    "description" : description,
    "pieceJointe" : pieceJointe,
    "point" : point,
    "date" : date,
    "dateLimite" : dateLimite,
    "mentor" : mentor!.toJson(),
    "classe" : classe!.toJson(),
  };
}