import 'package:flutter/material.dart';

import './new_transaction.dart';
import './transaction_list.dart';
import '../models/transaction.dart';

class UserTransactions extends StatefulWidget {
  const UserTransactions({Key? key}) : super(key: key);

  @override
  _UserTransactionsState createState() => _UserTransactionsState();
}

class _UserTransactionsState extends State<UserTransactions> {
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        NewTransaction(onAddNewTransaction: _addNewTransaction),
        TransactionList(transactions: _transactions)
      ],
    );
  }
}
