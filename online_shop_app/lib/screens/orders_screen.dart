import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../widgets/app_drawer.dart';
import '../providers/orders.dart' show Orders;
import '../widgets/order_item.dart';

class OrdersScreen extends StatefulWidget {
  static const routeName = '/orders';

  const OrdersScreen({Key? key}) : super(key: key);

  @override
  State<OrdersScreen> createState() => _OrdersScreenState();
}

class _OrdersScreenState extends State<OrdersScreen> {
  var _isLoading = false;
  late Future _ordersFuture;

  Future _getOrdersFuture() {
    return Provider.of<Orders>(context, listen: false).fetchOrders();
  }

  @override
  void initState() {
    //TODO BEST PRACTICE to avoid running the future if for any reason the
    // build method get executed to manage others scenarios
    _ordersFuture = _getOrdersFuture();

    /*Future.delayed(Duration.zero).then((_) async {
      setState(() {
        _isLoading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        _isLoading = false;
      });
    });*/
    // TODO OR using listen false (ONLY) should be possible
    /*_isLoading = true;
    Provider.of<Orders>(context, listen: false).fetchOrders().then((_) {
      setState(() {
        _isLoading = false;
      });
    });*/
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: const Text('My Orders'),
        ),
        drawer: const AppDrawer(),
        // TODO: Future builder will build widgets based on future result so no need for statefull widget
        body: FutureBuilder(
          future: _ordersFuture,
          builder: (ctx, dataSnapshot) {
            if (dataSnapshot.connectionState == ConnectionState.waiting) {
              return const Center(child: CircularProgressIndicator());
            } else {
              if (dataSnapshot.error != null) {
                // Handle error
                return const Center(
                  child: Text('Error occured'),
                );
              } else {
                return Consumer<Orders>(
                  builder: (ctx, ordersData, child) => ListView.builder(
                    itemCount: ordersData.orders.length,
                    itemBuilder: (ctx, i) =>
                        OrderItem(order: ordersData.orders[i]),
                  ),
                );
              }
            }
          },
        ));
  }
}
