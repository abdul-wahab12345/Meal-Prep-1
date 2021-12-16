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
  List<int> productIds;

  Subscription({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.nextDelivery,
    required this.status,
    required this.isCutOf,
    required this.productIds,
  });
}

class Subscriptions with ChangeNotifier {
  int? userId;
  String webUrl;
  Subscriptions({this.userId = 0, required this.webUrl});
   List<Subscription> _subscriptions = [
    // Subscription(
    //   id: 1,
    //   title: 'Protein + Plan',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
    //   nextDelivery: '26/11/2021',
    //   status: 'Active',
    //   isCutOf: true,
    //   productIds: [3],
    // ),
    // //2
    // Subscription(
    //   id: 2,
    //   title: 'Lean + Plan',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
    //   nextDelivery: '27/11/2021',
    //   status: 'Paused',
    //   isCutOf: true,
    //   productIds: [3],
    // ),
    // //3
    // Subscription(
    //   id: 3,
    //   title: 'Balanced Plan',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
    //   nextDelivery: '26/11/2021',
    //   status: 'Inactive',
    //   isCutOf: true,
    //   productIds: [3],
    // ),
  ];

  List<Subscription> get subscriptions {
    return [..._subscriptions];
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

      List<int> products=[];

     List<dynamic> pIds=sub['products'];
     pIds.forEach((element) { 
       products.add(
         element as int,
       );

     });

      newSubs.add(
        Subscription(
        id: sub['ID'],
        title: sub['title'],
        imageUrl: sub['imageUrl']==null?'':sub['imageUrl'],
        nextDelivery: sub['next_delivery']==null?'':sub['next_delivery'],
        status: sub['status'],
        isCutOf:false,
        productIds: products,
      ));
    });

    _subscriptions=newSubs;
    notifyListeners();
  }
}
