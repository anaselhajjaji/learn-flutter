import 'package:flutter/material.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  //TODO used to manage focus when next is pushed on soft keyboard
  // to be confirmed but maybe not necessary in newer versions of flutter
  // I didn't use focus node for other fields.
  final _priceFocusNode = FocusNode();

  @override
  void dispose() {
    //TODO focus node should be disposed.
    _priceFocusNode.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
      ),
      // TODO to handle all the input features, it's recommended to use Form widget
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          //TODO Using ListView, user input might get lost if an input fields scrolls out of view
          // because the ListView widget dynamically removes and re-adds widgets as they scroll out of and back into view.
          // In that case Column with SingleChildScrollView should be used.
          child: ListView(
            children: [
              // TODO use TextFormField instead of TextField, TextFormField is automatically connected to the form
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Title',
                ),
                textInputAction: TextInputAction.next,
                onFieldSubmitted: (_) {
                  FocusScope.of(context).requestFocus(_priceFocusNode);
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
