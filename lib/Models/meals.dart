import 'package:flutter/foundation.dart';
import 'package:mealprep/Models/meal.dart';

class UserMealsData with ChangeNotifier {
  List<Meal> _userMeals = [
    Meal(
      id: 1,
      title: 'Beef Roasted Beets',
      subTitle: 'with Coconut-Dill Cream',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
      calories: {
        'weight': '1802',
        'unit': 'kcal',
      },
      carbohydrates: {
        'weight': '37g',
        'unit': 'Carb',
      },
      fat: {'weight': '114g', 'unit': 'Fat'},
      protein: {
        'weight': '112g',
        'unit': 'Protein',
      },
      isFav: true,
      badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
      ingredients:
          "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    ),

    //2

    Meal(
      id: 2,
      title: 'Chicken Curried Greens',
      subTitle: 'with Carrot & Kale',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
      calories: {
        'weight': '22g',
        'unit': 'kcal',
      },
      carbohydrates: {
        'weight': '42g',
        'unit': 'Carb',
      },
      fat: {'weight': '2g', 'unit': 'Fat'},
      protein: {
        'weight': '342g',
        'unit': 'Protein',
      },
      isFav: false,
      badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
      ingredients:
          "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    ),

    //3
    Meal(
      id: 3,
      title: 'Turkey Shepherd Pie',
      subTitle: 'with Sweet Potato & Peas',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
      calories: {
        'weight': '32g',
        'unit': 'kcal',
      },
      carbohydrates: {
        'weight': '622g',
        'unit': 'Carb',
      },
      fat: {'weight': '2g', 'unit': 'Fat'},
      protein: {
        'weight': '32g',
        'unit': 'Protein',
      },
      isFav: false,
      badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
      ingredients:
          "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    ),
    //4
    Meal(
      id: 4,
      title: 'Turkey Shepherd Pie',
      subTitle: 'with Sweet Potato & Peas',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
      calories: {
        'weight': '232g',
        'unit': 'kcal',
      },
      carbohydrates: {
        'weight': '12g',
        'unit': 'Carb',
      },
      fat: {'weight': '2g', 'unit': 'Fat'},
      protein: {
        'weight': '72g',
        'unit': 'Protein',
      },
      isFav: false,
      badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
      ingredients:
          "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    ),
    //5
    Meal(
      id: 5,
      title: 'Turkey Shepherd Pie',
      subTitle: 'with Sweet Potato & Peas',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1.png',
      calories: {
        'weight': '23g',
        'unit': 'kcal',
      },
      carbohydrates: {
        'weight': '122g',
        'unit': 'Carb',
      },
      fat: {'weight': '2g', 'unit': 'Fat'},
      protein: {
        'weight': '32g',
        'unit': 'Protein',
      },
      isFav: false,
      badges: ["Gluten Free", "Soy Free", "Dairy Free", "Nut Free"],
      ingredients:
          "With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff. With some other stuff.",
    ),
  ];

  List<Meal> get userMeals {
    return [..._userMeals];
  }

  Meal singleMeal(int id) {
    return _userMeals.firstWhere((element) => element.id == id);
  }

  void toggleFavorite(int id) {
    Meal meal = _userMeals.firstWhere((element) => element.id == id);
    if (meal != null) {
      meal.isFav = !meal.isFav;
      print(meal.isFav);
      notifyListeners();
    }
  }
}
