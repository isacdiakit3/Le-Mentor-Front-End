

class Mentor {
  final int? id;
  final String? prenom;
  final String? nom;
  final String? ville;
  final String? qualification;
  final String? diplome;
  final String? email;
  final String? password;
  final String? photo;
  final int? certificat;
  final bool? approuvee;

  Mentor({
    this.id,
    this.prenom,
    this.nom,
    this.ville,
    this.qualification,
    this.diplome,
    this.email,
    this.password,
    this.photo,
    this.certificat,
    this.approuvee,
});
  factory Mentor.fromJson(Map<String , dynamic> json) {
    return Mentor(
        id: json["id"] ?? 0,
        prenom: json["prenom"] ?? "",
        nom: json["nom"] ?? "",
        ville: json["ville"] ?? "",
        qualification: json["qualification"] ?? "",
        diplome: json["diplome"] ?? "",
        email: json["email"] ?? "",
        password: json["password"] ?? "",
        photo: json["photo"] ?? "",
        certificat: json["certificat"] ?? 0,
        approuvee: json["approuvee"] ?? false,
    );
    }
  Map<String , dynamic> toJson() => {
    "id" : id,
    "prenom" : prenom,
    "nom" : nom,
    "ville" : ville,
    "qualification" : qualification,
    "diplome" : diplome,
    "email" : email,
    "password" : password,
    "photo" : photo,
    "certificat" : certificat,
    "approuvee" : approuvee,

  };
}