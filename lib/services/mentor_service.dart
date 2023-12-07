

import 'dart:convert';
import 'dart:io';
import 'package:le_mentor/models/classe.dart';
import 'package:path/path.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:http/http.dart' as http;
import '../pages/constante.dart';

class MentorService extends ChangeNotifier{


  static const baseMentorUrl = "$baseUrl/mentor";
  Mentor mentor = Mentor();

  Future<List<Mentor>> lire() async {
    final response = await http.get(Uri.parse(baseMentorUrl));

    if (response.statusCode == 200) {
      var responseData = jsonDecode(utf8.decode(response.bodyBytes));
      List<Mentor> mentors = [];
      for (var mentor in responseData) {
        mentors.add(Mentor.fromJson(mentor));
      }
      return mentors;
    }
    return [];
  }

  Future<List<Classe>> lires(int id) async {
    final response = await http.get(Uri.parse("$baseMentorUrl/classeMentor/$id"));

    if (response.statusCode == 200) {
      print("__________________________________");
      List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      List<Classe> classes = list.map((e) => Classe.fromJson(e)).toList();

      print(classes);
      /*for (var classe in responseData) {
        classes.add(Classe.fromJson(classe));
      }*/
      return classes;
    }else{
      return [];
    }
  }

  Future<Mentor?> recherche(int id) async {
    final response = await http.get(Uri.parse('$baseMentorUrl/$id'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      Mentor? etudiant = Mentor.fromJson(responseData);
      return etudiant;
    }
    return null;
  }

  /* Future<Mentor?> inscrire(Mentor etudiant) async {
    final response = await http.post(
      Uri.parse(baseMentorUrl),
      body: json.encode(etudiant),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      Mentor inscrireEtudiant = Mentor.fromJson(responseData);
      return inscrireEtudiant;
    } else if (response.statusCode == 400) {
      Map<String, dynamic> errorMessage = {};
      // Si le statut de réponse est 400 (Bad Request), il y a une erreur de validation
      var errorResponse = json.decode(response.body);
      if (errorResponse.containsKey('message')) {
        errorMessage['message'] = errorResponse['message'];
      }
      if (errorResponse.containsKey('error')) {
        errorMessage['error'] = errorResponse['error'];
      }
      if (errorResponse.containsKey('status')) {
        errorMessage['status'] = errorResponse['status'];
      }
      print("ERROR: $errorMessage");
    } else {
      print("Unexpected Error");
    }
    return null
  }*/

  Future<Mentor?> connexion(BuildContext context ,String email, String password) async {
    try {
      final response = await http.post(
        Uri.parse("$baseMentorUrl/connexion"),
        body: json.encode({
          'email': email,
          'password': password,
        }),
        headers: {
          'Content-Type': 'application/json',
        },
      );

      if (response.statusCode == 200) {
        print("Success");
        var responseData = json.decode(utf8.decode(response.bodyBytes));
        print(responseData);
        Mentor connexionMentor= Mentor.fromJson(responseData);
        mentor = connexionMentor;
        print(mentor.toJson());
        return connexionMentor;
      } else {
        throw Exception('Failed to log in: ${response.statusCode}');
      }
    } catch (error) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Connexion impossible veuillez vérifier vos identifiants'),
        ),
      );
      print('Error logging in: $error');
      throw error;
    }
  }

  Future<Mentor> inscrires(Mentor mentor, File photo , File diplome) async {
    var request = http.MultipartRequest('POST', Uri.parse("$baseMentorUrl/inscrires"));
    request.files.add(http.MultipartFile(
        'photo', photo.readAsBytes().asStream(), photo.lengthSync(),
        filename: basename(photo.path)));
    request.files.add(http.MultipartFile(
      'diplome',
      diplome.readAsBytes().asStream(),
      diplome.lengthSync(),
      filename: basename(diplome.path),
    ));
    request.fields['mentor'] = jsonEncode(mentor.toJson());
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      final responseData = json.decode(responsed.body);
      debugPrint(responsed.body);
      return Mentor.fromJson(responseData);
    } else {
      debugPrint(responsed.body);
      throw Exception('Impossible d\'ajouter l\'utilisateur');
    }
  }

  Future<List<Classe>> getClasse(int id) async {
    final response = await http.get(Uri.parse("$baseMentorUrl/classe/$id"));
    if (response.statusCode == 200) {
      print("__________________________________");
      List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      List<Classe> classes = list.map((e) => Classe.fromJson(e)).toList();

      print(classes);
      /*for (var classe in responseData) {
        classes.add(Classe.fromJson(classe));
      }*/
      return classes;
    } else {
      return [];
    }
  }

  Future<String> accepter(int id) async {
    final response = await http.put(Uri.parse("$baseMentorUrl/accepter/$id"));

    if (response.statusCode == 200) {
      print("========================================================");

      return utf8.decode(response.bodyBytes);
    }else{
      return "sans succes" ;
    }


  }

  Future<String> refuser(int id) async {
    final response = await http.put(Uri.parse("$baseMentorUrl/refuser/$id"));

    if (response.statusCode == 200) {

      return  utf8.decode(response.bodyBytes);
    }else{
      return "Sans succès";
    }
  }
}