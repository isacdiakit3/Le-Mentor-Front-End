

class Classe{
  final int? id;
  final String filiere;
  final String salle;
  final int? effectif;
  final String image;

  Classe({
    required this.id,
    required this.filiere,
    required this.salle,
    required this.effectif,
    required this.image,
});

  factory Classe.fromJson(Map<String , dynamic> json){
    return Classe(
        id: json["id"] ?? 0,
        filiere: json["filiere"] ?? "",
        salle: json["salle"] ?? "",
        effectif: json["effectif"] ?? "",
        image: json["image"] ?? "",
    );
  }

  Map<String , dynamic> toJson() => {
    "id" : id,
    "filiere" : filiere,
    "salle" : salle,
    "effectif" : effectif,
    "image" : image
  };
}