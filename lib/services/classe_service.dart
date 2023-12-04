import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:le_mentor/models/classe.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:le_mentor/pages/constante.dart';
import 'package:http/http.dart' as http;


class ClasseService extends ChangeNotifier {

  static const baseClasseUrl = "$baseUrl/classe";
  static const baseClasseUrlParMentor = "$baseUrl/mentor";
  Classe classe = Classe();

  Future<List<Classe>> lire(int id) async {
    final response = await http.get(Uri.parse("$baseClasseUrl/classeMentor/$id"));

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

  Future<Classe?> recherche(int id) async {
    final response = await http.get(Uri.parse('$baseClasseUrl/$id'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      Classe? classe = Classe.fromJson(responseData);
      return classe;
    }
    return null;
  }





  Future<Classe?> creer(Classe classe) async {
    final response = await http.post(
      Uri.parse("$baseClasseUrl/creer"),
      body: json.encode(classe),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      Classe createdClasse = Classe.fromJson(responseData);
      return createdClasse;
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
    return null;
  }

  Future<Classe?> creerClasse(int mentorId, Classe classe) async {
    final response = await http.post(
      Uri.parse('$baseClasseUrl/mentor/$mentorId/classe'),
      body: jsonEncode(classe.toJson()),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      Classe createdClasse = Classe.fromJson(responseData);
      return createdClasse;
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
      print(response.body);
    }
    return null;
  }
}