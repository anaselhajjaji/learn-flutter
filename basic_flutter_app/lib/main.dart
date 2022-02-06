import 'package:flutter/material.dart'; // TODO: this package will contain all the material widgets that we'll need

import './question.dart';
import './answer.dart';

// TODO: can be done this way as well: void main() => runApp(MyApp());
void main() {
  //TODO: entrypoint of our application, should be present in the main dart file
  runApp(
      //TODO: This a core function of material package to run the application: draw the widget tree.
      MyApp());
}

/*TODO: that's the root widget of our app, a widget should extend: StatelessWidget or StatefulWidget
  StatelessWidget: widget that can't have state, cannot change internally after been built. Can change only externally (ex. input data)
  StatefulWidget: can be changed internally after been built, will get rendered when local state changes
  Convention: one widget per file.
*/
class MyApp extends StatefulWidget {
  @override
  State<StatefulWidget> createState() {
    return _MyAppState();
  }
}

/*TODO: State is a generic class, is attached to the widget and will be used to store the state. So widget will be recreated but state will be persistent.
the '_' is a dart syntax to make the class private so can be used only inside the file main.dart.
*/
class _MyAppState extends State<MyApp> {
  var _questionIndex = 0; //TODO: use '_' for private property
  final questions = const [
    //TODO: with const here we cannot add for example a new element to the list
    //TODO: we'll use a map
    {
      'questionKey': 'What\'s your name?',
      'answersKey': ['Anas', 'Mike', 'Tom', 'Leonard']
    },
    {
      'questionKey': 'How old are you?',
      'answersKey': ['20', '30', '40', '50', '60']
    },
    {
      'questionKey': 'Where do you live?',
      'answersKey': ['Canada', 'USA', 'Morocco']
    }
  ];

  //TODO: use '_' for private method
  void _answerTheQuestion() {
    /*TODO: Need to call that in order to trigger the change, otherwise the widget won't be recreated. 
      It will just call the build() method of the widget. Flutter is intelligent and will not render the entire widget tree for that.
      */
    setState(() {
      _questionIndex = _questionIndex + 1;
    });
  }

  @override //TODO: decorator, not required but we can added it to make our code readable and cleaner (best practice)
  Widget build(BuildContext context) {
    //TODO: method that we need to override when using StatelessWidget (or StatefulWidget) class

    /*TODO: that's the app coming from material package that will do all the initializations needed for the root widget.
      home: argument will contain the widget to put inside the MaterialApp widget.
    */
    return MaterialApp(
      home: Scaffold(
        //TODO: Scaffold gives a basic design/style to the Widget tree
        appBar: AppBar(
          title: Text('Basic Flutter App'),
        ),
        body: _questionIndex < questions.length
            ? Column(
                //TODO: Column is a layout where we can put a list of widgets, I used if and else in following format: condition ? then : else
                children: <Widget>[
                  Question(
                      questionTxt: questions
                          .elementAt(_questionIndex)['questionKey']
                          .toString()), // or questions[questionIndex]
                  /*TODO: transform list element to another type, 
            '...' is called spread operator, it will put elements inside the list instead of having a list of list
            */
                  ...(questions[_questionIndex]['answersKey'] as List<String>)
                      .map((answer) {
                    return Answer(_answerTheQuestion, answer);
                  }).toList()
                ],
              )
            : Center(
                child: Text(
                    'Well done!')), //TODO: center will center horizontally and vertically the child
      ),
    );
  }
}
