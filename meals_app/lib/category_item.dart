import 'package:flutter/material.dart';

import './category_meals_screen.dart';

class CategoryItem extends StatelessWidget {
  final String title;
  final Color color;

  const CategoryItem({Key? key, required this.title, required this.color})
      : super(key: key);

  void selectCategory(BuildContext ctx) {
    //TODO Navigator to be used for navigation between screens
    Navigator.of(ctx).push(
      MaterialPageRoute(
        builder: (_) {
          return const CategoryMealsScreen();
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    //TODO InkWell is a gesture detector with Ripple Effect
    return InkWell(
      onTap: () => selectCategory(context),
      splashColor: Theme.of(context).primaryColor,
      //TODO: to have a consistent Ripple effect with the category container
      borderRadius: BorderRadius.circular(15),
      child: Container(
        padding: const EdgeInsets.all(15),
        child: Text(
          title,
          style: Theme.of(context).textTheme.titleMedium,
        ),
        decoration: BoxDecoration(
          gradient: LinearGradient(
            colors: [
              color.withOpacity(0.7),
              color,
            ],
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
          ),
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    );
  }
}
