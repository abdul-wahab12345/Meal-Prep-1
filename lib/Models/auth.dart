import 'dart:convert';
import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Auth with ChangeNotifier {
  String? websiteUrl;
  int? id;
  String? name;
  String? aw_hash;

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
    var url = Uri.parse('${websiteUrl}wp-json/meal-prep/v1/user-login');
    var body = {'username': username, 'password': password};
    print(body);

    final response = await http.post(url, body: body);
    var user = json.decode(response.body);
    print(user);

    if (user['status'] == "success") {
      id = user['data']['ID'];
      name = user['data']['fullName'];
      aw_hash = user['data']['hash'];

      final prefs = await SharedPreferences.getInstance();
      final userData = json.encode({
        'websiteUrl': websiteUrl,
        'userId': id,
        'userName': name,
        'hash': aw_hash,
      });
      prefs.setString('userData', userData);
      notifyListeners();
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

  Future<bool> tryAutoLogin() async {
    final prefs = await SharedPreferences.getInstance();
    if (!prefs.containsKey('userData')) {
      return false;
    }
    final extractedUserData =
        json.decode(prefs.getString('userData')!) as Map<String, dynamic>;

    websiteUrl = extractedUserData['websiteUrl'] as String;
    id = extractedUserData['userId'];
    name = extractedUserData['name'];
    aw_hash = extractedUserData['hash'];
    print(aw_hash);
    notifyListeners();

    return true;
  }

  Future<void> logout() async {
    id = 0;
    websiteUrl = '';
    name = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    notifyListeners();
  }
}
