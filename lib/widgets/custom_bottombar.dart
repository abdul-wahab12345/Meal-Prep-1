import 'package:flutter/material.dart';
import 'package:mealprep/Models/meals.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/add_note_screen.dart';
import 'package:mealprep/screens/Plans/add_plan_screen.dart';
import 'package:mealprep/screens/Plans/pause.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/meals/user_meals_screen.dart';
import 'package:mealprep/widgets/adaptiveDialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:provider/provider.dart';

class CustomBottomBar extends StatefulWidget {
  CustomBottomBar(
      {Key? key, required this.selectedPlanId, required this.status,required this.callback})
      : super(key: key);

  final int selectedPlanId;
  String status;
  Function callback;

  @override
  State<CustomBottomBar> createState() => _CustomBottomBarState();
}

class _CustomBottomBarState extends State<CustomBottomBar> {
  bool reactivateLoading = false;

  

  @override
  Widget build(BuildContext context) {
    Subscription? subscription =
        Provider.of<Subscriptions>(context, listen: false)
            .getSubscriptionById(widget.selectedPlanId);
    return Container(
      width: double.infinity,
      padding: const EdgeInsets.symmetric(vertical: 15),
      height: 75,
      margin: const EdgeInsets.only(bottom: 20, left: 15, right: 15),
      decoration: BoxDecoration(
          color: ashwhite, borderRadius: BorderRadius.circular(25)),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          if (subscription!.endDate == "0" && widget.status == "Active")
            BottomNavItem(
              text: "Pause",
              onTap: () {
                Navigator.of(context).pushNamed(Pause.routeName,
                    arguments: widget.selectedPlanId);
              },
              icon: Icons.pause_outlined,
            )
          else
            reactivateLoading
                ? AdaptiveIndecator()
                : BottomNavItem(
                    text: "Reactivate",
                    onTap: (){
                      setState(() {
                        reactivateLoading = true;
                        widget.callback();
                      });
                    },
                    icon: Icons.play_arrow_outlined,
                  ),
          if (subscription.isCutOf)
            BottomNavItem(
              text: "Switch",
              onTap: () {
                Navigator.of(context).pushNamed(AddPlan.routeName,
                    arguments: widget.selectedPlanId);
              },
              icon: Icons.sync_alt,
            ),
          BottomNavItem(
            text: "Add note",
            onTap: () {
              Navigator.of(context).pushNamed(AddNote.routeName,
                  arguments: widget.selectedPlanId);
            },
            icon: Icons.note_add_outlined,
          ),
          // BottomNavItem(
          //   text: "Meals",
          //   onTap: () {

          //     Provider.of<UserMealsData>(context, listen: false).subscription =
          //         subscription;
          //     Navigator.of(context).pushNamed(UserMealsScreen.routeName,
          //         arguments: selectedPlanId);
          //   },
          //   icon: Icons.restaurant,
          // ),
        ],
      ),
    );
  }
}

class BottomNavItem extends StatelessWidget {
  String text;
  IconData icon;
  VoidCallback onTap;
  BottomNavItem({required this.text, required this.icon, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          Icon(icon),
          Text(
            text,
            style: Theme.of(context).textTheme.bodyText2!.copyWith(
                  color: Colors.black,
                ),
          ),
        ],
      ),
    );
  }
}
