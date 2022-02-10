import 'package:flutter/material.dart';

class MealDetailScreen extends StatelessWidget {
  //TODO best practice to save the routes
  static const routeName = '/meal-detail';

  const MealDetailScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;

    return Scaffold(
      appBar: AppBar(
        title: const Text('Best Meals App'),
      ),
      body: Center(
        child: Text('meal $mealId'),
      ),
    );
  }
}
