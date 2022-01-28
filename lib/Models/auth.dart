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

  Future<void> signUp(String userName, String email, String password) async {
    print(websiteUrl);
    try {
      final url = Uri.parse('${websiteUrl}wp-json/meal-prep/v1/signup');

      final response = await http.post(
        url,
        body: {
          'user_name': userName,
          'email': email,
          'password': password,
        },
      );

      var extractedResponse = json.decode(response.body);
      if (extractedResponse['status'] == 'error') {
        throw extractedResponse['sms'].toString();
      }
    } catch (error) {
      throw error.toString();
    }
    notifyListeners();
  }

  

  Future<void> userLogin(String username, String password) async {
    try {
      var url = Uri.parse('${websiteUrl}wp-json/meal-prep/v1/user-login');
      var body = {'username': username, 'password': password};
      //print(body);

      final response = await http.post(url, body: body);
      var user = json.decode(response.body);
      // print(user);

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
    } catch (error) {
      throw error;
    }
  }

  Future<bool> tryAutoLogin() async {
    try {
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
    } catch (error) {
      throw error;
    }
  }

  Future<void> logout() async {
    id = 0;
    websiteUrl = '';
    name = '';
    final prefs = await SharedPreferences.getInstance();
    prefs.clear();

    notifyListeners();
  }

  Future<Map<String, dynamic>> changePassWord(
      String email, String currentPass, String newPass) async {
    try {
      final url =
          Uri.parse('${websiteUrl}wp-json/meal-prep/v1/change-password');

      final response = await http.post(
        url,
        body: {
          'username': email,
          'password': currentPass,
          'new_password': newPass,
        },
      );
      return json.decode(response.body);
    } catch (error) {
      throw 'Something went wrong';
    }
  }

  Future<void> resetPassword(String email) async {
    try {
      final url =
          Uri.parse('${websiteUrl}wp-json/meal-prep/v1/forget-password');
      final response = await http.post(
        url,
        body: {
          'email': email,
        },
      );
      print(response.body);
      var extractedResponse = json.decode(response.body);
      if (extractedResponse['status'] == 'error') {
        throw extractedResponse['sms'].toString();
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> verifyPassword(String code, String email) async {
    try {
      final url = Uri.parse('${websiteUrl}wp-json/meal-prep/v1/verify-code');
      final response = await http.post(
        url,
        body: {
          'code': code.toString(),
          'email': email.toString(),
        },
      );

      print(response.body);
      var extractedResponse = json.decode(response.body);
      if (extractedResponse['status'] == 'error') {
        throw extractedResponse['sms'].toString();
      }
    } catch (error) {
      throw error.toString();
    }
  }

  Future<void> forgetChangePassword(
      String email, String code, String newPass) async {
    try {
      final url =
          Uri.parse('${websiteUrl}wp-json/meal-prep/v1/forget-change-password');
      final response = await http.post(
        url,
        body: {
          'code': code.toString(),
          'email': email.toString(),
          'new_password': newPass.toString(),
        },
      );

      print(response.body);

      var extractedResponse = json.decode(response.body);
      if (extractedResponse['status'] == 'error') {
        throw extractedResponse['sms'].toString();
      }
    } catch (error) {
      throw error.toString();
    }
  }
}
