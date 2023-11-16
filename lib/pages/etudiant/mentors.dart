import 'package:flutter/material.dart';

class Mentors extends StatefulWidget {
  const Mentors({Key? key}) : super(key: key);

  @override
  State<Mentors> createState() => _MentorsState();
}

class _MentorsState extends State<Mentors> {
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text("Mentors")
        ],
      ),
    );
  }
}
