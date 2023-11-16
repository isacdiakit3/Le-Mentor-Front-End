import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AccueilMentor extends StatefulWidget {
  const AccueilMentor({Key? key}) : super(key: key);

  @override
  State<AccueilMentor> createState() => _AccueilMentorState();
}

class _AccueilMentorState extends State<AccueilMentor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("accueil")
        ],
      ),
    );
  }
}
