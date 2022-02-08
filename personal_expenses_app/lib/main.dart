import 'package:flutter/material.dart';
import 'package:personal_expenses_app/widgets/transaction_list.dart';

import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme = ThemeData();

    return MaterialApp(
      title: 'Personal Expenses App',
      //TODO: to set the general theme of the application
      theme: theme.copyWith(
          /*TODO: we need to use primarySwatch instead of primaryColor 
          because primary swatch will generate the other colors coming from primary color */
          colorScheme: theme.colorScheme
              .copyWith(primary: Colors.green, secondary: Colors.red)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  // Init to dummy transactions
  final List<Transaction> _transactions = [
    Transaction(
        id: 'id1', title: 'New Shoes', amount: 85, date: DateTime.now()),
    Transaction(
        id: 'id2', title: 'Groceries', amount: 200, date: DateTime.now())
  ];

  void _addNewTransaction(String inputTitle, double inputAmount) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: inputTitle,
        amount: inputAmount,
        date: DateTime.now());

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //TODO: to show bottom sheet
    showModalBottomSheet(
        context: ctx,
        //TODO: we receive context as argument but we won't use it so we can use '_'
        builder: (_) {
          return NewTransaction(onAddNewTransaction: _addNewTransaction);
        });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Flutter App'),
          //TODO: to add actions in app bar
          actions: [
            IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: Icon(Icons.add))
          ],
        ),
        // This will make the view scrollable
        body: SingleChildScrollView(
          child: Column(
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
                TransactionList(transactions: _transactions)
              ]),
        ),
        //TODO: to add floating action button
        floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
        floatingActionButton: FloatingActionButton(
            child: Icon(Icons.add),
            onPressed: () => _startAddNewTransaction(context)));
  }
}
