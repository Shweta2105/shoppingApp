import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/cart.dart';
import 'package:shoppingapp/providers/orders.dart';
import 'package:shoppingapp/providers/products.dart';
import 'package:shoppingapp/screens/auth_screen.dart';
import 'package:shoppingapp/screens/edit_product_screen.dart';
import 'package:shoppingapp/screens/orders_screen.dart';
import 'package:shoppingapp/screens/product_details.dart';
import 'package:shoppingapp/screens/product_overview.dart';
import 'package:shoppingapp/screens/cartscreen.dart';
import 'package:shoppingapp/screens/user_product_screen.dart';

import 'providers/auth.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
        providers: [
          ChangeNotifierProvider.value(
            value: Auth(),
          ),
          ChangeNotifierProxyProvider<Auth, Products>(
            create: (_) => Products('', []),
            update: (ctx, auth, previousProducts) {
              print('-**************at main************');
              print(auth.token);
              print('*****************************');
              return Products(auth.token ?? "",
                  previousProducts == null ? [] : previousProducts.items);
            },
          ),
          ChangeNotifierProvider.value(
            value: Cart(),
          ),
          ChangeNotifierProxyProvider<Auth, Orders>(
            create: (_) => Orders('', []),
            update: (ctx, auth, previousOrders) {
              print('-**************at main************');
              print(auth.token);
              print('*****************************');
              return Orders(auth.token ?? "",
                  previousOrders == null ? [] : previousOrders.orders);
            },
          ),
        ],
        child: Consumer<Auth>(
          builder: (ctx, auth, _) => MaterialApp(
            title: 'Shopping App',
            debugShowCheckedModeBanner: false,
            theme: ThemeData(
                primarySwatch: Colors.indigo,
                accentColor: Colors.orangeAccent,
                fontFamily: 'SansitaSwashed'),
            home: // AuthScreen(),
                auth.isAuth ? ProductOverView() : AuthScreen(),
            routes: {
              ProductDetails.routeName: (ctx) => ProductDetails(),
              CartScreen.routeName: (ctx) => CartScreen(),
              OrderScreen.routeName: (ctx) => OrderScreen(),
              UserProductScreen.routeName: (ctx) => UserProductScreen(),
              EditProductScreen.routeName: (ctx) => EditProductScreen(),
            },
          ),
        ));
  }
}
