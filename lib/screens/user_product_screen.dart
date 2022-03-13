import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingapp/providers/products.dart';
import 'package:shoppingapp/screens/edit_product_screen.dart';
import 'package:shoppingapp/widgets/app_drawer.dart';
import 'package:shoppingapp/widgets/user_product_item.dart';

class UserProductScreen extends StatelessWidget {
  static const routeName = '/userProductScreen';

  Future<void> _refreshProducts(BuildContext context) async {
    final productData =
        await Provider.of<Products>(context, listen: false).fetchProducts();
  }

  @override
  Widget build(BuildContext context) {
    final productData = Provider.of<Products>(
      context,
    );
    return Scaffold(
      appBar: AppBar(
        title: Text('Your Product'),
        actions: [
          IconButton(
            icon: Icon(
              Icons.add,
            ),
            onPressed: () {
              Navigator.of(context).pushNamed(EditProductScreen.routeName);
            },
          )
        ],
      ),
      drawer: AppDrawer(),
      body: RefreshIndicator(
        onRefresh: () => _refreshProducts(context),
        child: Padding(
          padding: EdgeInsets.all(10),
          child: ListView.builder(
              itemCount: productData.items.length,
              itemBuilder: (_, i) => Column(
                    children: [
                      UserProductItem(
                          productData.items[i].id,
                          productData.items[i].title,
                          productData.items[i].imageUrl),
                      Divider(),
                    ],
                  )),
        ),
      ),
    );
  }
}
