import 'package:flutter/material.dart';
import 'package:shoppingapp/providers/product.dart';
import 'package:shoppingapp/widgets/productgrid.dart';

class ProductOverView extends StatelessWidget {
  ProductOverView({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: AppBar(
          title: Text('Shopping stop'),
        ),
        body: ProductGrid());
  }
}
