import 'package:flutter/material.dart';

class Question extends StatelessWidget {
  final String
      questionTxt; //TODO: final because the widget is immutable and the property can be changed, so final to prevent the property from been changed.

  Question({this.questionTxt = ""});

  @override
  Widget build(BuildContext context) {
    return Container(
        //TODO: container is invisible, we used it here especially for the width property
        width: double
            .infinity, //TODO: double.infinity: the container will take all the width available
        margin: EdgeInsets.all(20), //TODO: spacing around the container
        child: Text(
          questionTxt,
          style: TextStyle(
              fontSize: 30), //TODO: here we can do some styling to the text
          textAlign: TextAlign.center,
        ));
  }
}
