import 'package:flutter/material.dart';

import '../widgets/meal_item.dart';
import '../models/meal.dart';

class CategoryMealsScreen extends StatelessWidget {
  //TODO best practice to save the routes
  static const routeName = '/category-meals';

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

    final categoryMeals = Meal.getDummyMeals().where((meal) {
      return meal.categories.contains(categoryId);
    }).toList();

    return Scaffold(
      appBar: AppBar(
        title: Text(categoryTitle ?? categoryTitle as String),
      ),
      body: ListView.builder(
        itemBuilder: (ctx, index) {
          return MealItem(
              id: categoryMeals[index].id,
              title: categoryMeals[index].title,
              imageUrl: categoryMeals[index].imageUrl,
              duration: categoryMeals[index].duration,
              complexity: categoryMeals[index].complexity,
              affordability: categoryMeals[index].affordability);
        },
        itemCount: categoryMeals.length,
      ),
    );
  }
}
