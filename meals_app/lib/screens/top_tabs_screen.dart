import 'package:flutter/material.dart';

import '../models/meal.dart';
import './favorites_screen.dart';
import './categories_screen.dart';

class TopTabsScreen extends StatelessWidget {
  final List<Meal> favoriteMeals;

  const TopTabsScreen({
    Key? key,
    required this.favoriteMeals,
  }) : super(key: key);

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
        body: TabBarView(children: [
          const CategoriesScreen(),
          FavoritesScreen(
            favoriteMeals: favoriteMeals,
          ),
        ]),
      ),
    );
  }
}
