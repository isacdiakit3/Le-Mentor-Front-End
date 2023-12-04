

import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/models/quiz.dart';

class RenduQuiz {
  int? id;
  String? titre;
  String? reponse;
  int? note;
  DateTime? date;
  Etudiant? etudiant;
  Quiz? quiz;

  RenduQuiz({
    this.id,
    this.titre,
    this.reponse,
    this.note,
    this.date,
    this.etudiant,
    this.quiz
  });

  factory RenduQuiz.fromJson(Map<String, dynamic> json) {
    return RenduQuiz(
      id: json["id"] ?? 0,
      titre: json["titre"] ?? "",
      reponse: json["reponse"] ?? "",
      note: json["note"] ?? 0,
      date: json["date"] ?? "",
      etudiant: Etudiant.fromJson(json["etudiant"]),
      quiz: Quiz.fromJson(json["quiz"]),
    );
  }

  Map<String , dynamic> toJson() => {
    "id":id,
    "titre" : titre,
    "reponse" : reponse,
    "note" : note,
    "date" : date,
    "etudiant" : etudiant!.toJson(),
    "quiz" : quiz!.toJson(),
  };
}