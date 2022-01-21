import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Variation {
  int id;
  String title;
  String deliverDate;
  String price;
  Variation({
    required this.id,
    required this.price,
    required this.title,
    required this.deliverDate,
  });
}

class Product {
  int id;
  String title;
  String imageUrl;
  String price;
  String deliveryDate;
  List<Variation> variations;
  Product({
    required this.id,
    required this.title,
    required this.variations,
    required this.imageUrl,
    required this.price,
    required this.deliveryDate,
  });
}

class Products with ChangeNotifier {
  String webUrl;
  Products(@required this.webUrl);
  List<Product> _products = [];

  List<Product> get products {
    return [..._products];
  }

  Product findById(int id) {
    //print(id);
    return _products.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    try{
    final url = Uri.parse(
        '${webUrl}wp-json/meal-prep/v1/products');

    final response = await http.get(url);

    // print(response.body);
    final extractedData = json.decode(response.body) as List<dynamic>;
    //print(extractedData);
    List<Product> extractedProducts = [];
    extractedData.forEach((prod) {
      List<Variation> variations = [];

      var extractedVariations = prod['variations'] as List<dynamic>;

      extractedVariations.forEach((variation) {
        variations.add(
          Variation(
            id: variation['id'],
            title: variation['title'],
            deliverDate: prod['delivery_date'],
            price: variation['price'],
          ),
        );
      });


      extractedProducts.add(
        Product(
          id: prod['id'],
          title: prod['title'],
          variations: variations,
          imageUrl: prod['imageUrl'],
          price: prod['price'],
          deliveryDate: prod['delivery_date'],
        ),
      );
    });

    _products = extractedProducts;
    

    notifyListeners();
    }catch(error){
      throw 'Something Went Wrong';
    }
    
  }
}
