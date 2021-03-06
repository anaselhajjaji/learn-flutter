import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:provider/provider.dart';

import './screens/edit_product_screen.dart';
import './screens/orders_screen.dart';
import './providers/orders.dart';
import './screens/cart_screen.dart';
import './providers/cart.dart';
import './providers/products.dart';
import './screens/product_detail_screen.dart';
import './screens/products_overview_screen.dart';
import './screens/user_product_screen.dart';

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

    //TODO return ChangeNotifierProvider that wraps traditional MaterialApp(), the provider should
    // be registered at highest point possible but it doesnt mean that all the app will be rebuilt,
    // only the widgets that are listening will be rebuilt
    // return ChangeNotifierProvider.value(
    // value: Products(),
    // OR
    // Recommended (best practice) this way (more efficient - we don't have reuse here vs the list items):
    //TODO use MutliProvider to set multiple providers
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Products(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Cart(),
        ),
        ChangeNotifierProvider(
          create: (ctx) => Orders(),
        ),
      ],
      child: MaterialApp(
        title: 'Flutter Demo',
        theme: theme.copyWith(
          /*TODO: this is how we set accent color, the property is deprecated in ThemeData */
          colorScheme: theme.colorScheme.copyWith(
            secondary: Colors.deepOrange,
          ),
        ),
        home: ProductsOverviewScreen(),
        routes: {
          ProductDetailsScreen.routeName: (ctx) => const ProductDetailsScreen(),
          CartScreen.routeName: (ctx) => const CartScreen(),
          OrdersScreen.routeName: (ctx) => const OrdersScreen(),
          UserProductsScreen.routeName: (ctx) => const UserProductsScreen(),
          EditProductScreen.routeName: (ctx) => const EditProductScreen(),
        },
      ),
    );
  }
}
