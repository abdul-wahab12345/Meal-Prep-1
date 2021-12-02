
import 'package:flutter/material.dart';
import 'package:mealprep/Models/meal.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class MealDetailsScreen extends StatelessWidget {
  const MealDetailsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    Meal meal =
        Provider.of<UserMealsData>(context, listen: false).singleMeal(1);

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      leading: Container(
        padding: EdgeInsets.all(8),
        child: CircleAvatar(
          child: Image.asset('assets/images/alphatrait.png'),
        ),
      ),
      title: Text("User Meals"),
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
          left: 15,
          right: 15,
          top: 15,
        ),
        child: Column(
          children: [
            ListTile(
              title: Text(meal.title,style: Theme.of(context).textTheme.headline6!.copyWith(color: Colors.black),),
              subtitle: Text(meal.subTitle,style: TextStyle(color: Colors.black),),
              trailing:
                  Icon(meal.isFav ? Icons.favorite : Icons.favorite_outline),
            )
          ],
        ),
      ),
    );
  }
}
