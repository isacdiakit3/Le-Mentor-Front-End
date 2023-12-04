import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:le_mentor/models/demande_mentorat.dart';
import 'package:http/http.dart' as http;
import '../pages/constante.dart';

class  DemandeMentoratService extends ChangeNotifier {

  static const baseDemendeUrl = "$baseUrl/demande_mentorat";
  DemandeMentorat demandeMentorat = DemandeMentorat();

  Future<DemandeMentorat?> creerDemande(int mentorId,int etudiantId, DemandeMentorat demandeMentorat) async {
    final response = await http.post(
      Uri.parse('$baseDemendeUrl/creer/$mentorId/$etudiantId'),
      body: jsonEncode(demandeMentorat.toJson()),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      DemandeMentorat createdDemande = DemandeMentorat.fromJson(responseData);
      return createdDemande;
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

  Future<List<DemandeMentorat>> lire(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/mentor/attente/$id"));

    if (response.statusCode == 200) {
      print("__________________________________");
      List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      List<DemandeMentorat> demandes = list.map((e) => DemandeMentorat.fromJson(e)).toList();

      print(demandes);
      /*for (var classe in responseData) {
        classes.add(Classe.fromJson(classe));
      }*/
      return demandes;
    }else{
      return [];
    }
  }

  Future<List<DemandeMentorat>> liste(int id) async {
    final response = await http.get(Uri.parse("$baseUrl/mentor/accepterListe/$id"));

    if (response.statusCode == 200) {
      print("__________________________________");
      List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      List<DemandeMentorat> demandes = list.map((e) => DemandeMentorat.fromJson(e)).toList();

      print(demandes);
      /*for (var classe in responseData) {
        classes.add(Classe.fromJson(classe));
      }*/
      return demandes;
    }else{
      return [];
    }
  }
}