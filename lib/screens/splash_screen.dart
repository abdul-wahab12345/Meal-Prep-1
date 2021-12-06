import 'package:flutter/material.dart';
import 'package:mealprep/Models/meals.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    // TODO: implement initState

    Future.delayed(Duration.zero).then((value) {
      Provider.of<UserMealsData>(context, listen: false)
          .fetchAndSetMeals()
          .then((value) => Navigator.of(context).pushReplacementNamed('home'));
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
        child: Scaffold(
      backgroundColor: abackground,
      body: Center(
        child: Container(
          height: double.infinity,
          width: double.infinity,
          child: Image.asset(
            "assets/images/splash_screen.png",
            fit: BoxFit.cover,
          ),
        ),
      ),
    ));
  }
}
