import 'package:flutter/material.dart';

class ProfilMentor extends StatefulWidget {
  const ProfilMentor({Key? key}) : super(key: key);

  @override
  State<ProfilMentor> createState() => _ProfilMentorState();
}

class _ProfilMentorState extends State<ProfilMentor> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Profil")
        ],
      ),
    );
  }
}
