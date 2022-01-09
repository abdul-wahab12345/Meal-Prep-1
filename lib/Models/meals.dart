import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mealprep/Models/meal.dart';
import 'package:mealprep/Models/subscriptions.dart';

class UserMealsData with ChangeNotifier {
  List<Meal> _userMeals = [];
  final int userId;
  final String webUrl;
  Subscription? subscription;

  UserMealsData(this.userId, this.webUrl, this._userMeals);

  List<Meal> get userMeals {
    List<Meal> filteredMeals = [];
    if (subscription != null && _userMeals.isNotEmpty) {
      var prodIds = subscription!.productIds;
      if (prodIds.isEmpty) {
        return [];
      }
      print(prodIds);
      print(123);
      for (var i = 0; i < _userMeals.length; i++) {
        for (var j = 0; j < prodIds.length; j++) {
          if (_userMeals[i].productId == prodIds[j]) {
            filteredMeals.add(_userMeals[i]);
          }
        }
      }
      return filteredMeals;
    }

    return [..._userMeals];
  }

  Meal singleMeal(int id) {
    return _userMeals.firstWhere((element) => element.id == id);
  }

  Future<void> toggleFavorite(int id) async {
    try {
      Meal meal = _userMeals.firstWhere((element) => element.id == id);
      if (meal != null) {
        final url;
        if (!meal.isFav) {
          url = Uri.parse(
              "${webUrl}wp-json/meal-prep/v1/like-meal?user_id=$userId&meal_id=$id");
          http.get(url);
        } else {
          url = Uri.parse(
              "${webUrl}wp-json/meal-prep/v1/unlike-meal?user_id=$userId&meal_id=$id");
          http.get(url);
        }
        print(url);

        meal.isFav = !meal.isFav;

        notifyListeners();
      }
    } catch (error) {
      throw 'Something Went Wrong';
    }
  }

  Future<bool> dislikeMeal(int id, String sms) async {
    try {
      final url = Uri.parse("${webUrl}wp-json/meal-prep/v1/dislike-meal");
      await http.post(
        url,
        body: {
          'user_id': userId.toString(),
          'id': id.toString(),
          'aw_sms': sms,
        },
      );
      return true;
    } catch (error) {
      throw 'Something Went Wrong';
    }
  }

  Future<void> fetchAndSetMeals() async {
    try {
      var url = Uri.parse('${webUrl}wp-json/meal-prep/v1/user-meals');

      final response =
          await http.post(url, body: {'user_id': userId.toString()});

      print(response.statusCode);

      if (response.statusCode != 200) {
        throw 'Something went wrong !';
      }

      List<Meal> newMeals = [];

      final extractedData = json.decode(response.body) as List<dynamic>;
      if (extractedData.isEmpty) {
        return;
      }

      extractedData.forEach(
        (meal) {
          //print(meal['calories']);

          List<String> badges = [];

          var responseBadges = meal['badges'] as List;

          responseBadges.forEach(
            (element) {
              badges.add(element as String);
            },
          );

          Map<String, String> calories = {
            'weight': meal['calories']['weight'].toString(),
            'type': meal['calories']['type'] as String,
          };

          Map<String, String> carbohydrates = {
            'weight': meal['carbohydrates']['weight'].toString(),
            'type': meal['carbohydrates']['type'] as String,
          };

          Map<String, String> fat = {
            'weight': meal['fat']['weight'].toString(),
            'type': meal['fat']['type'] as String,
          };

          Map<String, String> protein = {
            'weight': meal['protein']['weight'].toString(),
            'type': meal['protein']['type'] as String,
          };

          newMeals.add(
            Meal(
              id: meal['id'],
              productId: meal['product_id'],
              title: meal['title'],
              subTitle: meal['subTitle'],
              imageUrl: meal['imageUrl'],
              calories: calories,
              carbohydrates: carbohydrates,
              fat: fat,
              protein: protein,
              isFav: meal['isFavorite'],
              badges: badges,
              ingredients: meal['ingredients'] as String,
            ),
          );
        },
      );
      _userMeals = newMeals;

      notifyListeners();
    } catch (error) {
      throw 'Something Went Wrong';
    }
  }

  List<Meal>? findMealsBySub(Subscription sub) {
    if (_userMeals.isEmpty) {
      return null;
    }
    List<Meal> filteredMeals = [];
    print(_userMeals);
    var prodIds = sub.productIds;

    for (var i = 0; i < userMeals.length; i++) {
      var index = prodIds.firstWhere((element) => element == userMeals[i].id);
      print(index);
      if (index > 0) {
        filteredMeals.add(userMeals[i]);
      }
    }

    print(filteredMeals);

    return filteredMeals;
  }
}
