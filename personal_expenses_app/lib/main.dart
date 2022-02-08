import 'package:flutter/material.dart';

import './widgets/user_transactions.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter App',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(
          //TODO: for a column the main axis is top to bottom and cross axis is left to right
          mainAxisAlignment: MainAxisAlignment.start,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: <Widget>[
            Container(
                //TODO: take the maximum width
                width: double.infinity,
                //TODO: Card takes the size of the child widget or the parent that has width already set, we use Container to set the size of the card.
                child: Card(
                  child: Text('Chart'),
                  elevation: 5,
                )),
            UserTransactions()
          ]),
    );
  }
}
