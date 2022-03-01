import 'package:flutter/foundation.dart';

import './product.dart';

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

  List<Product> get favoriteItems {
    return _items.where((product) => product.isFavorite).toList();
  }

  void addProduct(Product product) {
    final newProduct = Product(
      id: DateTime.now().toString(),
      title: product.title,
      description: product.description,
      price: product.price,
      imageUrl: product.imageUrl,
    );

    _items.add(newProduct);
    notifyListeners();
  }

  void updateProduct(String id, Product product) {
    final index = _items.indexWhere((prod) => prod.id == id);
    if (index >= 0) {
      _items[index] = product;
      notifyListeners();
    }
  }

  void deleteProduct(String id) {
    _items.removeWhere((prod) => prod.id == id);
    notifyListeners();
  }
}
