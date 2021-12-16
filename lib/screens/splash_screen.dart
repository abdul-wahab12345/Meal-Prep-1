import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/meals.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/check_out.dart';
import 'package:mealprep/screens/Auth/cites_screen.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/user_meals_screen.dart';
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

    Future.delayed(Duration(seconds: 3)).then((value) async {
      var isLoggedIn =
          await Provider.of<Auth>(context, listen: false).tryAutoLogin();

      if (isLoggedIn) {
        Navigator.of(context).pushReplacementNamed(PlanScreen.routeName);
      } else {
        Navigator.of(context).pushReplacementNamed(CityScreen.routeName);
      }
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
