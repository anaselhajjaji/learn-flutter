import 'package:flutter/material.dart';

/*TODO: the reason why StatefulWidget is used instead of Stateless 
 is to avoid loosing data in the modal bottom sheet, flutter needs that internally.
 When we're loosing data it means that we may need StatefulWidget to keep that data.
*/
class NewTransaction extends StatefulWidget {
  final Function onAddNewTransaction;

  NewTransaction({Key? key, required this.onAddNewTransaction})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final titleController = TextEditingController();

  final amountController = TextEditingController();

  void submitTransaction() {
    final enteredTitle = titleController.text;
    final enteredAmount = double.parse(amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0) {
      return;
    }

    // TODO: to acceess widget properties from the state
    widget.onAddNewTransaction(enteredTitle, enteredAmount);

    // TODO: to close the bottom sheet after submiting the data
    Navigator.of(context).pop();
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
