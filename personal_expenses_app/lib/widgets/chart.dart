import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../widgets/chart_bar.dart';
import '../models/transaction.dart';

class Chart extends StatelessWidget {
  final List<Transaction> recentTransactions;

  List<Map<String, Object>> get groupedTransactionsValues {
    // TODO: example of List.generate(), generation of list
    return List.generate(7, (index) {
      final weekDay = DateTime.now().subtract(
        Duration(days: index),
      );

      var totalSum = 0.0;
      for (var recentTransaction in recentTransactions) {
        if (recentTransaction.date.day == weekDay.day &&
            recentTransaction.date.month == weekDay.month &&
            recentTransaction.date.year == weekDay.year) {
          totalSum += recentTransaction.amount;
        }
      }

      return {
        'day': DateFormat.E().format(weekDay).substring(0, 1),
        'amount': totalSum
      };
    });
  }

  double get totalSpending {
    //TODO: fold() will change a list to another type
    return groupedTransactionsValues.fold(0.0, (sum, item) {
      return sum + (item['amount'] as double);
    });
  }

  const Chart({Key? key, required this.recentTransactions}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 6,
      margin: EdgeInsets.all(20),
      child: Container(
        padding: EdgeInsets.all(10),
        child: Row(
            //TODO: in a row the main axis alignement is from left to right
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: groupedTransactionsValues.map((data) {
              //TODO: to force a bar to use the available, Flexible can help to distribute the size in a row or column
              return Flexible(
                fit: FlexFit.tight,
                child: ChartBar(
                  label: data['day'] as String,
                  spendingAmount: data['amount'] as double,
                  spendingPercentageOfTotal: totalSpending == 0.0
                      ? 0.0
                      : (data['amount'] as double) / totalSpending,
                ),
              );
            }).toList()),
      ),
    );
  }
}
