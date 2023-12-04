import 'package:flutter/material.dart';
import 'package:le_mentor/pages/constante.dart';


class FormQuiz extends StatefulWidget {
  const FormQuiz({Key? key}) : super(key: key);

  @override
  State<FormQuiz> createState() => _FormQuizState();
}

class _FormQuizState extends State<FormQuiz> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text("Question"),
        backgroundColor: (myColor),
      ),
      body: Center(
        child: Container(
          child: Text("question"),
        ),
      ),
    );
  }
}
