import 'package:flutter/material.dart';


class Auth with ChangeNotifier{

String? websiteUrl;
int? id;

void setWebUrl(String url){
  websiteUrl = url;
  notifyListeners();
}

}