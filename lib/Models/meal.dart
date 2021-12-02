class Meal {
  int id;
  String title;
  String subTitle;
  String imageUrl;
  Map<String, dynamic> calories;
  Map<String, dynamic> carbohydrates;

  Map<String, dynamic> fat;
  Map<String, dynamic> protein;

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
  });
}

List<Meal> userMeals = [
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
    isFav: false,
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
  ),
  //4
  Meal(
    id: 3,
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
  ),
  //5
  Meal(
    id: 3,
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
  ),
];
