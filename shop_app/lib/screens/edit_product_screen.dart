import 'package:flutter/material.dart';
import 'package:shop_app/providers/product.dart';

class EditProductScreen extends StatefulWidget {
  static const routeName = '/edit-product';

  const EditProductScreen({Key? key}) : super(key: key);

  @override
  _EditProductScreenState createState() => _EditProductScreenState();
}

class _EditProductScreenState extends State<EditProductScreen> {
  final _imageUrlController = TextEditingController();
  final _imageUrlFocusNode = FocusNode();
  var _editedProduct =
      Product(id: '', title: '', description: '', price: 0, imageUrl: '');

  //TODO the globalkey will help us to get access to the form
  final _form = GlobalKey<FormState>();

  //TODO used to manage focus when next is pushed on soft keyboard
  // to be confirmed but maybe not necessary in newer versions of flutter
  // I didn't use focus node for other fields.
  final _priceFocusNode = FocusNode();

  @override
  void initState() {
    _imageUrlFocusNode.addListener(_updateImageUrl);
    super.initState();
  }

  @override
  void dispose() {
    //TODO focus node should be disposed.
    _imageUrlFocusNode.removeListener(_updateImageUrl);
    _priceFocusNode.dispose();
    _imageUrlController.dispose();
    _imageUrlFocusNode.dispose();
    super.dispose();
  }

  void _updateImageUrl() {
    if (!_imageUrlFocusNode.hasFocus) {
      //TODO to trigger the UI update
      setState(() {});
    }
  }

  void _saveForm() {
    //TODO Save will save the form, so it will trigger a onSave method on each textformfield
    _form.currentState?.save();

    //TODO Here we have a complete product object
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Edit Product'),
        actions: [
          IconButton(
            onPressed: _saveForm,
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      // TODO to handle all the input features, it's recommended to use Form widget
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Form(
          key: _form,
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
                onSaved: (value) {
                  _editedProduct = Product(
                    id: '',
                    title: value as String,
                    description: _editedProduct.description,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Price',
                ),
                textInputAction: TextInputAction.next,
                keyboardType: TextInputType.number,
                focusNode: _priceFocusNode,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: '',
                    title: _editedProduct.title,
                    description: _editedProduct.description,
                    price: double.parse(value as String),
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              TextFormField(
                decoration: const InputDecoration(
                  labelText: 'Description',
                ),
                maxLines: 3,
                keyboardType: TextInputType.multiline,
                onSaved: (value) {
                  _editedProduct = Product(
                    id: '',
                    title: _editedProduct.title,
                    description: value as String,
                    price: _editedProduct.price,
                    imageUrl: _editedProduct.imageUrl,
                  );
                },
              ),
              Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                children: [
                  Container(
                    width: 100,
                    height: 100,
                    margin: const EdgeInsets.only(
                      top: 8,
                      right: 10,
                    ),
                    decoration: BoxDecoration(
                      border: Border.all(
                        width: 1,
                        color: Colors.grey,
                      ),
                    ),
                    child: _imageUrlController.text.isEmpty
                        ? const Text('Enter a URL')
                        : FittedBox(
                            child: Image.network(_imageUrlController.text),
                            fit: BoxFit.cover,
                          ),
                  ),
                  Expanded(
                    child: TextFormField(
                      decoration: const InputDecoration(
                        labelText: 'Image URL',
                      ),
                      textInputAction: TextInputAction.done,
                      keyboardType: TextInputType.url,
                      controller: _imageUrlController,
                      focusNode: _imageUrlFocusNode,
                      onFieldSubmitted: (_) {
                        _saveForm();
                      },
                      onEditingComplete: () {
                        //TODO to trigger the UI update in order to render the image preview
                        setState(() {});
                      },
                      onSaved: (value) {
                        _editedProduct = Product(
                          id: '',
                          title: _editedProduct.title,
                          description: _editedProduct.description,
                          price: _editedProduct.price,
                          imageUrl: value as String,
                        );
                      },
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
