

import 'package:le_mentor/models/classe.dart';

class DemandeMentort{
  final int? id;
  final String status;
  final DateTime dateTime;

  DemandeMentort({
   required this.id,
   required this.status,
   required this.dateTime
});

  factory DemandeMentort.fromJson(Map<String , dynamic> json){
    return  DemandeMentort(
        id: json["id"] ?? 0,
        status: json["status"] ?? "",
        dateTime: json["datetime"] ?? "",
    );
  }

  Map<String , dynamic> toJson() => {
    "id" : id,
    "status" : status,
    "datetime" : dateTime
  };
}