import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  String questionTxt;

  Question({this.questionTxt = ""});

  @override
  Widget build(BuildContext context) {
    return Text(questionTxt);
  }
}
