import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Card {
  int id;
  String name;
  String btnText;
  String cardNumber;
  String date;
  bool isDefault;

  Card({
    required this.id,
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
  String? userImage;
  int userId;
  String delivery_note = '';
  String allergies = '';
  String dislikes = '';
  String next_delivery = '';
  UserData({
    required this.webUrl,
    required this.userId,
  });

  void setNote(String note) {
    this.delivery_note = note;
    notifyListeners();
  }

  Future<void> getUserData() async {
    try {
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

      delivery_note = extractedData['delivery_note'];
      allergies = extractedData['allergies'];
      dislikes = extractedData['dislikes'];
      next_delivery = extractedData['next_delivery'];

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

      var payment = extractedData['payment_methods'];

      if (payment.isNotEmpty) {
        var pay = extractedData['payment_methods'] as Map<String, dynamic>;

        pay.forEach((key, value) {
          var singleCard = value as List<dynamic>;
          singleCard.forEach((element) {
            int payment_id = 0;
            if (!element['is_default']) {
              String actionUrl = element['actions']['default']['url'];
              actionUrl =
                  actionUrl.replaceAll('/set-default-payment-method/', "");
              var ids = actionUrl.split('/?_wpnonce');
              payment_id = int.parse(ids.first);
              print(payment_id);
            }
            cards.add(
              Card(
                id: payment_id,
                name: userName,
                btnText: 'btnText',
                cardNumber: element['method']['last4'].toString(),
                date: element['expires'].toString(),
                isDefault: element['is_default'],
              ),
            );
          });
        });
      }
      this.userImage = extractedData['image'];
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
      //print(user!.paymentMethod[1].name);

      notifyListeners();
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> addAllergies(String allergies, String dislikes) async {
    var url = Uri.parse('${webUrl}wp-json/meal-prep/v1/add-allergies');
    final response = await http.post(url, body: {
      'user_id': userId.toString(),
      'allergy': allergies,
      'dislikes': dislikes
    });
    this.allergies = allergies;
    this.dislikes = dislikes;
    notifyListeners();
  }

  Future<void> setDefaultPayment(int id) async {
    var url =
        Uri.parse('${webUrl}wp-json/meal-prep/v1/make-default-payment-method');
    final response = await http.post(url, body: {'id': id.toString()});
  }

  Future<void> changeProfileImage(String base64Image) async {
    var url = Uri.parse('${webUrl}wp-json/meal-prep/v1/change-profile-image');
    final response = await http
        .post(url, body: {'user_id': userId.toString(), 'image': base64Image});
    print(response.body);
    if (response.body != "error") {
      this.userImage = json.decode(response.body);
      notifyListeners();
    }
  }

  void emptyUser() {
    this.user = null;
    notifyListeners();
  }
}
