import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/screens/Auth/cites_screen.dart';
import 'package:mealprep/screens/Plans/add_plan_screen.dart';
import 'package:mealprep/screens/delivery_screen.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/bottom_bar.dart';
import 'package:mealprep/widgets/custom_bottombar.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class PlanScreen extends StatefulWidget {
  static const routeName = '/plans_screen';
  const PlanScreen({Key? key}) : super(key: key);

  @override
  State<PlanScreen> createState() => _PlanScreenState();
}

class _PlanScreenState extends State<PlanScreen> {
  int selectedPlanId = 0;
  int bottomIndex = 1;
  bool isLoading = false;

  final List<String> screenTitles = ['My Delivery', 'My Plans', 'My Profile'];

  Type _type = Type.Default;

  @override
  void initState() {
    List<Subscription> subs =
        Provider.of<Subscriptions>(context, listen: false).subscriptions;
    if (subs.isEmpty) {
      Provider.of<Subscriptions>(context, listen: false).fetchAndSetSubs();
    }

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    List<Subscription> subs = Provider.of<Subscriptions>(context).subscriptions;

    Map<String, Color> statusColors = {
      'Active': Colors.green,
      "Paused": Colors.yellow,
      'Inactive': Colors.red
    };

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    if (currentOrientation == Orientation.landscape) {
      width = 550 / 100;
    }

    Widget bottomBar;

    if (_type == Type.Reactive) {
      /**
       * show only one subscription on click
       */

      Subscription? data = Provider.of<Subscriptions>(context, listen: false)
          .getSubscriptionById(selectedPlanId);
          subs = data != null?[data]:[];

      bottomBar = Container(
        width: double.infinity,
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
        height: 70,
        margin: const EdgeInsets.only(bottom: 15, left: 15, right: 15),
        decoration: BoxDecoration(
            color: ashwhite, borderRadius: BorderRadius.circular(25)),
        child: BottomNavItem(
          text: "Reactivate",
          onTap: () {},
          icon: Icons.play_arrow_outlined,
        ),
      );
    } else if (Type.Pause == _type) {
      /**
       * show only one subscription on click
       */
      Subscription? data = Provider.of<Subscriptions>(context, listen: false)
          .getSubscriptionById(selectedPlanId);
          subs = data != null?[data]:[];

      bottomBar = CustomBottomBar(selectedPlanId: selectedPlanId);
    } else {
      bottomBar = BottomNavBar(
        index: bottomIndex,
        onTap: (index) {
          setState(() {
            bottomIndex = index;
          });
        },
      );
    }

    var _appBar = AppBar(
      backgroundColor: Colors.black,
      leading: Container(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          child: Image.asset('assets/images/alphatrait.png'),
        ),
      ),
      title: Center(child: Text(screenTitles[bottomIndex])),
      actions: [
        bottomIndex == 2
            ? IconButton(
                onPressed: () async {
                  await Provider.of<Auth>(context, listen: false)
                      .logout()
                      .then((value) {
                    Navigator.of(context)
                        .pushReplacementNamed(CityScreen.routeName);
                  });
                },
                icon: const Icon(Icons.logout))
            : GestureDetector(
                onTap: () {
                  setState(() {
                    bottomIndex = 2;
                  });
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

    Widget _plansTab = subs.isEmpty
        ? const AdaptiveIndecator()
        : Center(
            heightFactor: 1,
            child: Container(
              width: currentOrientation == Orientation.landscape
                  ? 550
                  : double.infinity,
              margin: const EdgeInsets.symmetric(
                horizontal: 15,
              ),
              child: SingleChildScrollView(
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      height: currentOrientation == Orientation.landscape
                          ? height * 70
                          : height * 78,
                      child: ListView.builder(
                        itemCount: subs.length,
                        itemBuilder: (ctx, index) => GestureDetector(
                          onTap: () {
                            setState(() {
                              if (selectedPlanId == subs[index].id) {
                                _type = Type.Default;
                                selectedPlanId = 0;
                                return;
                              }
                              selectedPlanId = subs[index].id;

                              if (subs[index].status == "Inactive") {
                                _type = Type.Reactive;
                              } else if (subs[index].status == "Active") {
                                _type = Type.Pause;
                              } else {
                                _type = Type.Default;
                              }
                            });
                          },
                          child: Container(
                            margin: const EdgeInsets.only(
                              top: 17,
                            ),
                            decoration: BoxDecoration(
                              color: aPrimary,
                              borderRadius: BorderRadius.circular(15),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Container(
                                  margin: EdgeInsets.only(
                                    left: width * 5,
                                  ),
                                  padding: const EdgeInsets.symmetric(
                                    vertical: 19,
                                  ),
                                  child: Column(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(subs[index].title,
                                          style: Theme.of(context)
                                              .textTheme
                                              .headline6),
                                      SizedBox(
                                        height: subs[index].status != "Inactive"
                                            ? 10
                                            : 60,
                                      ),
                                      if (subs[index].status != "Inactive")
                                        ConditionalInfo(subs[index]),
                                      Text(
                                        subs[index].status,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText2!
                                            .copyWith(
                                                color: statusColors[
                                                    subs[index].status]),
                                      ),
                                    ],
                                  ),
                                ), //ContentConatiner
                                Container(
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(
                                      20,
                                    ),
                                  ),
                                  width: 100,
                                  margin: const EdgeInsets.only(
                                    right: 15,
                                  ),
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 20),
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(20),
                                    child: Image.network(subs[index].imageUrl,
                                        fit: BoxFit.cover),
                                  ),
                                ), //imageContainer
                              ],
                            ),
                          ),
                        ),
                      ),
                    ), //Listview end
                  ],
                ),
              ),
            ),
          );

    List<Widget> pages = [
      DeliveryScreen(),
      _plansTab,
      const ProfileScreen(),
    ];

    return Scaffold(
        backgroundColor: Colors.black,
        appBar: _appBar,
        bottomNavigationBar: bottomBar,
        floatingActionButtonLocation:
            currentOrientation == Orientation.landscape
                ? FloatingActionButtonLocation.endFloat
                : FloatingActionButtonLocation.centerFloat,
        floatingActionButton: selectedPlanId == 0 && bottomIndex == 1
            ? FloatingActionButton(
                child: Container(
                  width: 60,
                  height: 60,
                  child: const Icon(
                    Icons.add,
                    size: 33,
                  ),
                  decoration: BoxDecoration(
                    shape: BoxShape.circle,
                    gradient: LinearGradient(
                      colors: [gra1, gra2],
                    ),
                  ),
                ),
                onPressed: () {
                  Navigator.of(context)
                      .pushNamed(AddPlan.routeName, arguments: 0);
                },
              )
            : null,
        body: pages[bottomIndex]);
  }
}

class ConditionalInfo extends StatelessWidget {
  Subscription subscription;

  ConditionalInfo(this.subscription);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Text('Next Delivery'),
        const SizedBox(
          height: 5,
        ),
        Text(
          subscription.nextDelivery,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        const SizedBox(
          height: 14,
        ),
      ],
    );
  }
}
