import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Card {
  String name;
  String btnText;
  String cardNumber;
  String date;
  bool isDefault;

  Card({
    required this.name,
    required this.btnText,
    required this.cardNumber,
    required this.date,
    required this.isDefault,
  });
}

class Address {
  String ad1;
  String ad2;
  String city;
  String state;
  String postalCode;

  Address({
    required this.ad1,
    required this.ad2,
    required this.city,
    required this.state,
    required this.postalCode,
  });
}

class User {
  String name;
  String imageUrl;
  String email;
  List<Card> paymentMethod;
  Address billingAddress;
  Address shippingAddress;

  User({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.paymentMethod,
    required this.billingAddress,
    required this.shippingAddress,
  });
}

class UserData with ChangeNotifier {
  User? user;
  String webUrl;
  int userId;
  UserData({
    required this.webUrl,
    required this.userId,
  });

  Future<void> getUserData() async {
    var url = Uri.parse('${webUrl}wp-json/meal-prep/v1/user-profile');
    final response = await http.post(url, body: {
      'user_id': userId.toString(),
    });
    // print(response.body);

    var extractedData = json.decode(response.body) as Map<String, dynamic>;
    if (extractedData.isEmpty) {
      return;
    }
    // print(extractedData);
    Address? billAddress;
    Address? shipAddress;
    String userName = extractedData['name'];
    List<Card> cards = [];
    User? currentUser;

    //getting address
    var bill = extractedData['billing'] as Map<String, dynamic>;

    billAddress = Address(
      ad1: bill['address_1'].toString(),
      ad2: bill['address_2'].toString(),
      city: bill['city'].toString(),
      state: bill['state'].toString(),
      postalCode: bill['postcode'].toString(),
    );

    var ship = extractedData['shipping'] as Map<String, dynamic>;

    shipAddress = Address(
      ad1: ship['address_1'].toString(),
      ad2: ship['address_2'].toString(),
      city: ship['city'].toString(),
      state: ship['state'].toString(),
      postalCode: ship['postcode'].toString(),
    );

    //issa uper address get hu raha ha

    //now of to getting payment details
    var pay = extractedData['payment_methods'] as Map<String, dynamic>;

    pay.forEach((key, value) {
      var singleCard = value as List<dynamic>;
      singleCard.forEach((element) {
        cards.add(
          Card(
            name: userName,
            btnText: 'btnText',
            cardNumber: element['method']['last4'].toString(),
            date: element['expires'].toString(),
            isDefault: element['is_default'],
          ),
        );
      });
    });

    currentUser = User(
      name: extractedData['name'],
      imageUrl: extractedData['image'],
      email: extractedData['email'],
      billingAddress: billAddress,
      shippingAddress: shipAddress,
      paymentMethod: cards,
    );

    //print(currentUser.paymentMethod[6].cardNumber);
    // print(user!.name);
    user = currentUser;
    print(user!.paymentMethod[1].name);

    notifyListeners();
  }
}
