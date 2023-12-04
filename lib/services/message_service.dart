//import 'dart:io' if (dart.library.js) 'dart:js' as js;
import 'dart:convert';
import 'dart:io';
import 'package:path/path.dart';
import 'package:flutter/material.dart';
import 'package:le_mentor/models/message.dart';
import 'package:http/http.dart' as http;
import '../pages/constante.dart';

class MessageService extends ChangeNotifier{

  static const baseMessageUrl = "$baseUrl/message";
  Message message = Message();

  Future<Message> creerMessage(int idMentor ,int idClasse,Message message, File? pieceJointe) async {
    var request = http.MultipartRequest('POST', Uri.parse("$baseMessageUrl/creerMessage"));
    request.files.add(http.MultipartFile(
        'pieceJointe', pieceJointe!.readAsBytes().asStream(), pieceJointe!.lengthSync(),
        filename: basename(pieceJointe.path)));
    request.fields['message'] = jsonEncode(message.toJson());
    var response = await request.send();

    var responsed = await http.Response.fromStream(response);
    if (response.statusCode == 201) {
      final responseData = json.decode(responsed.body);
      debugPrint(responsed.body);
      notifyListeners();
      return Message.fromJson(responseData);
    } else {
      debugPrint(responsed.body);
      throw Exception('Impossible d\'ajouter un message');
    }
  }

  Future<List<Message>> lire(int id) async {
    final response = await http.get(Uri.parse("$baseMessageUrl/messageClasse/$id"));

    if (response.statusCode == 200) {
      print("========================================================");
      List<dynamic> list = jsonDecode(utf8.decode(response.bodyBytes));
      print(jsonDecode(utf8.decode(response.bodyBytes)));
      List<Message> messages = list.map((e) => Message.fromJson(e)).toList();

      /*for (var classe in responseData) {
        classes.add(Classe.fromJson(classe));
      }*/
      return messages;
    }else{
      return [];
    }
  }

}