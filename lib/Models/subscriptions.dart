import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:mealprep/constant.dart';

class Subscription {
  int id;
  String title;
  String imageUrl;
  String nextDelivery;
  String status;
  bool isCutOf;
  bool isCharged;
  String endDate;
  List<int> productIds;

  Subscription({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.nextDelivery,
    required this.status,
    required this.endDate,
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

  void emptySubscriptions() {
    _subscriptions = [];
    notifyListeners();
  }

  Future<void> fetchAndSetSubs() async {
    try {
      final url = Uri.parse('${webUrl}wp-json/meal-prep/v1/user-subscriptions');

      final response = await http.post(url, body: {
        'user_id': userId.toString(),
      });
      final extractedData = json.decode(response.body) as List<dynamic>;
      List<Subscription> newSubs = [];
      extractedData.forEach((sub) {
        print(sub['end_date']);
        newSubs.add(Subscription(
          id: sub['ID'],
          title: sub['title'],
          imageUrl: sub['imageUrl'] ?? '',
          nextDelivery: sub['next_delivery'] ?? '',
          status: sub['status'],
          endDate: sub['end_date'].toString(),
          isCutOf: sub['payment_status']['show_options'] as bool,
          isCharged: sub['payment_status']['charged'] as bool,
          productIds: (sub['products'] as List<dynamic>).map((e) {
            return e as int;
          }).toList() as List<int>,
        ));
      });

      _subscriptions = newSubs;
      notifyListeners();
    } catch (e) {
      throw e;
    }
  }

  Future<String> pauseSubscription(Map<String, dynamic> data) async {
    try {
      if (data['type'] == "indf") {
        final url =
            Uri.parse('${webUrl}wp-json/meal-prep/v1/pause-subscription');

        final response = await http.post(url, body: data);
        final extractedData = json.decode(response.body);
        print(extractedData);
        return extractedData;
      } else {
        final url =
            Uri.parse('${webUrl}wp-json/meal-prep/v1/pause-subscription');

        final response = await http.post(url, body: data);
        final extractedData = json.decode(response.body);
        return extractedData;
      }
    } catch (error) {
      throw 'Something Went Wrong';
    }
  }

  Future<String> reactvateSubscription(int id, Type type) async {
    try {
      final url;
      if (type == Type.UnPause) {
        url = Uri.parse('${webUrl}wp-json/meal-prep/v1/un-pause-subscription');
      } else {
        url =
            Uri.parse('${webUrl}wp-json/meal-prep/v1/reactivate-subscription');
      }

      final response = await http.post(url, body: {
        'id': id.toString(),
        'user_id': userId.toString(),
      });
      print(response.body);
      final extractedData = json.decode(response.body);
      print(extractedData);
      return extractedData;
    } catch (error) {
      throw error;
    }
  }

  Future<void> addNote(Map<String, dynamic> data) async {
    try {
      if (data['note_type'] == 'subscription') {
        //print('my name is khan');
        final url = Uri.parse('${webUrl}wp-json/meal-prep/v1/add-note');

        final response = await http.post(url, body: data);
        final extractedData = json.decode(response.body);
        //print(extractedData);
        return extractedData;
      } else {
        print('my name is sufyan');
        final url =
            Uri.parse('${webUrl}wp-json/meal-prep/v1/add-delivery-note');
        print(data);
        
        final response = await http.post(url, body: data);
        final extractedData = json.decode(response.body);
        // print('yeh delivery ka ha $extractedData');
        return extractedData;
      }
    } catch (error) {
      throw 'Something Went Wrong';
    }
  }
}
