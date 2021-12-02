import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class Meal with ChangeNotifier {
  int id;
  String title;
  String subTitle;
  String imageUrl;
  Map<String, dynamic> calories;
  Map<String, dynamic> carbohydrates;

  Map<String, dynamic> fat;
  Map<String, dynamic> protein;

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
    isFav = !isFav;
    notifyListeners();
  }
}
