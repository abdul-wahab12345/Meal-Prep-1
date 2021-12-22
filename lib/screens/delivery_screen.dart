import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/bottom_bar.dart';

class DeliveryScreen extends StatelessWidget {
  static const routeName = '/delivery';
  DeliveryScreen({Key? key}) : super(key: key);
  var _noteController = TextEditingController();
  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      leading: Container(
        padding: const EdgeInsets.all(8),
        child: CircleAvatar(
          child: Image.asset('assets/images/alphatrait.png'),
        ),
      ),
      title: Center(child: const Text("My Plans")),
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
      body: Center(
        heightFactor: 1,
        child: Container(
          width: currentOrientation == Orientation.landscape
              ? 600
              : double.infinity,
          //height: currentOrientation==Orientation.landscape?200:,
          margin: EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(builder: (context, constraint) {
                  var stack_height = constraint.maxHeight;
                  var stack_width = constraint.maxWidth / 2;
                  print(stack_height);
                  return Stack(
                    children: [
                      Container(
                        width: double.infinity,
                        margin: EdgeInsets.only(top: height * 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: aPrimary,
                        ),
                        padding: EdgeInsets.only(
                            top: height * 9, left: 30, right: 30, bottom: 30),
                        height: height * 37,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Text(
                              'The gate code is 2245. Please leave the bag ourside the door. Thank you',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                            TextButton(
                              child: Text(
                                'Click Here to update your delivery note...',
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                              onPressed: () {},
                            )
                          ],
                        ),
                      ),
                      Positioned(
                        left: (stack_width - (width * 35)),
                        bottom: height * 33,
                        child: Container(
                          child: Image.asset('assets/images/car.png',
                              height: height * 10, width: width * 70),
                        ),
                      ), //imageConatiner
                    ],
                  );
                }),
                Center(
                  child: Container(
                    margin: EdgeInsets.only(top: 30),
                    child: Text(
                      'Next Delivery: Today around 2 pm',
                      style: Theme.of(context).textTheme.bodyText2,
                    ),
                  ),
                ),
                Center(
                  child: Container(
                    width: currentOrientation == Orientation.landscape
                        ? width * 30
                        : width * 50,
                    height: currentOrientation == Orientation.landscape
                        ? height * 15
                        : height * 6,

                    //alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 20),
                    decoration: BoxDecoration(
                      borderRadius: BorderRadius.circular(20),
                      //color: Colors.red,
                      gradient: LinearGradient(colors: [
                        gra1,
                        gra2,
                      ], begin: Alignment.topLeft),
                    ),
                    child: Center(
                        child: Text(
                      'Track Your Delivery',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
