import 'package:flutter/material.dart';

import './favorites_screen.dart';
import './categories_screen.dart';

class BottomTabsScreen extends StatefulWidget {
  const BottomTabsScreen({Key? key}) : super(key: key);

  @override
  _BottomTabsScreenState createState() => _BottomTabsScreenState();
}

class _BottomTabsScreenState extends State<BottomTabsScreen> {
  final List<Widget> _pages = const [
    CategoriesScreen(),
    FavoritesScreen(),
  ];
  int _selectedPageIndex = 0;

  void _selectPage(int index) {
    setState(() {
      _selectedPageIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    //TODO build bottom tabs using flutter
    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Meals App'),
      ),
      body: _pages[_selectedPageIndex],
      bottomNavigationBar: BottomNavigationBar(
        backgroundColor: Theme.of(context).primaryColor,
        unselectedItemColor: Colors.white,
        selectedItemColor: Theme.of(context).colorScheme.secondary,
        currentIndex:
            _selectedPageIndex, //TODO we need to tell which one is selected
        type: BottomNavigationBarType.shifting, //TODO a nice bottom bar
        onTap: _selectPage,
        items: [
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context)
                .primaryColor, //TODO needed for BottomNavigationBarType.shifting
            icon: const Icon(Icons.category),
            label: 'Categories',
          ),
          BottomNavigationBarItem(
            backgroundColor: Theme.of(context)
                .primaryColor, //TODO needed for BottomNavigationBarType.shifting
            icon: const Icon(Icons.star),
            label: 'Favorites',
          ),
        ],
      ),
    );
  }
}
