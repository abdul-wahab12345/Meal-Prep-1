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
  List<Product> _products = [
    Product(
      id: 1,
      title: 'Balanced',
      price: 'Starting \$36/week',
      deliveryDate: '26/8/2022',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      variations: [
        Variation(
          id: 11,
          title: 'One Week Only',
          deliverDate: '17/9/2021',
          price: 'Starting \$76.25',
        ),
        Variation(
          id: 12,
          title: 'Five Meals',
          deliverDate: '16/12/2021',
          price: 'Starting \$86.25',
        ),
        Variation(
          id: 13,
          title: '10 Meals',
          deliverDate: '26/12/2021',
          price: 'Starting \$123.25',
        ),
      ],
    ),
    //2

    Product(
      id: 2,
      title: 'Lean',
      price: 'Starting \$12/week',
      deliveryDate: '16/8/2022',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      variations: [
        Variation(
          id: 21,
          title: 'One Week Only',
          deliverDate: '04/12/2021',
          price: 'Starting \$96.25',
        ),
        Variation(
          id: 22,
          title: 'Five Meals',
          deliverDate: '06/12/2021',
          price: 'Starting \$62.25',
        ),
        Variation(
          id: 23,
          title: '10 Meals',
          deliverDate: '2/12/2021',
          price: 'Starting \$786.25',
        ),
      ],
    ),

    //3
    Product(
      id: 3,
      title: 'Protien + Plan',
      price: 'Starting \$26/week',
      deliveryDate: '06/8/2022',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      variations: [
        Variation(
          id: 31,
          title: 'One Week Only',
          deliverDate: '4/11/2021',
          price: 'Starting \$55.25',
        ),
        Variation(
          id: 32,
          title: 'Five Meals',
          deliverDate: '9/12/2021',
          price: 'Starting \$88.25',
        ),
        Variation(
          id: 33,
          title: '10 Meals',
          deliverDate: '26/12/2021',
          price: 'Starting \$6.25',
        ),
      ],
    ),
  ];

  List<Product> get products {
    return [..._products];
  }

  Product findById(int id) {
    //print(id);
    return _products.firstWhere((element) => element.id == id);
  }

  Future<void> fetchAndSetProducts() async {
    final url = Uri.parse(
        'https://u1s.ee6.myftpupload.com/wp-json/meal-prep/v1/products?doing_wp_cron=1639480626.7294850349426269531250');

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
  }
}
