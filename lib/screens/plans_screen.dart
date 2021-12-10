import 'package:flutter/material.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/screens/add_plan_screen.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/widgets/bottom_bar.dart';

import '../constant.dart';

class PlanScreen extends StatelessWidget {
  static const routeName = '/plans_screen';
  const PlanScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var subscrip = Subscriptions();
    List<Subscription> subs = subscrip.subscriptions;

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

    var _key = GlobalKey();

    var bottomBar = BottomNavBar(
      key: _key,
    );

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      leading: Container(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          child: Image.asset('assets/images/alphatrait.png'),
        ),
      ),
      title: const Text("My Plans"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              child: Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      bottomNavigationBar: bottomBar,
      floatingActionButtonLocation: currentOrientation == Orientation.landscape? FloatingActionButtonLocation.endFloat: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: FloatingActionButton(
        child: Container(
          width: 60,
          height: 60,
          child: Icon(
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
        onPressed: () {},
      ),
      body: Center(
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
                  height: currentOrientation == Orientation.landscape? height*70: height * 78,
                 
                  child: ListView.builder(
                    itemCount: subs.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                      onTap: (){
                        
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
                                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(subs[index].title,
                                      style:
                                          Theme.of(context).textTheme.headline6),
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
                                            color:
                                                statusColors[subs[index].status]),
                                  ),
                                ],
                              ),
                            ), //ContentConatiner
                            Container(
                              width: 100,
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Image.network(subs[index].imageUrl,
                                  fit: BoxFit.cover),
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
      ),
    );
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
        Text('Next Delivery'),
        SizedBox(
          height: 5,
        ),
        Text(
          subscription.nextDelivery,
          style: Theme.of(context).textTheme.bodyText2,
        ),
        SizedBox(
          height: 14,
        ),
      ],
    );
  }
}


  //  GestureDetector(
  //                 onTap: () {
  //                   Navigator.of(context).pushNamed(AddPlan.routeName);
  //                 },
  //                 child: Container(
  //                   // height: height * 5.5,
  //                   width: width * 60,
  //                   padding: EdgeInsets.all(17),
  //                   decoration: BoxDecoration(
  //                     //color: Colors.purple,
  //                     borderRadius: BorderRadius.circular(20),
  //                     gradient: LinearGradient(colors: [
  //                       gra1,
  //                       gra2,
  //                     ], begin: Alignment.topLeft, end: Alignment.bottomRight),
  //                   ),
  //                   child: Text(
  //                     'Add New plan',
  //                     textAlign: TextAlign.center,
  //                     style: Theme.of(context).textTheme.bodyText2,
  //                   ),
  //                 ),
          

  //               ),
