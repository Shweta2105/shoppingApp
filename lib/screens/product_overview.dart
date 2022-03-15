import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import 'package:shoppingapp/providers/cart.dart';
import 'package:shoppingapp/providers/products.dart';
import 'package:shoppingapp/screens/cartscreen.dart';
import 'package:shoppingapp/widgets/app_drawer.dart';
import 'package:shoppingapp/widgets/badge.dart';
import 'package:shoppingapp/widgets/productgrid.dart';

enum Filteroptions { Favourites, All }

class ProductOverView extends StatefulWidget {
  ProductOverView({Key? key}) : super(key: key);

  @override
  State<ProductOverView> createState() => _ProductOverViewState();
}

class _ProductOverViewState extends State<ProductOverView> {
  bool _showFavourites = false;
  var _isInit = true;
  var isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();
    print('---------------in initState');
  }

  @override
  void didChangeDependencies() {
    print('---------------in didChangeDependencies');
    if (_isInit) {
      setState(() {
        isLoading = true;
      });
      Provider.of<Products>(context).fetchProducts().then((_) {
        setState(() {
          isLoading = false;
        });
      });
    }
    _isInit = false;
    super.didChangeDependencies();
  }

  @override
  Widget build(BuildContext context) {
    print('---------------in build');
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping stop'),
          actions: <Widget>[
            PopupMenuButton(
                onSelected: (Filteroptions SelectedOptions) {
                  setState(() {
                    if (SelectedOptions == Filteroptions.Favourites) {
                      _showFavourites = true;
                    } else {
                      _showFavourites = false;
                    }
                  });
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
                    ]),
            Consumer<Cart>(
              builder: (_, cart, ch) => Badge(
                child: ch!,
                value: cart.itemCount.toString(),
                color: Theme.of(context).accentColor,
              ),
              child: IconButton(
                icon: Icon(
                  Icons.shopping_cart,
                ),
                onPressed: () {
                  Navigator.of(context).pushNamed(CartScreen.routeName);
                },
              ),
            ),
          ],
        ),
        drawer: AppDrawer(),
        body: isLoading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : ProductGrid(
                showFavourtes: _showFavourites,
              ));
  }
}
