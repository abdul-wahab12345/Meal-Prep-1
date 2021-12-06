import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Meal with ChangeNotifier {
  int id;
  String title;
  String subTitle;
  String imageUrl;
  Map<String, String> calories;
  Map<String, String> carbohydrates;

  Map<String, String> fat;
  Map<String, String> protein;

  List<String> badges;

  String ingredients;

  bool isFav;

  Meal({
    required this.id,
    required this.title,
    required this.subTitle,
    required this.imageUrl,
    required this.calories,
    required this.carbohydrates,
    required this.fat,
    required this.protein,
    required this.isFav,
    required this.badges,
    required this.ingredients,
  });

  void toggleFavorite() {

final url;
      if (!isFav) {
        url = Uri.parse(
            "https://u1s.ee6.myftpupload.com/wp-json/meal-prep/v1/like-meal?user_id=7&meal_id=$id");
        http.get(url);
      } else {
        url = Uri.parse(
            "https://u1s.ee6.myftpupload.com/wp-json/meal-prep/v1/unlike-meal?user_id=7&meal_id=$id");
        http.get(url);
      }
      print(url);

    isFav = !isFav;
    notifyListeners();
  }
}
