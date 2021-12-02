import 'package:flutter/material.dart';

import 'package:mealprep/Models/meal.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class UserMealsScreen extends StatelessWidget {
  const UserMealsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    List<Meal> userMeals = Provider.of<UserMealsData>(context).userMeals;

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
      body: Center(
        child: Container(
          width: currentOrientation == Orientation.landscape
              ? 550
              : double.infinity,
          margin: EdgeInsets.symmetric(
            horizontal: width * 2,
          ),
          child: ListView.builder(
            itemCount: userMeals.length,
            itemBuilder: (ctx, index) => Container(
              //  constraints: BoxConstraints(minHeight: 200),
              //height: 200,
              margin: EdgeInsets.only(
                top: 20,
              ),
              decoration: BoxDecoration(
                color: aPrimary,
                borderRadius: BorderRadius.circular(15),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  ContentContainer(
                    meal: userMeals[index]
                  ), //Content Container
                  Container(
                    height: 180,
                    width: width * 35,
                    padding: EdgeInsets.symmetric(vertical: 20),
                    //color: Colors.white,
                    child: Image.network(
                      userMeals[index].imageUrl,
                      fit: BoxFit.cover,
                    ),
                  ), //ImageConatiner
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class ContentContainer extends StatelessWidget {

  Meal meal;
  ContentContainer({required this.meal});

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData = MediaQuery.of(context);
    var height = queryData.size.height / 100;
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
        vertical: 20,
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          const Icon(
            Icons.favorite_border_outlined,
            color: Colors.white,
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
                        meal.calories['weight'],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.calories['unit'],
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //calories container
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.protein['weight'],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.protein['unit'],
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //protein Container
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.carbohydrates['weight'],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.carbohydrates['unit'],
                        style: Theme.of(context).textTheme.caption,
                      ),
                    ],
                  ),
                ), //carbsContainer
                Container(
                  child: Column(
                    children: [
                      Text(
                        meal.carbohydrates['weight'],
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                      Text(
                        meal.carbohydrates['unit'],
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
