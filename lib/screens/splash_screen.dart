

import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Auth/cites_screen.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:provider/provider.dart';


class SplashScreen extends StatefulWidget {
  const SplashScreen({Key? key}) : super(key: key);

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  bool isFirst = true;

  @override
  void didChangeDependencies() async {
    // TODO: implement didChangeDependencies
    super.didChangeDependencies();

    if (isFirst) {
      isFirst = false;

      var isLoggedIn =
          await Provider.of<Auth>(context, listen: false).tryAutoLogin();

      if (isLoggedIn) {
        try {
          bool data =
              await Provider.of<Auth>(context, listen: false).verifyToken();
          if (data) {
            Navigator.of(context).pushReplacementNamed(PlanScreen.routeName);
          } else {
            Provider.of<Auth>(context, listen: false).logout();
            Navigator.of(context).pushReplacementNamed(CityScreen.routeName);
          }
        } catch (error) {
          Navigator.of(context).pushReplacementNamed(CityScreen.routeName);
        }
      } else {
        Navigator.of(context).pushReplacementNamed(CityScreen.routeName);
      }
    }
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
