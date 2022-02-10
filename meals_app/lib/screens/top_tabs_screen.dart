import 'package:flutter/material.dart';

import './favorites_screen.dart';
import './categories_screen.dart';

class TopTabsScreen extends StatelessWidget {
  const TopTabsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO build top tabs using flutter
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Best Meals App'),
          bottom: const TabBar(tabs: [
            Tab(
              icon: Icon(
                Icons.category,
              ),
              text: 'Categories',
            ),
            Tab(
              icon: Icon(
                Icons.star,
              ),
              text: 'Favorites',
            ),
          ]),
        ),
        body: const TabBarView(children: [
          CategoriesScreen(),
          FavoritesScreen(),
        ]),
      ),
    );
  }
}
