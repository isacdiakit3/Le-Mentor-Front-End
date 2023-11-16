import 'package:flutter/material.dart';

class MesMentors extends StatefulWidget {
  const MesMentors({Key? key}) : super(key: key);

  @override
  State<MesMentors> createState() => _MesMentorsState();
}

class _MesMentorsState extends State<MesMentors> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment:  MainAxisAlignment.center,
        children: [
          Text("Mes Mentors"),
        ],
      ),
    );
  }
}
