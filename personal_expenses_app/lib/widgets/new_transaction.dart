import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function onAddNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction({Key? key, required this.onAddNewTransaction})
      : super(key: key);

  void submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    onAddNewTransaction(enteredTitle, enteredAmount);
  }

  @override
  Widget build(BuildContext context) {
    return Card(
      elevation: 5,
      //TODO: Container used to add padding (which doesn't exist in the Card)
      child: Container(
        padding: EdgeInsets.all(10),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.end,
          children: <Widget>[
            TextField(
              decoration: InputDecoration(labelText: 'Title'),
              controller: titleController,
              onSubmitted: (_) =>
                  submitTransaction(), //TODO: the (_) is to tell that I know I'll have an argument but I won't use it
              /* TODO: Can be done this way as well
                        onChanged: (value) {
                        titleInput = value;
                      },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              keyboardType:
                  TextInputType.number, //TODO: to have a number keyboard
              onSubmitted: (_) =>
                  submitTransaction(), //TODO: the (_) is to tell that I know I'll have an argument but I won't use it
              /*TODO: Can be done this way as well
                        onChanged: (value) {
                        amountInput = value;
                      },*/
            ),
            TextButton(
                onPressed: () => submitTransaction,
                child: Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
