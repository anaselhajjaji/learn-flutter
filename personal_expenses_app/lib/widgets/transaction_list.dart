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
      child: transactions.isEmpty
          //TODO: draw a waiting image when there is no transaction
          ? Column(
              children: [
                Text(
                  'Waiting for transactions...',
                  style: Theme.of(context).textTheme.titleMedium,
                ),
                //TODO: good widget to be used to make spacing between widgets
                SizedBox(
                  height: 20,
                ),
                //TODO: To include an image and respect the size of the parent container using fit property
                Container(
                  height: 100,
                  child: Image.asset(
                    'assets/images/waiting.png',
                    fit: BoxFit.cover,
                  ),
                )
              ],
            )
          /* TODO: the list view needs to know the height and the parent container we have here will give that information to the list view.
          Two possible usages of listview:
          - ListView(children: []): will act as a scrollable column so will render all the children widgets which is not performent at all
          - ListView.builder(): will render only visible widgets and will recycle then while scrolling
          */
          : ListView.builder(
              itemBuilder: (ctx, itemIndex) {
                return Card(
                  child: Row(children: <Widget>[
                    Container(
                      margin:
                          EdgeInsets.symmetric(vertical: 10, horizontal: 15),
                      decoration: BoxDecoration(
                          border: Border.all(
                              //TODO: to use the primary color we need to get the current theme
                              color: Theme.of(context).primaryColorDark,
                              width: 2)),
                      padding: EdgeInsets.all(10),
                      child: Text(
                          '\$${transactions[itemIndex].amount.toStringAsFixed(2)}', //TODO: called string interpolation and with fixed fraction of digits
                          style: TextStyle(
                              fontWeight: FontWeight.bold,
                              fontSize: 20,
                              //TODO: to use the primary color we need to get the current theme
                              color: Theme.of(context).primaryColorDark)),
                    ),
                    Column(
                      //TODO: For a column crossAxisAlignment is from left to right and for a row it's from top to bottom
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: <Widget>[
                        Text(
                          transactions[itemIndex].title,
                          // TODO: we can set here a font specifically to a text, we take the style from the theme
                          style: Theme.of(context).textTheme.titleMedium,
                        ),
                        Text(
                          //TODO: I used intl package that supports a lot of date formatting patterns
                          DateFormat.yMMMd()
                              .format(transactions[itemIndex].date),
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
