import 'package:flutter/material.dart';

import './categories_screen.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  final ThemeData theme =
      /*TODO: we need to use primarySwatch instead of primaryColor 
          because primary swatch will generate the other colors coming from primary color */
      ThemeData(
    primarySwatch: Colors.red,
    canvasColor: const Color.fromRGBO(255, 254, 229, 1),
    fontFamily: 'Rowdies',
  );

  MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Best Meals App',
      theme: theme.copyWith(
        /*TODO: this is how we set accent color, the property is deprecated in ThemeData */
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.orange,
        ),
        textTheme: ThemeData.light().textTheme.copyWith(
              /*bodyText1: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),
              bodyText2: const TextStyle(
                color: Color.fromRGBO(20, 51, 51, 1),
              ),*/
              titleMedium: const TextStyle(
                fontFamily: 'SupermercadoOne',
                color: Colors.black,
              ),
            ),
      ),
      home: const CategoriesScreen(),
    );
  }
}
