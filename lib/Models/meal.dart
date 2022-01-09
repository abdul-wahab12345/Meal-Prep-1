import 'package:flutter/material.dart';
import 'package:http/http.dart' as http;

class Meal with ChangeNotifier {

  int id;
  String title;
  String subTitle;
  String imageUrl;
  int productId;
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
    required this.productId,
    required this.fat,
    required this.protein,
    required this.isFav,
    required this.badges,
    required this.ingredients,
  });

  void toggleFavorite(int userId,String webUrl) {
    try {
      final url;
      if (!isFav) {
        url = Uri.parse(
            "${webUrl}wp-json/meal-prep/v1/like-meal?user_id=$userId&meal_id=$id");
        http.get(url);
      } else {
        url = Uri.parse(
            "${webUrl}wp-json/meal-prep/v1/unlike-meal?user_id=$userId&meal_id=$id");
        http.get(url);
      }
      print(url);

      isFav = !isFav;
      notifyListeners();
    } catch (error) {
      throw 'Something went wrong';
    }
  }
}
