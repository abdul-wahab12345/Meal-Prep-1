import 'package:flutter/material.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';

import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class AddNote extends StatefulWidget {
  AddNote({Key? key}) : super(key: key);
  static const routeName = '/add_note';

  @override
  State<AddNote> createState() => _AddNoteState();
}

class _AddNoteState extends State<AddNote> {
  var _formKey = GlobalKey<FormState>();

  var noteContrller = TextEditingController();
  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;

    var subscriptionId = ModalRoute.of(context)!.settings.arguments as int;
    Subscription? subscription =
        Provider.of<Subscriptions>(context, listen: false)
            .getSubscriptionById(subscriptionId);

    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    if (currentOrientation == Orientation.landscape) {
      height = 600 / 100;
    }
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text("Add Note"),
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
          //height: currentOrientation==Orientation.landscape?200:,
          margin: const EdgeInsets.only(left: 20, right: 20),
          child: SingleChildScrollView(
            child: Column(
              //mainAxisAlignment: MainAxisAlignment.start,
              
              crossAxisAlignment: CrossAxisAlignment.center,
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
                            controller: noteContrller,
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
                        left: (stack_width - 60),
                        bottom: height * 32,
                        child: Container(
                          height: 120,
                          width: 120,
                          child: ClipRRect(
                              borderRadius: BorderRadius.circular(20),
                              child: Hero(
                                tag: subscription!.id,
                                child: Image.network(
                                  subscription.imageUrl,
                                  fit: BoxFit.cover,
                                ),
                              )),
                        ),
                      ), //imageConatiner
                    ],
                  );
                }),
                Container(
                  width: currentOrientation == Orientation.landscape
                      ? width * 30
                      : width * 50,
                  height: currentOrientation == Orientation.landscape
                      ? height * 15
                      : height * 8,

                  //alignment: Alignment.bottomLeft,
                  margin: const EdgeInsets.only(top: 10),
                  child: isLoading
                      ? Center(child: AdaptiveIndecator())
                      : Container(
                       // alignment: Alignment.c,
                        padding: const EdgeInsets.only(top:16),
                        height: height*6,
                        width: width*50,
                        child: CustomButton(
                            text: 'Save Changes',
                            callback: () async {
                              if (_formKey.currentState!.validate()) {
                                Map<String, dynamic> data = {
                                  'aw_subscription_id': subscriptionId.toString(),
                                  'note': noteContrller.text,
                                  'note_type': 'subscription',
                                };
                                setState(() {
                                  isLoading = true;
                                });

                                var response = await Provider.of<Subscriptions>(
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
                                            Navigator.of(context)
                                                .pushNamed(PlanScreen.routeName);
                                          }));
                                }).catchError((error) {
                                  showDialog(
                                      context: context,
                                      builder: (ctx) => AdaptiveDiaglog(
                                          ctx: ctx,
                                          title: 'Error occurred',
                                          content: error.toString(),
                                          btnYes: 'Okay',
                                          yesPressed: () {
                                            Navigator.of(context).pop();
                                            setState(() {
                                              isLoading = false;
                                            });
                                          }));
                                });

                                _formKey.currentState!.save();
                                setState(() {
                                  noteContrller.clear();
                                });
                              }
                            }),
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
