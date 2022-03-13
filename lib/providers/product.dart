import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;

class Product with ChangeNotifier {
  final String id;
  final String title;
  final String description;
  final double price;
  final String imageUrl;
  bool isFavourite;

  Product({
    required this.id,
    required this.title,
    required this.description,
    required this.price,
    required this.imageUrl,
    this.isFavourite = false,
  });

  void toggleIsFavourite() async {
    final oldStatus = isFavourite;
    isFavourite = !isFavourite;
    notifyListeners();
    final url =
        'https://shopping-app-01-default-rtdb.asia-southeast1.firebasedatabase.app/shoppingproducts/$id.json';
    try {
      final response = await http.patch(
        Uri.parse(url),
        body: json.encode({
          'isFavourite': isFavourite,
        }),
      );
      if (response.statusCode >= 400) {
        _setFavValue(oldStatus);
      }
    } catch (error) {
      _setFavValue(oldStatus);
    }
  }

  void _setFavValue(bool oldStatus) {
    isFavourite = oldStatus;
    notifyListeners();
  }
}
