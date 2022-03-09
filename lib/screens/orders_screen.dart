import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/orders.dart' show Orders;
import 'package:shoppingapp/widgets/order_item.dart';

class OrderScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    final orderItem = Provider.of<Orders>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Orders'),
      ),
      body: ListView.builder(
          itemCount: orderItem.orders.length,
          itemBuilder: (ctx, index) => OrderItem(orderItem.orders[index])),
    );
  }
}
