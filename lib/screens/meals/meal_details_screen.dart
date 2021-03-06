import 'package:flutter/material.dart';

import 'package:mealprep/Models/meals.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';

import 'package:mealprep/widgets/auth_button.dart';

import 'package:provider/provider.dart';

class MealDetailsScreen extends StatelessWidget {
  static const routeName = 'meal-details';
  MealDetailsScreen({Key? key}) : super(key: key);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final mealId = ModalRoute.of(context)!.settings.arguments;
    final meal = Provider.of<UserMealsData>(context).singleMeal(mealId as int);
    var height = MediaQuery.of(context).size.height / 100;
    TextEditingController feedbackController = TextEditingController();

    var textTheme = Theme.of(context).textTheme;

    showModal(String imageUrl) {
      showModalBottomSheet<void>(
          context: context,
          builder: (BuildContext ctx) {
            return Container(
              height: height * 100,
              color: abackground,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    mainAxisSize: MainAxisSize.min,
                    children: <Widget>[
                      Container(
                        padding: const EdgeInsets.all(10),
                        // margin: EdgeInsets.only(top: height * 2),
                        width: double.infinity,
                        decoration: BoxDecoration(
                          color: aPrimary,
                          borderRadius: BorderRadius.circular(12),
                        ),
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            controller: feedbackController,
                            validator: (value) {
                              if (value!.isEmpty) {
                                return "Please enter your message";
                              }
                              return null;
                            },
                            maxLines: 6,
                            decoration: InputDecoration(
                                focusedBorder: const OutlineInputBorder(
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                enabledBorder: const OutlineInputBorder(
                                  // borderRadius: BorderRadius.circular(20),
                                  borderSide: BorderSide(
                                    color: Colors.transparent,
                                  ),
                                ),
                                errorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0),
                                ),
                                focusedErrorBorder: OutlineInputBorder(
                                  borderRadius: BorderRadius.circular(20),
                                  borderSide: const BorderSide(
                                      color: Colors.red, width: 2.0),
                                ),
                                errorStyle: Theme.of(context)
                                    .textTheme
                                    .caption!
                                    .copyWith(color: Colors.red, fontSize: 12),
                                hintStyle:
                                    Theme.of(context).textTheme.headline6,
                                hintText:
                                    "What don???t you like about this meal?"),
                          ),
                        ),
                      ),
                      SizedBox(
                        height: height * 2,
                      ),
                      CustomButton(
                        text: "Submit Feedback",
                        callback: () async {
                          if (_formKey.currentState!.validate()) {
                            Provider.of<UserMealsData>(context, listen: false)
                                .dislikeMeal(meal.id, feedbackController.text)
                                .then((value) {
                              feedbackController.text = '';
                              Navigator.of(ctx).pop();
                            }).catchError((error) {
                              showDialog(
                                  context: context,
                                  builder: (ctx) => AdaptiveDiaglog(
                                      ctx: ctx,
                                      title: 'Error Occurred',
                                      btnYes: 'Okay',
                                      yesPressed: () {
                                        Navigator.of(context).pop();
                                      }));
                            });
                          }
                        },
                      ),
                      SizedBox(
                        height: height * 2,
                      ),
                    ],
                  ),
                ),
              ),
            );
          });
    }

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Meal"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName, arguments: 2);
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
    return Scaffold(
      appBar: _appBar,
      backgroundColor: abackground,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.only(
          left: 10,
          right: 10,
          top: 15,
        ),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ListTile(
              title: Text(
                meal.title,
                style: textTheme.headline6,
              ),
              subtitle: Text(meal.subTitle, style: textTheme.bodyText2),
              trailing: Container(
                width: 100,
                child: Row(children: [
                  IconButton(
                      onPressed: () {
                        // print()
                        showModal(meal.imageUrl);
                      },
                      icon: const Icon(
                        Icons.thumb_down_alt_outlined,
                        color: Colors.white,
                        size: 30,
                      )),
                  IconButton(
                    onPressed: () {
                      Provider.of<UserMealsData>(context, listen: false)
                          .toggleFavorite(mealId)
                          .catchError((error) {
                        showDialog(
                            context: context,
                            builder: (ctx) => AdaptiveDiaglog(
                                ctx: ctx,
                                title: 'An Error Occurred',
                                btnYes: 'Okay',
                                yesPressed: () {
                                  Navigator.of(context).pop();
                                }));
                      });
                    },
                    icon: meal.isFav
                        ? const Icon(
                            Icons.favorite,
                            color: Colors.red,
                            size: 30,
                          )
                        : const Icon(
                            Icons.favorite_outline,
                            color: Colors.white,
                            size: 30,
                          ),
                  ),
                ]),
              ),
            ),
            Container(
              margin: const EdgeInsets.only(top: 10),
              decoration: BoxDecoration(
                color: aPrimary,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.start,
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                      height: 160,
                      width: 160,
                      alignment: Alignment.center,
                      child: Hero(
                        tag: meal.id,
                        child: Image.network(
                          meal.imageUrl,
                          fit: BoxFit.cover,
                        ),
                      )),
                  Container(
                    margin: const EdgeInsets.only(right: 40, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(meal.calories['weight'] as String,
                            style: textTheme.headline5!
                                .copyWith(color: Colors.green)),
                        Text(meal.calories['type'] as String,
                            style: const TextStyle(
                                color: Colors.green,
                                fontSize: 8,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(meal.carbohydrates['weight'] as String,
                            style: textTheme.headline5),
                        Text(meal.carbohydrates['type'] as String,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  ),
                  Container(
                    margin: const EdgeInsets.only(right: 30, top: 10),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.start,
                      children: [
                        const SizedBox(
                          height: 20,
                        ),
                        Text(meal.protein['weight'] as String,
                            style: textTheme.headline5),
                        Text(meal.protein['type'] as String,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600)),
                        const SizedBox(
                          height: 20,
                        ),
                        Text(meal.fat['weight'] as String,
                            style: textTheme.headline5),
                        Text(meal.fat['type'] as String,
                            style: const TextStyle(
                                color: Colors.white,
                                fontSize: 8,
                                fontWeight: FontWeight.w600)),
                      ],
                    ),
                  )
                ],
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: meal.badges
                    .map((e) => Container(
                          padding: const EdgeInsets.symmetric(
                              vertical: 5, horizontal: 6),
                          margin: const EdgeInsets.only(right: 12),
                          decoration: BoxDecoration(
                              color: const Color.fromRGBO(10, 169, 216, 1),
                              borderRadius: BorderRadius.circular(20)),
                          child: Text(
                            e,
                            style: textTheme.bodyText2,
                          ),
                        ))
                    .toList(),
              ),
            ),
            const SizedBox(
              height: 25,
            ),
            Text(
              "Ingredients",
              style: textTheme.headline6,
            ),
            const SizedBox(
              height: 6,
            ),
            Text(
              meal.ingredients,
              style: textTheme.bodyText2,
            ),
          ],
        ),
      ),
    );
  }
}
