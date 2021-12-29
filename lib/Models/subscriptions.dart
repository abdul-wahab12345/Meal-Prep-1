import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Subscription {
  int id;
  String title;
  String imageUrl;
  String nextDelivery;
  String status;
  bool isCutOf;
  bool isCharged;
  List<int> productIds;

  Subscription({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.nextDelivery,
    required this.status,
    required this.isCutOf,
    required this.isCharged,
    required this.productIds,
  });
}

class Subscriptions with ChangeNotifier {
  int? userId;
  String webUrl;
  Subscriptions({this.userId = 0, required this.webUrl});
  List<Subscription> _subscriptions = [];

  List<Subscription> get subscriptions {
    return [..._subscriptions];
  }

  Subscription? getSubscriptionById(int id) {
    if (_subscriptions.length <= 0) {
      return null;
    }
    var index = _subscriptions.indexWhere((element) => element.id == id);
    if (index < 0) {
      return null;
    }
    var subscription = _subscriptions.firstWhere((element) => element.id == id);
    return subscription;
  }

  Future<void> fetchAndSetSubs() async {
    print(userId);
    final url = Uri.parse('${webUrl}wp-json/meal-prep/v1/user-subscriptions');

    final response = await http.post(url, body: {
      'user_id': userId.toString(),
    });

    print(response.body);
    final extractedData = json.decode(response.body) as List<dynamic>;
    List<Subscription> newSubs = [];
    extractedData.forEach((sub) {
      newSubs.add(Subscription(
        id: sub['ID'],
        title: sub['title'],
        imageUrl: sub['imageUrl'] == null ? '' : sub['imageUrl'],
        nextDelivery: sub['next_delivery'] == null ? '' : sub['next_delivery'],
        status: sub['status'],
        isCutOf: sub['payment_status']['show_options'] as bool,
        isCharged: sub['payment_status']['charged'] as bool,
        productIds: (sub['products'] as List<dynamic>).map((e) {
          return e as int;
        }).toList() as List<int>,
      ));
    });

    _subscriptions = newSubs;
    notifyListeners();
  }
}
