import 'package:flutter/material.dart';

class NewTransaction extends StatelessWidget {
  final Function onAddNewTransaction;
  final titleController = TextEditingController();
  final amountController = TextEditingController();

  NewTransaction({Key? key, required this.onAddNewTransaction})
      : super(key: key);

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
              /* TODO: Can be done this way as well
                        onChanged: (value) {
                        titleInput = value;
                      },*/
            ),
            TextField(
              decoration: InputDecoration(labelText: 'Amount'),
              controller: amountController,
              /*TODO: Can be done this way as well
                        onChanged: (value) {
                        amountInput = value;
                      },*/
            ),
            TextButton(
                onPressed: () {
                  onAddNewTransaction(titleController.text,
                      double.parse(amountController.text));
                },
                child: Text('Add Transaction'))
          ],
        ),
      ),
    );
  }
}
