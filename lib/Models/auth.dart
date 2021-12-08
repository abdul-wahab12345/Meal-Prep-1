import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Auth with ChangeNotifier {
  String? websiteUrl;
  int? id;
  String? name;

  List<Map<String, String>> errorcodes = [
    {'code': 'invalid_username', 'text': "Username is invalid!"},
    {'code': 'invalid_email', 'text': "Email is invalid!"},
    {'code': 'incorrect_password', 'text': "Password is invalid!"}
  ];

  void setWebUrl(String url) {
    websiteUrl = url;
    notifyListeners();
  }

  Future<void> userLogin(String username, String password) async {
    var url = Uri.parse(
        'https://u1s.ee6.myftpupload.com/wp-json/meal-prep/v1/user-login');
    var body = {'username': username, 'password': password};
    print(body);

    final response = await http.post(url, body: body);
    var user = json.decode(response.body);

    if (user['status'] == "success") {
      id = user['data']['ID'];
      name = user['data']['fullName'];
    } else {
      var message = user['message'];

      var error =
          errorcodes.firstWhere((element) => element['code'] == message);
      var errorMessage = 'Unkown error';
      if (error != null) {
        errorMessage = error['text'] as String;
      }

      throw (errorMessage);
    }

    print(user);
  }
}
