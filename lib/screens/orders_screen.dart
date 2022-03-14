import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingapp/providers/orders.dart' show Orders;
import 'package:shoppingapp/widgets/app_drawer.dart';
import 'package:shoppingapp/widgets/order_item.dart';
import 'package:shoppingapp/providers/orders.dart' as order;

class OrderScreen extends StatelessWidget {
  static const routeName = '/orders';

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Your Orders'),
        ),
        drawer: AppDrawer(),
        body: FutureBuilder(
          future: Provider.of<Orders>(context, listen: false).fetchOrders(),
          builder: (c, dataSnapShot) {
            if (dataSnapShot.connectionState == ConnectionState.waiting) {
              return Center(
                child: CircularProgressIndicator(),
              );
            } else if (dataSnapShot.error != null) {}
            return Consumer<Orders>(
                builder: (ctx, orderItem, child) => ListView.builder(
                      itemCount: orderItem.orders.length,
                      itemBuilder: (ctx, index) =>
                          OrderItem(orderItem.orders[index]),
                    ));
          },
        ));
  }
}
