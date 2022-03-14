import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingapp/providers/cart.dart' show Cart;
import 'package:shoppingapp/providers/orders.dart';
import 'package:shoppingapp/widgets/cart_item.dart';

class CartScreen extends StatelessWidget {
  static const String routeName = '/cart';

  @override
  Widget build(BuildContext context) {
    final myCart = Provider.of<Cart>(context);
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Cart'),
      ),
      body: Column(
        children: <Widget>[
          Card(
            margin: EdgeInsets.all(10),
            child: Padding(
              padding: EdgeInsets.all(10),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: <Widget>[
                  Text(
                    'Total:',
                    style:
                        TextStyle(fontSize: 20, fontFamily: 'SansitaSwashed'),
                  ),
                  Spacer(),
                  Chip(
                      label:
                          Text('\$${myCart.totalAmount.toStringAsFixed(2)}')),
                  OrderButton(myCart: myCart)
                ],
              ),
            ),
          ),
          SizedBox(
            height: 10,
          ),
          Expanded(
              child: ListView.builder(
                  itemCount: myCart.items.length,
                  itemBuilder: (context, index) => CartItem(
                      myCart.items.values.toList()[index].id,
                      myCart.items.keys.toList()[index],
                      myCart.items.values.toList()[index].price,
                      myCart.items.values.toList()[index].quantity,
                      myCart.items.values.toList()[index].title)))
        ],
      ),
    );
  }
}

class OrderButton extends StatefulWidget {
  const OrderButton({
    Key? key,
    required this.myCart,
  }) : super(key: key);

  final Cart myCart;

  @override
  State<OrderButton> createState() => _OrderButtonState();
}

class _OrderButtonState extends State<OrderButton> {
  var isLoading = false;
  @override
  Widget build(BuildContext context) {
    return FlatButton(
      onPressed: widget.myCart.totalAmount <= 0 || isLoading
          ? null
          : () async {
              setState(() {
                isLoading = true;
              });
              await Provider.of<Orders>(context, listen: false).addOrders(
                  widget.myCart.items.values.toList(),
                  widget.myCart.totalAmount);
              setState(() {
                isLoading = false;
              });
              widget.myCart.clear();
            },
      child: isLoading
          ? CircularProgressIndicator()
          : Text(
              'ORDER NOW',
              style: TextStyle(color: Theme.of(context).primaryColor),
            ),
    );
  }
}
