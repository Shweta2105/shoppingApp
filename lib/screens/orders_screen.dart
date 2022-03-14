import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingapp/providers/orders.dart' show Orders;
import 'package:shoppingapp/widgets/app_drawer.dart';
import 'package:shoppingapp/widgets/order_item.dart';
import 'package:shoppingapp/providers/orders.dart' as order;

class OrderScreen extends StatefulWidget {
  static const routeName = '/orders';

  @override
  State<OrderScreen> createState() => _OrderScreenState();
}

class _OrderScreenState extends State<OrderScreen> {
  var isloading = false;
  @override
  void initState() {
    Future.delayed(Duration.zero).then((_) async {
      setState(() {
        isloading = true;
      });
      await Provider.of<Orders>(context, listen: false).fetchOrders();
      setState(() {
        isloading = false;
      });
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final orderItem = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      drawer: AppDrawer(),
      body: isloading
          ? Center(
              child: CircularProgressIndicator(),
            )
          : ListView.builder(
              itemCount: orderItem.orders.length,
              itemBuilder: (ctx, index) => OrderItem(orderItem.orders[index])),
    );
  }
}
