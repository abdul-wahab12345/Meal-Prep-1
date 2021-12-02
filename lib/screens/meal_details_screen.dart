import 'package:flutter/material.dart';
import 'package:mealprep/Models/meals.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = 'meal-details';
  const MealDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments;
    final meal = Provider.of<UserMealsData>(context)
        .singleMeal(mealId as int);

    var textTheme = Theme.of(context).textTheme;

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      // leading: Container(
      //   padding: EdgeInsets.all(8),
      //   child: CircleAvatar(
      //     child: Image.asset('assets/images/alphatrait.png'),
      //   ),
      // ),
      title: Text("Meal"),
      actions: [
        Container(
          padding: EdgeInsets.all(8),
          child: CircleAvatar(
            child: Image.asset('assets/images/person.png'),
          ),
        )
      ],
    );
    return Scaffold(
      appBar: _appBar,
      body: Container(
        width: double.infinity,
        margin: EdgeInsets.only(
          left: 5,
          right: 5,
          top: 5,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(
                meal.title,
                style: textTheme.headline6!.copyWith(color: Colors.black),
              ),
              subtitle: Text(
                meal.subTitle,
                style: textTheme.bodyText2!.copyWith(color: Colors.black),
              ),
              trailing: IconButton(
                  onPressed: () {
                    Provider.of<UserMealsData>(context,listen:false).toggleFavorite(meal.id);
                  },
                  icon: meal.isFav
                      ? Icon(
                          Icons.favorite,
                          color: Colors.red,
                          size: 30,
                        )
                      : Icon(
                          Icons.favorite_outline,
                          color: Colors.black,
                          size: 30,
                        )),
            )
          ],
        ),
      ),
    );
  }
}


// Consumer<Meal>(
//                 builder: (ctx, meal, _) => IconButton(
//                     onPressed: () {},
//                     icon: meal.isFav
//                         ? Icon(
//                             Icons.favorite,
//                             color: Colors.red,
//                             size: 30,
//                           )
//                         : Icon(
//                             Icons.favorite_outline,
//                             color: Colors.black,
//                             size: 30,
//                           )),
//               )