

import 'dart:convert';
import 'dart:io';
import 'dart:io' if (dart.library.js) 'dart:js' as js;
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/pages/constante.dart';
import 'package:http/http.dart' as http;

class EtudiantService extends ChangeNotifier{


  static const baseEtudiantUrl = "$baseUrl/etudiant";
  Etudiant etudiant = Etudiant();

  Future<List<Etudiant>> lire() async {
    final response = await http.get(Uri.parse(baseEtudiantUrl));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<Etudiant> etudiants = [];
      for (var etudiant in responseData) {
        etudiants.add(Etudiant.fromJson(etudiant));
      }
      return etudiants;
    }
    return [];
  }

  Future<Etudiant?> recherche(int id) async {
    final response = await http.get(Uri.parse('$baseEtudiantUrl/$id'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      Etudiant? etudiant = Etudiant.fromJson(responseData);
      return etudiant;
    }
    return null;
  }



    Future<Etudiant?> connexion(BuildContext context, String email,
        String password) async {
      try {
        final response = await http.post(
          Uri.parse("$baseEtudiantUrl/connexion"),
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
          Etudiant connexionEtudiant = Etudiant.fromJson(responseData);
          print(connexionEtudiant);
          etudiant = connexionEtudiant;
          print(etudiant.toJson());
          return connexionEtudiant;
        } else {
          throw Exception('Failed to log in: ${response.statusCode}');
        }
      } catch (error) {
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            content: Text(
                'Connexion impossible veuillez vérifier vos identifiants'),
          ),
        );
        print('Error logging in: $error');
        throw error;
      }
    }

    Future<Etudiant> inscrires(Etudiant etudiant, File photo) async {
      var request = http.MultipartRequest('POST', Uri.parse("$baseEtudiantUrl/inscrires"));
      request.files.add(http.MultipartFile(
          'photo', photo.readAsBytes().asStream(), photo.lengthSync(),
          filename: basename(photo.path)));
      request.fields['etudiant'] = jsonEncode(etudiant.toJson());
      var response = await request.send();

      var responsed = await http.Response.fromStream(response);
      if (response.statusCode == 201) {
        final responseData = json.decode(responsed.body);
        debugPrint(responsed.body);
        return Etudiant.fromJson(responseData);
      } else {
        debugPrint(responsed.body);
        throw Exception('Impossible d\'ajouter l\'utilisateur');
      }
    }
  }


