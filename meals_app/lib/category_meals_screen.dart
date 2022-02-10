import 'package:flutter/material.dart';

class CategoryMealsScreen extends StatelessWidget {
  String? categoryId;
  String? categoryTitle;

  CategoryMealsScreen({
    Key? key,
    this.categoryId,
    this.categoryTitle,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    //TODO: when using named routes we can extract route arguments
    final routeArgs =
        ModalRoute.of(context)?.settings.arguments as Map<String, String>;
    categoryId = routeArgs['id'];
    categoryTitle = routeArgs['title'];

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? categoryTitle as String),
      ),
      body: const Center(
        child: Text('Category Recipes...'),
      ),
    );
  }
}
