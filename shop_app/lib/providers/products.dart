import 'package:flutter/material.dart';

import '../models/product.dart';

// TODO provider that will be used to manage the state in the application
class Products with ChangeNotifier {
  List<Product> _items = Product.getDummyProducts();

  List<Product> get items {
    // TODO return the copy of the items
    return [..._items];
  }
}
