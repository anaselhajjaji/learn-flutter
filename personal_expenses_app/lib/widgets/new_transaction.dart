import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:intl/intl.dart';

/*TODO: the reason why StatefulWidget is used instead of Stateless 
 is to avoid loosing data in the modal bottom sheet, flutter needs that internally.
 When we're loosing data it means that we may need StatefulWidget to keep that data.
*/
class NewTransaction extends StatefulWidget {
  final Function onAddNewTransaction;

  /* TODO: in some scenarios a key is necessary, for example when we have a listview containing items
  When creating an item we should set the unique key so flutter won't reuse the old state when the widget 
  is deleted because key will be stored in both Widget and Element. (key: ValueKey(transaction.id)) or (key: UniqueKey()) 
  Should be used only when needed, no need to set keys everywhere.
  Keys will help flutter link elements (in element tree) with the widgets (widget tree) correctly.
  https://www.youtube.com/watch?v=kn0EOS-ZiIc */
  NewTransaction({Key? key, required this.onAddNewTransaction})
      : super(key: key);

  @override
  State<NewTransaction> createState() => _NewTransactionState();
}

class _NewTransactionState extends State<NewTransaction> {
  final _titleController = TextEditingController();
  final _amountController = TextEditingController();
  DateTime? _selectedDate;

  void _submitTransaction() {
    if (_amountController.text.isEmpty) {
      return;
    }

    final enteredTitle = _titleController.text;
    final enteredAmount = double.parse(_amountController.text);

    if (enteredTitle.isEmpty || enteredAmount <= 0 || _selectedDate == null) {
      return;
    }

    // TODO: to acceess widget properties from the state
    widget.onAddNewTransaction(enteredTitle, enteredAmount, _selectedDate);

    // TODO: to close the bottom sheet after submiting the data
    Navigator.of(context).pop();
  }

  void _displayDatePicker() {
    //TODO: to display the date picker, returns a Future we have here an example of Future usage
    showDatePicker(
      context: context,
      initialDate: DateTime.now(),
      firstDate: DateTime(2022),
      lastDate: DateTime.now(),
    ).then((pickedDate) {
      if (pickedDate == null) {
        return;
      }

      setState(() {
        _selectedDate = pickedDate;
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      child: Card(
        elevation: 5,
        //TODO: Container used to add padding (which doesn't exist in the Card)
        child: Container(
          padding: EdgeInsets.only(
            top: 10,
            left: 10,
            right: 10,
            // TODO: to manage the soft keyboard that will appear in the bottom of the screen
            bottom: MediaQuery.of(context).viewInsets.bottom + 10,
          ),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: <Widget>[
              //TODO: we can do here Platform.isIOS to use CupertinoTextField()
              TextField(
                decoration: InputDecoration(labelText: 'Title'),
                controller: _titleController,
                onSubmitted: (_) =>
                    _submitTransaction(), //TODO: the (_) is to tell that I know I'll have an argument but I won't use it
                /* TODO: Can be done this way as well
                          onChanged: (value) {
                          titleInput = value;
                        },*/
              ),
              TextField(
                decoration: InputDecoration(labelText: 'Amount'),
                controller: _amountController,
                keyboardType:
                    TextInputType.number, //TODO: to have a number keyboard
                onSubmitted: (_) =>
                    _submitTransaction(), //TODO: the (_) is to tell that I know I'll have an argument but I won't use it
                /*TODO: Can be done this way as well
                          onChanged: (value) {
                          amountInput = value;
                        },*/
              ),
              Container(
                height: 70,
                child: Row(
                  children: [
                    Expanded(
                      child: Text(_selectedDate == null
                          ? 'No Date Chosen'
                          : 'Picked Date: ${DateFormat.yMd().format(_selectedDate ?? DateTime.now())}'),
                    ),
                    //TODO: use cupertino button instead of material button
                    Platform.isIOS
                        ? CupertinoButton(
                            child: Text(
                              'Choose a date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                            onPressed: _displayDatePicker)
                        : TextButton(
                            onPressed: _displayDatePicker,
                            child: Text(
                              'Choose a date',
                              style: TextStyle(
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                  ],
                ),
              ),
              ElevatedButton(
                  onPressed: () => _submitTransaction(),
                  child: Text('Add Transaction'))
            ],
          ),
        ),
      ),
    );
  }
}
