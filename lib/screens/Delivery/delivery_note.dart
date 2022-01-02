import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class DeliveryNote extends StatefulWidget {
  DeliveryNote({Key? key}) : super(key: key);
  static const routeName = '/deliveryNote';

  @override
  State<DeliveryNote> createState() => _DeliveryNoteState();
}

class _DeliveryNoteState extends State<DeliveryNote> {
  var _formKey = GlobalKey<FormState>();

  var _noteController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    // var subscriptionId = ModalRoute.of(context)!.settings.arguments as int;
    // Subscription? subscription =
    //     Provider.of<Subscriptions>(context, listen: false)
    //         .getSubscriptionById(subscriptionId);

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    if (currentOrientation == Orientation.landscape) {
      height = 600 / 100;
    }
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text("Add Delivery Note"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName, arguments: 2);
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

                  return Stack(
                    children: [
                      //margin: EdgeInsets.only(top: 200),
                      Container(
                        margin: EdgeInsets.only(top: height * 20),
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(20),
                          color: aPrimary,
                        ),
                        padding: EdgeInsets.only(
                            top: height * 8, left: 30, right: 30),
                        height: height * 37,
                        child: Form(
                          key: _formKey,
                          child: TextFormField(
                            validator: (value) {
                              if (value!.isEmpty) {
                                return 'Please add a note then press button!';
                              }
                            },
                            onSaved: (value) {
                              print(value);
                            },
                            controller: _noteController,
                            maxLines: 6,
                            decoration: const InputDecoration(
                              border: InputBorder.none,
                              hintText: 'Click Here to add order note',
                              hintStyle: TextStyle(color: Colors.white),
                              errorStyle: TextStyle(fontSize: 10),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: Colors.transparent,
                                  width: 2,
                                  style: BorderStyle.solid,
                                ),
                              ),
                            ),
                          ),
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
                isLoading?Container(margin: EdgeInsets.only(top: 20),child: AdaptiveIndecator()): Center(
                child: GestureDetector(
                  onTap: ()  async{
                            // bool isvalid;
                            // if () {
                            //   isvalid = true;
                            // }
                            if (_formKey.currentState!.validate()) {
                              Map<String, dynamic> data = {
                                'aw_subscription_id': '1255',
                                'note': _noteController.text,
                                'note_type': 'delivery',
                              };
                             setState(() {
                                isLoading = true;
                             });
                              final response = await Provider.of<Subscriptions>(
                                      context,
                                      listen: false)
                                  .addNote(data)
                                  .then((value) {
                                setState(() {
                                  isLoading = false;
                                });
                              });
                              print(response);

                              _formKey.currentState!.save();
                              setState(() {
                                _noteController.clear();
                              });
                            }
                          },
                  child: Container(
                    width: currentOrientation == Orientation.landscape
                        ? width * 30
                        : width * 50,
                    height: currentOrientation == Orientation.landscape
                        ? height * 15
                        : height * 6,
                
                    //alignment: Alignment.bottomLeft,
                    margin: EdgeInsets.only(top: 30),
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
                      'Send Delivery Note',
                      style: Theme.of(context).textTheme.bodyText2,
                    )),
                  ),
                ),
              ),
                // Container(
                //   width: currentOrientation == Orientation.landscape
                //       ? width * 30
                //       : width * 50,
                //   height: currentOrientation == Orientation.landscape
                //       ? height * 15
                //       : height * 8,

                //   //alignment: Alignment.bottomLeft,
                //   margin: EdgeInsets.only(top: 10),
                //   child: isLoading
                //       ? AdaptiveIndecator()
                //       : CustomButton(
                //           text: 'Save Changes',
                //           callback: () async {
                //             bool isvalid;
                //             if (_formKey.currentState!.validate()) {
                //               isvalid = true;
                //             }
                //             if (isvalid = true) {
                //               Map<String, dynamic> data = {
                //                 'aw_subscription_id': '1255',
                //                 'note': _noteController.text,
                //                 'note_type': 'delivery',
                //               };
                //              setState(() {
                //                 isLoading = true;
                //              });
                //               final response = await Provider.of<Subscriptions>(
                //                       context,
                //                       listen: false)
                //                   .addNote(data)
                //                   .then((value) {
                //                 setState(() {
                //                   isLoading = false;
                //                 });
                //               });
                //               print(response);

                //               _formKey.currentState!.save();
                //               setState(() {
                //                 _noteController.clear();
                //               });
                //             }
                //           }),
                // ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
