

import 'dart:convert';
import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:path/path.dart';
import 'package:le_mentor/models/devoir.dart';
import 'package:http/http.dart' as http;
import '../pages/constante.dart';

class DevoirService {

  static const baseDevoirUrl = "$baseUrl/devoir";
  static const baseDevoirUrlParMentor = "$baseUrl/mentor";

  Future<List<Devoir>> lire() async {
    final response = await http.get(Uri.parse(baseDevoirUrl));

    if (response.statusCode == 200) {
      List<dynamic> list = json.decode(response.body);
      List<Devoir> devoirs = list.map((e) => Devoir.fromJson(e)).toList();
      print("__________________________________");
      print(devoirs);
      /*for (var devoir in responseData) {
        classes.add(Devoir.fromJson(devoir));
      }*/
      return devoirs;
    }else{
      return [];
    }
  }

  Future<Devoir?> recherche(int id) async {
    final response = await http.get(Uri.parse('$baseDevoirUrl/$id'));

    if (response.statusCode == 200) {
      var responseData = json.decode(response.body);
      Devoir? devoir = Devoir.fromJson(responseData);
      return devoir;
    }
    return null;
  }





  Future<Devoir?> creer(Devoir devoir) async {
    final response = await http.post(
      Uri.parse("$baseDevoirUrl/creer"),
      body: json.encode(devoir),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type': 'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      Devoir createdDevoir = Devoir.fromJson(responseData);
      return createdDevoir;
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

  Future<Devoir?> creerDevoi(int mentorId, int classeId , Devoir devoir ,  File? pieceJointe) async {
    final response = await http.post(
      Uri.parse('$baseDevoirUrl/mentor/$mentorId/classe'),
      body: jsonEncode(devoir),
      headers: {
        // Je m'assure que le type de média est défini sur JSON
        'Content-Type':'application/json'
      },
    );

    if (response.statusCode == 200) {
      print("Success");
      var responseData = json.decode(utf8.decode(response.bodyBytes));
      Devoir createdDevoir = Devoir.fromJson(responseData);
      return createdDevoir;
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

  Future<Devoir> creerDevoir(int idMentor ,int idClasse,Devoir devoir, File? pieceJointe) async {
    var request = http.MultipartRequest('POST', Uri.parse("$baseDevoirUrl/creerDevoir"));
    request.files.add(http.MultipartFile(
        'pieceJointe', pieceJointe!.readAsBytes().asStream(), pieceJointe!.lengthSync(),
        filename: basename(pieceJointe.path)));
    request.fields['devoir'] = jsonEncode(devoir.toJson());
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      final responseData = json.decode(responsed.body);
      debugPrint(responsed.body);
      //notifyListeners();
      return Devoir.fromJson(responseData);
    } else {
      debugPrint(responsed.body);
      throw Exception('Impossible d\'ajouter un devoir');
    }
  }
}