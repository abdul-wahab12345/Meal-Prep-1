import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import 'package:mealprep/Models/meal.dart';
import 'package:mealprep/Models/meals.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/meals/meal_details_screen.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:provider/provider.dart';

class UserMealsScreen extends StatelessWidget {
  const UserMealsScreen({Key? key}) : super(key: key);



  @override
  Widget build(BuildContext context) {
   

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      
      title: Text("User Meals"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName,arguments: 2);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
            child: CircleAvatar(
              child: Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );

    MediaQueryData queryData = MediaQuery.of(context);
    var height = queryData.size.height / 100;
    var width = queryData.size.width / 100;
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    if (currentOrientation == Orientation.landscape) {
      width = 550 / 100;
    }

    return Scaffold(
      appBar: _appBar,
      backgroundColor: abackground,
      body: FutureBuilder(
          future: Provider.of<UserMealsData>(context, listen: false)
              .fetchAndSetMeals(),
          builder: (context, snapShot) {
            if (snapShot.connectionState == ConnectionState.waiting) {
              return  AdaptiveIndecator();
            }

            if (snapShot.hasError) {
              return Center(child: Text(snapShot.error.toString()));
            } else {
              return Consumer<UserMealsData>(
                builder: (ctx, userMealsData, child) {
                  List<Meal> userMeals = userMealsData.userMeals;
                  return Container(
                    width: currentOrientation == Orientation.landscape
                        ? 550
                        : double.infinity,
                    margin: EdgeInsets.symmetric(
                        horizontal: width * 2, vertical: 10),
                    child: ListView.builder(
                      itemCount: userMeals.length,
                      itemBuilder: (ctx, index) => GestureDetector(
                        onTap: () {
                          Navigator.pushNamed(
                              context, MealDetailsScreen.routeName,
                              arguments: userMeals[index].id);
                        },
                        child: Container(
                          margin: const EdgeInsets.only(
                            top: 20,
                          ),
                          decoration: BoxDecoration(
                            color: aPrimary,
                            borderRadius: BorderRadius.circular(15),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            crossAxisAlignment: CrossAxisAlignment.start,
                            children: [
                              ChangeNotifierProvider.value(
                                value: userMeals[index],
                                child: ContentContainer(),
                              ), //Content Container
                              Container(
                                height: 180,
                                width: width * 35,
                                padding:
                                    const EdgeInsets.symmetric(vertical: 20),
                                //color: Colors.white,
                                child: Hero(
                                  tag: userMeals[index].id,
                                  child: Image.network(
                                    userMeals[index].imageUrl,
                                    fit: BoxFit.cover,
                                  ),
                                ),
                              ), //ImageConatiner
                            ],
                          ),
                        ),
                      ),
                    ),
                  );
                },
              );
            }
          }),
    );
  }
}

class ContentContainer extends StatelessWidget {
  ContentContainer();

  @override
  Widget build(BuildContext context) {
    Meal meal = Provider.of<Meal>(context, listen: false);

    MediaQueryData queryData = MediaQuery.of(context);
    var width = queryData.size.width / 100;
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    if (currentOrientation == Orientation.landscape) {
      width = 550 / 100;
    }

    return Container(
      margin: EdgeInsets.symmetric(
        horizontal: width * 5,
      ),
      padding: const EdgeInsets.symmetric(
        vertical: 22,
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Consumer<Meal>(
            builder: (ctx, meal, _) => GestureDetector(
                onTap: () {
                  meal.toggleFavorite();
                },
                child: meal.isFav
                    ? const Icon(
                      
                        Icons.favorite,
                        color: Colors.red,
                        size: 30,
                      )
                    : const Icon(
                        Icons.favorite_outline,
                        color: Colors.white,
                         size: 30,
                      )),
          ),
          const SizedBox(
            height: 12,
          ),
          Container(
            width: width * 50,
            //Column That Contains Title Subtitle And icon
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  meal.title,
                  style: Theme.of(context).textTheme.headline6,
                ),
                Text(
                  meal.subTitle,
                  style: Theme.of(context).textTheme.bodyText2,
                ),
                const SizedBox(
                  height: 15,
                ),
              ],
            ),
          ),
          Container(
            width: width * 50,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.calories['weight'] as String,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.calories['type'] as String,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //calories container
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.protein['weight'] as String,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.protein['type'] as String,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //protein Container
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.carbohydrates['weight'] as String,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.carbohydrates['type'] as String,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //carbsContainer
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.fat['weight'] as String,
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.fat['type'] as String,
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //Fat Container
              ],
            ),
          ),
        ],
      ),
    );
  }
}
