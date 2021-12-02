import 'package:flutter/material.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/screens/user_meals_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Meal Prep',
      theme: ThemeData(fontFamily: 'IBM').copyWith(
        textTheme: const TextTheme().copyWith(
          headline6: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w600,
            letterSpacing: 0.75,
            // height: 19.88,
          ),
          bodyText2: const TextStyle(
            color: Colors.white,
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 13,
            letterSpacing: 1.68,
          ),
          caption: const TextStyle(
            fontWeight: FontWeight.w400,
            fontStyle: FontStyle.normal,
            fontSize: 9,
            letterSpacing: 2,
          ),
        ),
       
      ),
      home: UserMealsScreen(),
    );
  }
}

