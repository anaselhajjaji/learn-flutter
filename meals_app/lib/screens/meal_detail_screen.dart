import 'package:flutter/material.dart';
import 'package:meals_app/models/meal.dart';

class MealDetailScreen extends StatelessWidget {
  final Function(String mealId) favoriteHandler;
  final Function(String mealId) checkMealFavoriteHandler;

  //TODO best practice to save the routes
  static const routeName = '/meal-detail';

  Widget buildSectionTitle(BuildContext context, String title) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 10),
      child: Text(
        title,
        style: Theme.of(context).textTheme.titleMedium,
      ),
    );
  }

  Widget buildContainer(Widget child) {
    return Container(
      decoration: BoxDecoration(
        color: Colors.white,
        border: Border.all(color: Colors.grey),
        borderRadius: BorderRadius.circular(10),
      ),
      margin: const EdgeInsets.all(10),
      padding: const EdgeInsets.all(10),
      height: 150,
      width: 300,
      child: child,
    );
  }

  const MealDetailScreen({
    Key? key,
    required this.favoriteHandler,
    required this.checkMealFavoriteHandler,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)?.settings.arguments as String;
    final selectedMeal =
        Meal.getDummyMeals().firstWhere((meal) => meal.id == mealId);

    return Scaffold(
      appBar: AppBar(
        title: Text(selectedMeal.title),
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Container(
              height: 300,
              width: double.infinity,
              child: Image.network(selectedMeal.imageUrl, fit: BoxFit.cover),
            ),
            buildSectionTitle(
              context,
              'Ingredients',
            ),
            buildContainer(
              ListView.builder(
                  itemCount: selectedMeal.ingredients.length,
                  itemBuilder: (ctx, index) => Card(
                        color: Theme.of(context).colorScheme.secondary,
                        child: Padding(
                            padding: const EdgeInsets.symmetric(
                              vertical: 5,
                              horizontal: 10,
                            ),
                            child: Text(selectedMeal.ingredients[index])),
                      )),
            ),
            buildSectionTitle(
              context,
              'Steps',
            ),
            buildContainer(ListView.builder(
              itemCount: selectedMeal.steps.length,
              itemBuilder: (ctx, index) => Column(
                children: [
                  ListTile(
                    leading: CircleAvatar(
                      child: Text('# ${(index + 1)}'),
                    ),
                    title: Text(selectedMeal.steps[index]),
                  ),
                  const Divider(),
                ],
              ),
            ))
          ],
        ),
      ),
      // TODO: Demonstrate passing back data
      floatingActionButton: Column(
        mainAxisAlignment: MainAxisAlignment.end,
        children: [
          FloatingActionButton(
              heroTag: "floating1", //TODO to avoid the hero related exception
              child: const Icon(
                Icons.delete,
              ),
              onPressed: () {
                //TODO: here to demonstrate how we return back a data
                Navigator.of(context).pop(mealId);
              }),
          const SizedBox(
            height: 10,
          ),
          FloatingActionButton(
              heroTag: "floating2", //TODO to avoid the hero related exception
              child: Icon(
                checkMealFavoriteHandler(mealId)
                    ? Icons.star
                    : Icons.star_border,
              ),
              onPressed: () => favoriteHandler(mealId)),
        ],
      ),
    );
  }
}
