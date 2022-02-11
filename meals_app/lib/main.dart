import 'package:flutter/material.dart';

import './models/meal.dart';
import './screens/filters_screen.dart';
import './screens/bottom_tabs_screen.dart';
import './screens/top_tabs_screen.dart';
import './screens/meal_detail_screen.dart';
import './screens/category_meals_screen.dart';
import './screens/categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatefulWidget {
  MyApp({Key? key}) : super(key: key);

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  //TODO a method for managing the state of the app
  Map<String, bool> _filters = {
    'gluten': false,
    'lactose': false,
    'vegan': false,
    'vegetarian': false,
  };

  List<Meal> _availableMeals = Meal.getDummyMeals();
  final List<Meal> _favoriteMeals = [];

  void _setFilters(Map<String, bool> filters) {
    setState(() {
      _filters = filters;

      _availableMeals = Meal.getDummyMeals().where((meal) {
        if (_filters['gluten']! && !meal.isGlutenFree) {
          return false;
        }

        if (_filters['lactose']! && !meal.isLactoseFree) {
          return false;
        }

        if (_filters['vegetarian']! && !meal.isVegetarian) {
          return false;
        }

        if (_filters['vegan']! && !meal.isVegan) {
          return false;
        }
        return true;
      }).toList();
    });
  }

  void _toggleFavorite(String mealId) {
    final existingIndex =
        _favoriteMeals.indexWhere((meal) => meal.id == mealId);

    if (existingIndex >= 0) {
      setState(() {
        _favoriteMeals.removeAt(existingIndex);
      });
    } else {
      setState(() {
        _favoriteMeals
            .add(Meal.getDummyMeals().firstWhere((meal) => meal.id == mealId));
      });
    }
  }

  bool _isMealFavorite(String mealId) {
    return _favoriteMeals.any((meal) => meal.id == mealId);
  }

  final ThemeData theme =
      /*TODO: we need to use primarySwatch instead of primaryColor 
          because primary swatch will generate the other colors coming from primary color */
      ThemeData(
    primarySwatch: Colors.red,
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
    fontFamily: 'Rowdies',
  );

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Meals App',
      theme: theme.copyWith(
        /*TODO: this is how we set accent color, the property is deprecated in ThemeData */
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.yellow,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
            titleMedium: const TextStyle(
              fontFamily: 'SupermercadoOne',
              color: Colors.black,
            ),
            titleLarge: const TextStyle(
              fontFamily: 'SupermercadoOne',
              color: Colors.black,
            )),
      ),
      /* TODO: when adding '/', we don't need to specify home: anymore
      home:
          const CategoriesScreen(),*/
      //TODO: Navigation can be done using Named Routes as below, for complex apps it will be easier to manage this way
      initialRoute:
          '/', //TODO if we want to change the initial route url, default is: '/'
      routes: {
        '/': (ctx) => BottomTabsScreen(
              favoriteMeals: _favoriteMeals,
            ), //TODO or: const TopTabsScreen(),
        CategoryMealsScreen.routeName: (ctx) => CategoryMealsScreen(
              availableMeals: _availableMeals,
            ),
        MealDetailScreen.routeName: (ctx) => MealDetailScreen(
              favoriteHandler: _toggleFavorite,
              checkMealFavoriteHandler: _isMealFavorite,
            ),
        FiltersScreen.routeName: (ctx) => FiltersScreen(
              setFiltersHandler: _setFilters,
              filters: _filters,
            ),
      },
      //TODO will be called when we try to go to a named route which is not registered
      onGenerateRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const CategoriesScreen(),
        );
      },
      //TODO will be called when flutter is unable to build the screen
      onUnknownRoute: (settings) {
        return MaterialPageRoute(
          builder: (ctx) => const CategoriesScreen(),
        );
      },
    );
  }
}
