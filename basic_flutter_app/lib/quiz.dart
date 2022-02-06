import 'package:flutter/material.dart';

import './question.dart';
import './answer.dart';

class Quiz extends StatelessWidget {
  final List<Map<String, Object>> questions;
  final VoidCallback answerTheQuestion;
  final int questionIndex;

  Quiz(
      {required this.questions,
      required this.answerTheQuestion,
      required this.questionIndex});

  @override
  Widget build(BuildContext context) {
    return Column(
      //TODO: Column is a layout where we can put a list of widgets, I used if and else in following format: condition ? then : else
      children: <Widget>[
        Question(
            questionTxt: questions
                .elementAt(questionIndex)['questionKey']
                .toString()), // or questions[questionIndex]
        /*TODO: transform list element to another type, 
            '...' is called spread operator, it will put elements inside the list instead of having a list of list
            */
        ...(questions[questionIndex]['answersKey'] as List<String>)
            .map((answer) {
          return Answer(answerTheQuestion, answer);
        }).toList()
      ],
    );
  }
}
