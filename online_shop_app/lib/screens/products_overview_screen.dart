import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../providers/products.dart';
import '../widgets/app_drawer.dart';
import '../screens/cart_screen.dart';
import '../providers/cart.dart';
import '../widgets/badge.dart';
import '../widgets/products_grid.dart';

enum FilterOptions {
  favorites,
  all,
}

// TODO here we used statefull instead of provider because we want the state to be local for favorites
class ProductsOverviewScreen extends StatefulWidget {
  const ProductsOverviewScreen({Key? key}) : super(key: key);

  @override
  State<ProductsOverviewScreen> createState() => _ProductsOverviewScreenState();
}

class _ProductsOverviewScreenState extends State<ProductsOverviewScreen> {
  var _showOnlyFavorites = false;
  var _isInit = true;
  var _isLoading = false;
  @override
  void initState() {
    // TODO best place to trigger fetching products from web, but wont work because the widget is not yet ready
    // Provider.of<Products>(context).fetchProducts();
    // TODO solution 1 (hack)
    //Future.delayed(Duration.zero).then((_) {
    //  Provider.of<Products>(context).fetchProducts();
    //});
    // TODO solution 2 use of didChangeDependencies()
    super.initState();
  }

  @override
  void didChangeDependencies() {
    if (_isInit) {
      setState(() {
        _isLoading = true;
      });

      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          _isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Shopping App'),
        actions: [
          PopupMenuButton(
            itemBuilder: (_) => [
              const PopupMenuItem(
                child: Text('Only Favorites'),
                value: FilterOptions.favorites,
              ),
              const PopupMenuItem(
                child: Text('Show All'),
                value: FilterOptions.all,
              ),
            ],
            icon: const Icon(Icons.more_vert),
            onSelected: (FilterOptions selectedValue) {
              setState(() {
                if (selectedValue == FilterOptions.favorites) {
                  _showOnlyFavorites = true;
                } else {
                  _showOnlyFavorites = false;
                }
              });
            },
          ),
          Consumer<Cart>(
            builder: (_, cart, ch) => Badge(
              child: ch!,
              value: cart.itemCount.toString(),
            ),
            child: IconButton(
              icon: const Icon(
                Icons.shopping_cart,
              ),
              onPressed: () {
                Navigator.of(context).pushNamed(CartScreen.routeName);
              },
            ),
          )
        ],
      ),
      drawer: const AppDrawer(),
      body: _isLoading
          ? const Center(
              child: CircularProgressIndicator(),
            )
          : ProductsGrid(showOnlyFavorites: _showOnlyFavorites),
    );
  }
}
