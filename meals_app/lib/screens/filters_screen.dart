import 'package:flutter/material.dart';

import '../widgets/main_drawer.dart';

class FiltersScreen extends StatefulWidget {
  final Map<String, bool> filters;

  //TODO best practice to save the routes
  static const routeName = '/filters';

  final Function(Map<String, bool> filters) setFiltersHandler;

  const FiltersScreen(
      {Key? key, required this.setFiltersHandler, required this.filters})
      : super(key: key);

  @override
  State<FiltersScreen> createState() => _FiltersScreenState();
}

class _FiltersScreenState extends State<FiltersScreen> {
  var _glutenFree = false;
  var _vegetarien = false;
  var _vegan = false;
  var _lactoseFree = false;

  @override
  initState() {
    _glutenFree = widget.filters['gluten']!;
    _vegetarien = widget.filters['vegetarian']!;
    _vegan = widget.filters['vegan']!;
    _lactoseFree = widget.filters['lactose']!;
    super.initState();
  }

  Widget _buildSwitchListTile(
    String title,
    String subtitle,
    bool currentValue,
    Function(bool) updateValue,
  ) {
    return SwitchListTile(
      title: Text(title),
      value: currentValue,
      subtitle: Text(subtitle),
      onChanged: updateValue,
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Filters'),
        actions: [
          IconButton(
            onPressed: () {
              final selectedFilters = {
                'gluten': _glutenFree,
                'lactose': _lactoseFree,
                'vegan': _vegan,
                'vegetarian': _vegetarien,
              };
              widget.setFiltersHandler(selectedFilters);
            },
            icon: const Icon(Icons.save),
          ),
        ],
      ),
      drawer: const MainDrawer(),
      body: Column(children: [
        Container(
          padding: const EdgeInsets.all(20),
          child: Text('Adjust your meal selection.',
              style: Theme.of(context).textTheme.titleLarge),
        ),
        //TODO Expanded take all the remaining space
        Expanded(
            child: ListView(
          // TODO good switch that can be used in a list view
          children: [
            _buildSwitchListTile(
                'Gluten-free', 'Only include gluten-free meals.', _glutenFree,
                (newValue) {
              setState(() {
                _glutenFree = newValue;
              });
            }),
            _buildSwitchListTile('Lactose-free',
                'Only include lactose-free meals.', _lactoseFree, (newValue) {
              setState(() {
                _lactoseFree = newValue;
              });
            }),
            _buildSwitchListTile(
                'Vegetarian', 'Only include vegetarian meals.', _vegetarien,
                (newValue) {
              setState(() {
                _vegetarien = newValue;
              });
            }),
            _buildSwitchListTile('Vegan', 'Only include vegan meals.', _vegan,
                (newValue) {
              setState(() {
                _vegan = newValue;
              });
            }),
          ],
        ))
      ]),
    );
  }
}
