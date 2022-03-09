import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:shoppingapp/providers/products.dart';

class ProductDetails extends StatelessWidget {
  // final String title;
  // ProductDetails({required this.title});
  static const String routeName = '/product_details';

  @override
  Widget build(BuildContext context) {
    final productId = ModalRoute.of(context)!.settings.arguments as String;
    final loadedProduct =
        Provider.of<Products>(context, listen: false).findById(productId);

    return Scaffold(
      backgroundColor: Color.fromARGB(255, 196, 202, 223),
      appBar: AppBar(
        title: Text(
          loadedProduct.title,
        ),
      ),
      body: SingleChildScrollView(
        padding: EdgeInsets.only(top: 20, right: 10, left: 10),
        child: Center(
          child: Column(
            children: [
              ClipRRect(
                borderRadius: BorderRadius.circular(30),
                child: Container(
                  height: 400,
                  width: double.infinity,
                  child: Image.network(
                    loadedProduct.imageUrl,
                    //fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text('\$${loadedProduct.price}',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                        fontFamily: 'SansitaSwashed',
                        fontSize: 25,
                        fontWeight: FontWeight.w500)),
              ),
              SizedBox(
                height: 20,
              ),
              Container(
                padding: EdgeInsets.symmetric(horizontal: 10),
                width: double.infinity,
                child: Text(loadedProduct.description,
                    textAlign: TextAlign.center,
                    softWrap: true,
                    style: TextStyle(
                        fontFamily: 'SansitaSwashed',
                        fontSize: 25,
                        fontWeight: FontWeight.w100)),
              )
            ],
          ),
        ),
      ),
    );
  }
}
