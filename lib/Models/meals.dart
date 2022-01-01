import 'dart:convert';
import 'package:flutter/foundation.dart';
import 'package:http/http.dart' as http;
import 'package:mealprep/Models/meal.dart';

class UserMealsData with ChangeNotifier {
  List<Meal> _userMeals = [
    // Meal(
    //   id: 1,
    //   title: 'Beef Roasted Beets',
    //   subTitle: 'with Coconut-Dill Cream',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
    //   calories: {
    //     'weight': '1802',
    //     'type': 'kcal',
    //   },
    //   carbohydrates: {
    //     'weight': '37g',
    //     'type': 'Carb',
    //   },
    //   fat: {'weight': '114g', 'type': 'Fat'},
    //   protein: {
    //     'weight': '112g',
    //     'type': 'Protein',
    //   },
    //   isFav: true,
    //   badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
    //   ingredients:
    //       "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    // ),

    // //2

    // Meal(
    //   id: 2,
    //   title: 'Chicken Curried Greens',
    //   subTitle: 'with Carrot & Kale',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
    //   calories: {
    //     'weight': '22g',
    //     'type': 'kcal',
    //   },
    //   carbohydrates: {
    //     'weight': '42g',
    //     'type': 'Carb',
    //   },
    //   fat: {'weight': '2g', 'type': 'Fat'},
    //   protein: {
    //     'weight': '342g',
    //     'type': 'Protein',
    //   },
    //   isFav: false,
    //   badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
    //   ingredients:
    //       "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    // ),

    // //3
    // Meal(
    //   id: 3,
    //   title: 'Turkey Shepherd Pie',
    //   subTitle: 'with Sweet Potato & Peas',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
    //   calories: {
    //     'weight': '32g',
    //     'type': 'kcal',
    //   },
    //   carbohydrates: {
    //     'weight': '622g',
    //     'type': 'Carb',
    //   },
    //   fat: {'weight': '2g', 'type': 'Fat'},
    //   protein: {
    //     'weight': '32g',
    //     'type': 'Protein',
    //   },
    //   isFav: false,
    //   badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
    //   ingredients:
    //       "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    // ),
    // //4
    // Meal(
    //   id: 4,
    //   title: 'Turkey Shepherd Pie',
    //   subTitle: 'with Sweet Potato & Peas',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
    //   calories: {
    //     'weight': '232g',
    //     'type': 'kcal',
    //   },
    //   carbohydrates: {
    //     'weight': '12g',
    //     'type': 'Carb',
    //   },
    //   fat: {'weight': '2g', 'type': 'Fat'},
    //   protein: {
    //     'weight': '72g',
    //     'type': 'Protein',
    //   },
    //   isFav: false,
    //   badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
    //   ingredients:
    //       "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    // ),
    // //5
    // Meal(
    //   id: 5,
    //   title: 'Turkey Shepherd Pie',
    //   subTitle: 'with Sweet Potato & Peas',
    //   imageUrl:
    //       'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
    //   calories: {
    //     'weight': '23g',
    //     'type': 'kcal',
    //   },
    //   carbohydrates: {
    //     'weight': '122g',
    //     'type': 'Carb',
    //   },
    //   fat: {'weight': '2g', 'type': 'Fat'},
    //   protein: {
    //     'weight': '32g',
    //     'type': 'Protein',
    //   },
    //   isFav: false,
    //   badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
    //   ingredients:
    //       "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    // ),
  ];
  final int userId;
  final String webUrl;

  UserMealsData(this.userId, this.webUrl, this._userMeals);

  List<Meal> get userMeals {
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
      throw error;
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
      throw error;
    }
  }

  Future<void> fetchAndSetMeals() async {
    try {
      var url = Uri.parse('${webUrl}wp-json/meal-prep/v1/user-meals');

      final response =
          await http.post(url, body: {'user_id': userId.toString()});

       print(response.statusCode);

       if(response.statusCode!=200){
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
      throw error;
    }
  }
}
