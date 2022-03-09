import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/cart.dart' show Cart;
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
                  Chip(label: Text('\$${myCart.totalAmount}')),
                  FlatButton(
                    onPressed: () {},
                    child: Text(
                      'Order Now',
                      style: TextStyle(color: Theme.of(context).primaryColor),
                    ),
                  )
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
