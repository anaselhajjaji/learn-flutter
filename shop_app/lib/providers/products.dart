import 'package:flutter/material.dart';

import '../models/product.dart';

//TODO provider that will be used to manage the state in the application
// which is called a mixin and it is just sharing methods and properties between classes
// without strong relation between them (inheritence for example)
class Products with ChangeNotifier {
  List<Product> _items = Product.getDummyProducts();

  List<Product> get items {
    // TODO return the copy of the items
    return [..._items];
  }

  Product findById(String id) {
    return _items.firstWhere((product) => product.id == id);
  }
}
