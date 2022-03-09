import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/products.dart';
import 'package:shoppingapp/screens/product_details.dart';
import 'package:shoppingapp/screens/product_overview.dart';

void main() {
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return ChangeNotifierProvider(
      create: (context) => Products(),
      child: MaterialApp(
        title: 'Shopping App',
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
            primarySwatch: Colors.indigo,
            accentColor: Colors.orangeAccent,
            fontFamily: 'SansitaSwashed'),
        home: ProductOverView(),
        routes: {
          ProductDetails.routeName: (context) => ProductDetails(),
        },
      ),
    );
  }
}
