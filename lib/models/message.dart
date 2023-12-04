

import 'package:le_mentor/models/etudiant.dart';

import 'classe.dart';
import 'mentor.dart';

class Message {
  int? id;
  String? contenu;
  String? pieceJointe;
  String? date;
  Mentor? mentor;
  Classe? classe;
  Etudiant? etudiant;

  Message({
    this.id,
    this.contenu,
    this.pieceJointe,
    this.date,
    this.mentor,
    this.classe,
    this.etudiant
  });

  factory Message.fromJson(Map<String, dynamic> json) {
    return Message(
      id: json["id"] ?? 0,
      contenu: json["contenu"] ?? "",
      pieceJointe: json["pieceJointe"] ?? "",
      date: json["date"] ?? "",
      mentor: Mentor.fromJson(json["mentor"] ?? "")  ,
      classe: Classe.fromJson(json["classe"] ?? ""),
      etudiant: json["etudiant"] != null ? Etudiant.fromJson(json["etudiant"]) : null ,
    );
  }
  Map<String , dynamic> toJson() => {
    "id": id,
    "contenu": contenu,
    "date": date,
    "pieceJointe": pieceJointe,
    "mentor": mentor?.toJson(),
    "classe": classe?.toJson(),
    "etudiant": etudiant?.toJson(),
  };
}