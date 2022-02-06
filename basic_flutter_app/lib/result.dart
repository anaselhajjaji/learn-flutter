import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;

  Result({required this.score});

  //TODO: getter example
  String get resultText {
    var resultTxt = 'Well done!';
    if (score <= 5) {
      resultTxt = 'Good!';
    }
    return resultTxt;
  }

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Text(
      resultText,
      style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
    )); //TODO: center will center horizontally and vertically the child;
  }
}
