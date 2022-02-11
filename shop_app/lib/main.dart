import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import './screens/products_overview_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme =
        //TODO: we need to use primarySwatch instead of primaryColor
        // because primary swatch will generate the other colors coming from primary color
        ThemeData(
            primarySwatch: Colors.purple,
            fontFamily: GoogleFonts.rowdies().fontFamily);

    return MaterialApp(
      title: 'Flutter Demo',
      theme: theme.copyWith(
        /*TODO: this is how we set accent color, the property is deprecated in ThemeData */
        colorScheme: theme.colorScheme.copyWith(
          secondary: Colors.deepOrange,
        ),
      ),
      home: ProductsOverviewScreen(),
    );
  }
}
