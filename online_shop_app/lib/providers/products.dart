import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

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

  // TODO in order to use async await, add async keyword
  Future<void> addProduct(Product product) async {
    //TODO http post example
    final url = Uri.parse(
        'https://flutter-shop-app-1e327-default-rtdb.firebaseio.com/products.json');

    // TODO instead of returning a future, we can use await keyword
    try {
      final response = await http.post(
        url,
        body: json.encode(
          {
            'title': product.title,
            'description': product.description,
            'imageUrl': product.imageUrl,
            'price': product.price,
            'isFavorite': product.isFavorite,
          },
        ),
      );

      final newProduct = Product(
        id: json.decode(response.body)['name'], //get the id from the server
        title: product.title,
        description: product.description,
        price: product.price,
        imageUrl: product.imageUrl,
      );

      _items.add(newProduct);
      notifyListeners();
    } catch (error) {
      // TODO I'll catch it here and rethrow it to be catched later
      print(error);
      rethrow;
    }
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
