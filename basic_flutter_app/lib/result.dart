import 'package:flutter/material.dart';

class Result extends StatelessWidget {
  final int score;
  final VoidCallback resetHandler;

  Result({required this.score, required this.resetHandler});

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
        child: Column(
      children: [
        Text(
          resultText,
          style: TextStyle(fontSize: 40, fontWeight: FontWeight.bold),
          textAlign: TextAlign.center,
        ),
        ElevatedButton(onPressed: resetHandler, child: Text('Reset Quiz!'))
      ],
    )); //TODO: center will center horizontally and vertically the child;
  }
}
