import 'package:flutter/material.dart';

import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/screens/Auth/change_password.dart';
import 'package:mealprep/screens/Auth/verification.dart';
import 'package:mealprep/screens/Delivery/delivery_note.dart';
import 'package:mealprep/screens/Error%20Screens/maintainance.dart';
import 'package:mealprep/screens/Plans/add_note_screen.dart';
import 'package:mealprep/screens/Plans/add_plan_screen.dart';
import 'package:mealprep/screens/Plans/pause.dart';
import 'package:mealprep/screens/Plans/check_out.dart';
import 'package:mealprep/screens/Auth/cites_screen.dart';
import 'package:mealprep/screens/Auth/forget_screen.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/screens/Delivery/delivery_screen.dart';
import 'package:mealprep/screens/meals/meal_details_screen.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/profile/add-payment.dart';

import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/screens/Auth/registeration_screen.dart';
import 'package:mealprep/screens/splash_screen.dart';
import 'package:mealprep/screens/meals/user_meals_screen.dart';
import 'package:mealprep/screens/Plans/variations_plan_screen.dart';

import 'package:provider/provider.dart';

import 'Models/meals.dart';
import 'screens/Error Screens/update.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(
          create: (ctx) => Auth(),
        ),
        ChangeNotifierProxyProvider<Auth, UserMealsData>(
          create: (_) => UserMealsData(0, '', []),
          update: (ctx, auth, previousData) => UserMealsData(
            auth.id as int,
            auth.websiteUrl as String,
            previousData == null ? [] : previousData.userMeals,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Products>(
          create: (_) => Products(''),
          update: (ctx, auth, previousData) => Products(
            auth.websiteUrl as String,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, Subscriptions>(
          create: (_) => Subscriptions(userId: 0, webUrl: ''),
          update: (ctx, auth, previousData) => Subscriptions(
            userId: auth.id,
            webUrl: auth.websiteUrl as String,
          ),
        ),
        ChangeNotifierProxyProvider<Auth, UserData>(
          create: (_) => UserData(webUrl: '', userId: 0),
          update: (ctx, auth, previousData) => UserData(
            webUrl: auth.websiteUrl as String,
            userId: auth.id!,
          ),
        ),
      ],
      child: MaterialApp(
        debugShowCheckedModeBanner: false,
        title: 'Meal Prep',
        theme: ThemeData(fontFamily: 'IBM').copyWith(
          textTheme: const TextTheme().copyWith(
            headline6: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              letterSpacing: 0.75,
              fontSize: 20,
              // height: 19.88,
            ),
            headline5: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w600,
              fontSize: 24,
            ),
            bodyText2: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 13,
              letterSpacing: 1.3,
            ),
            caption: const TextStyle(
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 9,
              letterSpacing: 2,
            ),
          ),
        ),
        // home:MaintainanceScreen(),
        routes: {
          '/': (ctx) => SplashScreen(),
          UserMealsScreen.routeName: (ctx) => const UserMealsScreen(),
          MealDetailsScreen.routeName: (ctx) => MealDetailsScreen(),
          ProfileScreen.routeName: (ctx) => const ProfileScreen(),
          RegisterScreen.routeName: (ctx) => RegisterScreen(),
          LoginScreen.routeName: (ctx) => LoginScreen(),
          ForgetScreen.routeName: (ctx) => ForgetScreen(),
          CityScreen.routeName: (ctx) => const CityScreen(),
          PlanScreen.routeName: (ctx) => const PlanScreen(),
          AddPlan.routeName: (ctx) => const AddPlan(),
          VariationsScreen.routeName: (ctx) => const VariationsScreen(),
          CheckOut.routeName: (ctx) => const CheckOut(),
          AddNote.routeName: (ctx) => AddNote(),
          Pause.routeName: (ctx) => const Pause(),
          DeliveryScreen.routeName: (ctx) => DeliveryScreen(),
          DeliveryNote.routeName: (ctx) => DeliveryNote(),
          VerificationScreen.routeName: (ctx) => VerificationScreen(),
          ChangePasswordScreen.routeName: (ctx) => ChangePasswordScreen(),
          AddPayment.routeName: (ctx) => AddPayment(),
        },
      ),
    );
  }
}
