import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/product.dart';
import 'package:shoppingapp/providers/products.dart';
import 'package:shoppingapp/widgets/productgrid.dart';

enum Filteroptions { Favourites, All }

class ProductOverView extends StatelessWidget {
  ProductOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final productContainer = Provider.of<Products>(
      context,
      listen: false,
    );
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping stop'),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (Filteroptions SelectedOptions) {
                  if (SelectedOptions == Filteroptions.Favourites) {
                    productContainer.showFavouriteOnly();
                  } else {
                    productContainer.showAll();
                  }
                },
                icon: Icon(Icons.more_vert_rounded),
                itemBuilder: (_) => [
                      PopupMenuItem(
                        child: Text("Favourites"),
                        value: Filteroptions.Favourites,
                      ),
                      PopupMenuItem(
                        child: Text('Show All'),
                        value: Filteroptions.All,
                      )
                    ])
          ],
        ),
        body: ProductGrid());
  }
}
