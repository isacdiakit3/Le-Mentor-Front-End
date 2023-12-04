

import 'package:le_mentor/models/etudiant.dart';
import 'devoir.dart';

class RenduDevoir{
  int? id;
  String? titre;
  String? pieceJointe;
  int? note;
  DateTime? date;
  Etudiant? etudiant;
  Devoir? devoir;

  RenduDevoir({
    this.id,
    this.titre,
    this.pieceJointe,
    this.note,
    this.date,
    this.etudiant,
    this.devoir
  });

  factory RenduDevoir.fromJson(Map<String, dynamic> json) {
    return RenduDevoir(
      id: json["id"] ?? 0,
      titre: json["titre"] ?? "",
      pieceJointe: json["pieceJointe"] ?? "",
      note: json["note"] ?? 0,
      date: json["date"] ?? "",
      etudiant: Etudiant.fromJson(json["etudiant"]),
      devoir: Devoir.fromJson(json["devoir"]),
    );
  }

  Map<String , dynamic> toJson() => {
    "id":id,
    "titre" : titre,
    "pieceJointe" : pieceJointe,
    "note" : note,
    "date" : date,
    "etudiant" : etudiant!.toJson(),
    "devoir" : devoir!.toJson(),
  };
}