

import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/models/mentor.dart';

class DemandeMentorat{
  int? id;
  String? status;
  String? dateTime;
  Mentor? mentor;
  Etudiant? etudiant;


  DemandeMentorat({
   this.id,
   this.status,
   this.dateTime,
   this.mentor,
   this.etudiant
});

  factory DemandeMentorat.fromJson(Map<String , dynamic> json){
    return  DemandeMentorat(
        id: json["id"] ?? 0,
        status: json["status"] ?? "",
        dateTime: json["datetime"] ?? "",
        mentor: Mentor.fromJson(json["mentor"]),
        etudiant: Etudiant.fromJson(json["etudiant"])
    );
  }

  Map<String , dynamic> toJson() => {
    "id" : id,
    "status" : status,
    "datetime" : dateTime,
    "mentor": mentor?.toJson(),
    "etudiant": etudiant?.toJson(),

  };
}