import 'package:flutter/material.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Delivery/delivery_note.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:provider/provider.dart';

class DeliveryScreen extends StatefulWidget {
  static const routeName = '/delivery';
  DeliveryScreen({Key? key}) : super(key: key);

  @override
  State<DeliveryScreen> createState() => _DeliveryScreenState();
}

class _DeliveryScreenState extends State<DeliveryScreen> {
  bool isLoading = false;
  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    var user = Provider.of<UserData>(context, listen: false).user;
    if (user == null) {
      Provider.of<UserData>(context, listen: false)
          .getUserData()
          .catchError((error) {
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'An Error Occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(context).pop();
                  setState(() {
                    //to stop loading
                  });
                }));
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    UserData userData = Provider.of<UserData>(context);

    return Center(
      heightFactor: 1,
      child: Container(
        width:
            currentOrientation == Orientation.landscape ? 600 : double.infinity,
        margin: const EdgeInsets.only(left: 20, right: 20),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              LayoutBuilder(builder: (context, constraint) {
                var stackWidth = constraint.maxWidth / 2;

                return Stack(
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.of(context).pushNamed(DeliveryNote.routeName);
                      },
                      child: Container(
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
                            if (userData.delivery_note.isNotEmpty)
                              Text(
                                userData.delivery_note,
                                style: Theme.of(context).textTheme.bodyText2,
                              ),
                            Text(
                              'Click Here to update your delivery note...',
                              style: Theme.of(context).textTheme.bodyText2,
                            )
                          ],
                        ),
                      ),
                    ),
                    Positioned(
                      left: (stackWidth - (width * 35)),
                      bottom: height * 33,
                      child: Image.asset('assets/images/car.png',
                          height: height * 10, width: width * 70),
                    ), //imageConatiner
                  ],
                );
              }),
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Next Delivery: ${userData.next_delivery}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              // Center(
              //   child: Container(
              //     width: currentOrientation == Orientation.landscape
              //         ? width * 30
              //         : width * 50,
              //     height: currentOrientation == Orientation.landscape
              //         ? height * 15
              //         : height * 6,

              //     margin: const EdgeInsets.only(top: 20),
              //     decoration: BoxDecoration(
              //       borderRadius: BorderRadius.circular(20),

              //       gradient: LinearGradient(colors: [
              //         gra1,
              //         gra2,
              //       ], begin: Alignment.topLeft),
              //     ),
              //     child: Center(
              //         child: Text(
              //       'Track Your Delivery',
              //       style: Theme.of(context).textTheme.bodyText2,
              //     )),
              //   ),
              // ),
            ],
          ),
        ),
      ),
    );
  }
}
