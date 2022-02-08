import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../models/transaction.dart';

class TransactionList extends StatelessWidget {
  final List<Transaction> transactions;
  final void Function(String id) onDeleteTransaction;

  TransactionList(
      {required this.transactions, required this.onDeleteTransaction});

  @override
  Widget build(BuildContext context) {
    return transactions.isEmpty
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
              /* OLD WAY
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
                );*/
              //TODO: NEW WAY using ListTile
              return Card(
                margin: EdgeInsets.symmetric(
                  vertical: 8,
                  horizontal: 5,
                ),
                elevation: 5,
                child: ListTile(
                  leading: CircleAvatar(
                    radius: 30,
                    child: Padding(
                      padding: const EdgeInsets.all(9),
                      child: FittedBox(
                        child: Text(
                            '\$${transactions[itemIndex].amount.toStringAsFixed(2)}'),
                      ),
                    ),
                  ),
                  title: Text(
                    transactions[itemIndex].title,
                    // TODO: we can set here a font specifically to a text, we take the style from the theme
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                  subtitle: Text(
                    //TODO: I used intl package that supports a lot of date formatting patterns
                    DateFormat.yMMMd().format(transactions[itemIndex].date),
                    style: TextStyle(color: Colors.grey),
                  ),
                  //TODO: trailing can be used to add buttons to ListTile
                  trailing: IconButton(
                    icon: Icon(Icons.delete),
                    color: Theme.of(context).errorColor,
                    onPressed: () =>
                        onDeleteTransaction(transactions[itemIndex].id),
                  ),
                ),
              );
            },
            itemCount: transactions.length,
          );
  }
}
