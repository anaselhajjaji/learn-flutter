import 'package:flutter/material.dart';

class FiltersScreen extends StatelessWidget {
  //TODO best practice to save the routes
  static const routeName = '/filters';

  const FiltersScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
      ),
      body: Center(
        child: Text('Filters'),
      ),
    );
  }
}
