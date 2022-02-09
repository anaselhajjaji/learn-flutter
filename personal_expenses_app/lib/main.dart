import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';

//TODO: best practice to use relative paths instead of the ones automatically generated by the IDE.
import './models/transaction.dart';
import './widgets/new_transaction.dart';
import './widgets/transaction_list.dart';
import './widgets/chart.dart';

void main() {
  //TODO mandatory to do with SystemChrome.setPreferredOrientations(), otherwise it won't work on some devices
  //WidgetsFlutterBinding.ensureInitialized();
  //TODO to force portait on the application in the case where there is no landscape design for the app
  //SystemChrome.setPreferredOrientations(
  //    [DeviceOrientation.portraitUp, DeviceOrientation.portraitDown]);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final ThemeData theme =
        //TODO: this is how we set fonts in application
        /*TODO: we need to use primarySwatch instead of primaryColor 
          because primary swatch will generate the other colors coming from primary color */
        ThemeData(
            fontFamily: 'SourceCodePro',
            primarySwatch: Colors.green,
            // TODO: we can set here a theme for text (Small, Medium, Large)
            textTheme: ThemeData.light().textTheme.copyWith(
                    titleMedium: TextStyle(
                  fontFamily: 'Quintessential',
                  fontSize: 16,
                  fontWeight: FontWeight.bold,
                )),
            //TODO: to set a font specifically to all the AppBars that will appear in the application
            appBarTheme: AppBarTheme(
              titleTextStyle: TextStyle(
                fontFamily: 'Quintessential',
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ));

    return MaterialApp(
      title: 'Personal Expenses App',
      //TODO: to set the general theme of the application
      theme: theme.copyWith(
          /*TODO: this is how we set accent color, the property is deprecated in ThemeData */
          colorScheme: theme.colorScheme.copyWith(secondary: Colors.red)),
      home: MyHomePage(),
    );
  }
}

class MyHomePage extends StatefulWidget {
  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

/*TODO: with = mixin
A mixin refers to the ability to add the capabilities of another class or classes to your own class, 
without inheriting from those classes. The methods of those classes can now be called on your class, 
and the code within those classes will execute. Dart does not have multiple inheritance, 
but the use of mixins allows you to fold in other classes to achieve code reuse while avoiding the issues 
that multiple inheritance would cause.
*/
class _MyHomePageState extends State<MyHomePage> with WidgetsBindingObserver {
  bool _showChart = false;

  //TODO: add the observer to listen for states
  @override
  void initState() {
    WidgetsBinding.instance?.addObserver(this);
    super.initState();
  }

  //TODO method coming from WidgetsBindingObserver to listen to different App lifecycle states
  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    super.didChangeAppLifecycleState(state);
    print('Application current state: $state');
  }

  //TODO: remove state observer
  @override
  void dispose() {
    WidgetsBinding.instance?.removeObserver(this);
    super.dispose();
  }

  //TODO: dummy transactions
  final List<Transaction> _transactions =
      Transaction.generateDummyTransactions();

  List<Transaction> get _recentTransactions {
    //TODO: list.where() will check a condition and keep or not the element
    return _transactions.where((transaction) {
      return transaction.date.isAfter(DateTime.now().subtract(
        Duration(days: 7),
      ));
    }).toList();
  }

  void _addNewTransaction(
      String inputTitle, double inputAmount, DateTime transactionDate) {
    final newTx = Transaction(
        id: DateTime.now().toString(),
        title: inputTitle,
        amount: inputAmount,
        date: transactionDate);

    setState(() {
      _transactions.add(newTx);
    });
  }

  void _deleteTransaction(String id) {
    setState(() {
      //TODO: removeWhere is a good example for search and remove in a list
      _transactions.removeWhere((transaction) => transaction.id == id);
    });
  }

  void _startAddNewTransaction(BuildContext ctx) {
    //TODO: to show bottom sheet
    showModalBottomSheet(
        context: ctx,
        //TODO: we receive context as argument but we won't use it so we can use '_'
        builder: (_) {
          return NewTransaction(onAddNewTransaction: _addNewTransaction);
        });
  }

  Widget _buildAppBar() {
    return Platform.isIOS
        ? CupertinoNavigationBar(
            middle: Text('Personal Expenses App'),
            trailing: Row(
              mainAxisSize: MainAxisSize.min,
              children: [
                //TODO: because there is no IconButton on cupertino widgets
                GestureDetector(
                  child: Icon(
                    CupertinoIcons.add,
                  ),
                  onTap: () => _startAddNewTransaction(context),
                )
              ],
            ),
          )
        : AppBar(
            title: Text(
              'Personal Expenses App',
            ),
            //TODO: to add actions in app bar
            actions: [
              IconButton(
                onPressed: () => _startAddNewTransaction(context),
                icon: const Icon(Icons.add),
              )
            ],
          );
  }

  List<Widget> _buildPortraitView(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionListWidget,
  ) {
    return [
      Container(
        //TODO: MediaQuery can be used to get the device characteristics: size, orientation ...
        //TODO: MediaQuery.of(context).padding.top is the system status bar
        height: (mediaQuery.size.height -
                appBar.preferredSize.height -
                mediaQuery.padding.top) *
            0.3,
        child: Chart(
          recentTransactions: _recentTransactions,
        ),
      ),
      transactionListWidget
    ];
  }

  List<Widget> _buildLandscapeView(
    MediaQueryData mediaQuery,
    AppBar appBar,
    Widget transactionListWidget,
  ) {
    return [
      Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          Text(
            'Show Chart',
            //TODO: this will fix an issue for iOS, not able to use cupertinoApp (instead of materialapp) because it's limited
            style: Theme.of(context).textTheme.titleSmall,
          ),
          /*TODO some widgets are available on Android and iOS, to have a platform look and feel, 
                      we use adaptive constructor but it's not available for all the widgets.*/
          Switch.adaptive(
              activeColor: Theme.of(context).colorScheme.secondary,
              value: _showChart,
              onChanged: (value) {
                setState(() {
                  _showChart = value;
                });
              })
        ],
      ),
      _showChart
          ? Container(
              //TODO: MediaQuery can be used to get the device characteristics: size, orientation ...
              //TODO: MediaQuery.of(context).padding.top is the system status bar
              height: (mediaQuery.size.height -
                      appBar.preferredSize.height -
                      mediaQuery.padding.top) *
                  0.7,
              child: Chart(
                recentTransactions: _recentTransactions,
              ),
            )
          : transactionListWidget
    ];
  }

  @override
  Widget build(BuildContext context) {
    final _mediaQuery = MediaQuery.of(context);
    final _isLandscape = _mediaQuery.orientation == Orientation.landscape;

    //TODO store the appBar in a an object so we can access it later to get the height
    final dynamic _appBar = _buildAppBar();

    final transactionListWidget = Container(
      //TODO: MediaQuery can be used to get the device characteristics: size, orientation ...
      height: (_mediaQuery.size.height -
          _appBar.preferredSize.height -
          _mediaQuery.padding.top),
      child: TransactionList(
        transactions: _transactions,
        onDeleteTransaction: _deleteTransaction,
      ),
    );

    //TODO SafeArea this will fix an issue for iOS, navigation bar that overlaps with chart card
    final _pageBody = SafeArea(
      child: SingleChildScrollView(
        child: Column(
            //TODO: for a column the main axis is top to bottom and cross axis is left to right
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: <Widget>[
              // TODO: row will be rendered only if the orientation is landscape
              if (_isLandscape)
                ..._buildLandscapeView(
                  _mediaQuery,
                  _appBar,
                  transactionListWidget,
                ),
              if (!_isLandscape)
                ..._buildPortraitView(
                  _mediaQuery,
                  _appBar,
                  transactionListWidget,
                ),
            ]),
      ),
    );

    return Platform.isIOS
        ? CupertinoPageScaffold(
            child: _pageBody,
            navigationBar: _appBar,
          )
        : Scaffold(
            appBar: _appBar,
            // This will make the view scrollable
            body: _pageBody,
            //TODO: to add floating action button
            floatingActionButtonLocation:
                FloatingActionButtonLocation.centerFloat,
            // TODO here we check on platform to render or not the floating action button
            floatingActionButton: Platform.isIOS
                ? Container()
                : FloatingActionButton(
                    child: Icon(Icons.add),
                    onPressed: () => _startAddNewTransaction(context),
                  ),
          );
  }
}
