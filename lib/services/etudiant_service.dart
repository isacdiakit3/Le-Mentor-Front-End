

import 'dart:convert';
import 'dart:io' if (dart.library.js) 'dart:js' as js;

import 'package:flutter/material.dart';
import 'package:le_mentor/models/etudiant.dart';
import 'package:le_mentor/pages/constante.dart';
import 'package:http/http.dart' as http;

class EtudiantService {


  static const baseEtudiantUrl = "$baseUrl/etudiant";

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

  Future<Etudiant?> inscrire(Etudiant etudiant) async {
    final response = await http.post(
      Uri.parse(baseEtudiantUrl),
      body: json.encode(etudiant),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      Etudiant inscrireEtudiant = Etudiant.fromJson(responseData);
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
    return null;
  }

  Future<Etudiant?> connexion(BuildContext context ,String email, String password) async {
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
        return connexionEtudiant;
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


}