

import 'dart:convert';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/mentor.dart';
import 'package:http/http.dart' as http;
import '../pages/constante.dart';

class MentorService {


  static const baseMentorUrl = "$baseUrl/mentor";

  Future<List<Mentor>> lire() async {
    final response = await http.get(Uri.parse(baseMentorUrl));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      List<Mentor> mentors = [];
      for (var mentor in responseData) {
        mentors.add(Mentor.fromJson(mentor));
      }
      return mentors;
    }
    return [];
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

  Future<Mentor?> inscrire(Mentor etudiant) async {
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
    return null;
  }

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
        print(connexionMentor);
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
}