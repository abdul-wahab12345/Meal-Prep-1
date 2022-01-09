

import 'package:flutter/material.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Delivery/delivery_screen.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';

import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';

import 'package:provider/provider.dart';

class DeliveryNote extends StatefulWidget {
  DeliveryNote({Key? key}) : super(key: key);
  static const routeName = '/deliveryNote';

  @override
  State<DeliveryNote> createState() => _DeliveryNoteState();
}

class _DeliveryNoteState extends State<DeliveryNote> {
  final _formKey = GlobalKey<FormState>();

  final _noteController = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;


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
            padding: const EdgeInsets.all(8),
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
          
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
            
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                LayoutBuilder(builder: (context, constraint) {
                  var stack_height = constraint.maxHeight;
                  var stack_width = constraint.maxWidth / 2;

                  return Stack(
                    children: [
                    
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
                isLoading
                    ? Container(
                        margin: const EdgeInsets.only(top: 20),
                        child: AdaptiveIndecator())
                    : Center(
                        child: GestureDetector(
                          onTap: () async {
                           
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
                                showDialog(
                                    context: context,
                                    builder: (ctx) => AdaptiveDiaglog(
                                        ctx: ctx,
                                        title: 'Note',
                                        content: 'Your note has been updated',
                                        btnYes: 'Okay',
                                        yesPressed: () {
                                          Navigator.of(context).pushNamed(
                                              DeliveryScreen.routeName);
                                        }));
                              });
                              // print(response);

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
                            margin: const EdgeInsets.only(top: 30),
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
              ],
            ),
          ),
        ),
      ),
    );
  }
}
