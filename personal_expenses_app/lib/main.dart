import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import './transaction.dart';

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
  // Dummy transaction list
  final List<Transaction> transactions = [
    Transaction(
        id: 'id1', title: 'New Shoes', amount: 85, date: DateTime.now()),
    Transaction(
        id: 'id2', title: 'Groceries', amount: 200, date: DateTime.now())
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Flutter App'),
      ),
      body: Column(children: <Widget>[
        Card(
          //TODO: Card takes the size of the child widget or the parent that has width already set, we use Container to set the size of the card.
          child: Container(
              width: double.infinity, //TODO: take the maximum width
              child: Text('Chart')),
          elevation: 5,
        ),
        Column(
          children: transactions.map((tx) {
            //TODO: to build multiple widgets per transaction list we use map().
            return Card(
              child: Row(children: <Widget>[
                Container(
                  margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                  decoration: BoxDecoration(
                      border: Border.all(color: Colors.purple, width: 2)),
                  padding: EdgeInsets.all(10),
                  child: Text(
                      '\$${tx.amount}', //TODO: called string interpolation
                      style: TextStyle(
                          fontWeight: FontWeight.bold,
                          fontSize: 20,
                          color: Colors.purple)),
                ),
                Column(
                  //TODO: For a column crossAxisAlignment is from left to right and for a row it's from top to bottom
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: <Widget>[
                    Text(
                      tx.title,
                      style:
                          TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                    ),
                    Text(
                      //TODO: I used intl package that supports a lot of date formatting patterns
                      DateFormat.yMMMd().format(tx.date),
                      style: TextStyle(color: Colors.grey),
                    )
                  ],
                )
              ]),
            );
          }).toList(),
        ),
      ]),
    );
  }
}
