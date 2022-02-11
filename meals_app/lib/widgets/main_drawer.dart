import 'package:flutter/material.dart';

import '../screens/filters_screen.dart';

class MainDrawer extends StatelessWidget {
  const MainDrawer({Key? key}) : super(key: key);

  Widget buildListTile(String title, IconData icon, Function() tapHandler) {
    return ListTile(
      leading: Icon(
        icon,
        size: 26,
      ),
      title: Text(
        title,
        style: const TextStyle(
          fontFamily: 'SupermercadoOne',
          fontSize: 24,
          fontWeight: FontWeight.bold,
        ),
      ),
      onTap: tapHandler,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Drawer(
        child: Column(
      children: [
        Container(
          height: 120,
          width: double.infinity,
          padding: const EdgeInsets.all(20),
          alignment: Alignment.centerLeft,
          color: Theme.of(context).colorScheme.secondary,
          child: Text(
            'Let\'s cook!',
            style: TextStyle(
              fontFamily: 'Rowdies',
              fontSize: 30,
              color: Theme.of(context).primaryColor,
            ),
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        buildListTile('Meals', Icons.restaurant, () {
          //TODO: [as a note] to go back we can use pop and we can even pass arguments back (pop(data)),
          // to get the value we can use the return of the push() which is a Future: push().then((data) {})
          Navigator.of(context).pushReplacementNamed(
              '/'); //TODO replace the current page in the stack to avoid accumulate pages
        }),
        buildListTile('Filters', Icons.settings, () {
          Navigator.of(context).pushReplacementNamed(FiltersScreen
              .routeName); //TODO replace the current page in the stack to avoid accumulate pages
        }),
      ],
    ));
  }
}
