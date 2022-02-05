import 'package:flutter/material.dart';

class Answer extends StatelessWidget {
  final VoidCallback selectHandler; //TODO: pointer to a function
  final String answerText;

  Answer(this.selectHandler, this.answerText);
  
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      child: ElevatedButton(
          style: ButtonStyle(
              backgroundColor: MaterialStateProperty.all(Colors.blue)),
          onPressed: selectHandler,
          child: Text(answerText)),
    );
  }
}
