import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;

  TransactionList({required this.transactions});

  @override
  Widget build(BuildContext context) {
    return Container(
      height: 300,
      /* TODO: the list view needs to know the height and the parent container we have here will give that information to the list view.
      Two possible usages of listview:
      - ListView(children: []): will act as a scrollable column so will render all the children widgets which is not performent at all
      - ListView.builder(): will render only visible widgets and will recycle then while scrolling
      */
      child: ListView.builder(
        itemBuilder: (ctx, itemIndex) {
          return Card(
            child: Row(children: <Widget>[
              Container(
                margin: EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                decoration: BoxDecoration(
                    border: Border.all(color: Colors.purple, width: 2)),
                padding: EdgeInsets.all(10),
                child: Text(
                    '\$${transactions[itemIndex].amount}', //TODO: called string interpolation
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
                    transactions[itemIndex].title,
                    style: TextStyle(fontSize: 16, fontWeight: FontWeight.bold),
                  ),
                  Text(
                    //TODO: I used intl package that supports a lot of date formatting patterns
                    DateFormat.yMMMd().format(transactions[itemIndex].date),
                    style: TextStyle(color: Colors.grey),
                  )
                ],
              )
            ]),
          );
        },
        itemCount: transactions.length,
      ),
    );
  }
}
