import 'package:flutter/material.dart'; // TODO: this package will contain all the material widgets that we'll need

void main() { //TODO: entrypoint of our application, should be present in the main dart file
  runApp(MyApp()); //TODO: This a core function of material package to run the application: draw the widget tree. 
}

class MyApp extends StatelessWidget { //TODO: that's the root widget of our app
  
  Widget build(BuildContext context) { //TODO: method that we need to override when using StatelessWidget class
    /*TODO: that's the app coming from material package that will do all the initializations needed for the root widget.
      home: argument will contain the widget to put inside the MaterialApp widget.
    */
    return MaterialApp(home: Text('Hello!'));
  }
}