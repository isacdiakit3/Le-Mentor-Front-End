

import 'classe.dart';
import 'mentor.dart';

class Quiz{
  int? id;
  String? titre;
  String? description;
  String? question;
  List<String>? reponse;
  int? point;
  DateTime? date;
  DateTime? datelimite;
  Mentor? mentor;
  Classe? classe;

  Quiz({
    this.id,
    this.titre,
    this.description,
    this.question,
    this.reponse,
    this.point,
    this.date,
    this.datelimite,
    this.mentor,
    this.classe
  });

  factory Quiz.fromJson(Map<String, dynamic> json) {
    return Quiz(
      id: json["id"] ?? 0,
      titre: json["titre"] ?? "",
      description: json["description"] ?? "",
      question: json["question"] ?? "",
      reponse: json["reponse"] ?? "",
      point: json["point"] ?? 0,
      date: json["date"] ?? "",
      datelimite: json["datelimite"] ?? "",
      mentor: Mentor.fromJson(json["mentor"]),
      classe: Classe.fromJson(json["classe"]),
    );
  }

  Map<String , dynamic> toJson() => {
    "id":id,
    "titre" : titre,
    "description" : description,
    "question" : question,
    "reponse" : reponse,
    "point" : point,
    "date" : date,
    "datelimite" : datelimite,
    "mentor" : mentor!.toJson(),
    "classe" : classe!.toJson(),
  };
}