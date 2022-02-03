import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';

import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';

import 'package:provider/provider.dart';

class DeliveryNote extends StatefulWidget {
  DeliveryNote({Key? key}) : super(key: key);
  static const routeName = '/delivery';

  @override
  State<DeliveryNote> createState() => _DeliveryNoteState();
}

class _DeliveryNoteState extends State<DeliveryNote> {
  final _formKey = GlobalKey<FormState>();

  final _noteController = TextEditingController();
  bool isLoading = false;

  @override
  void initState() {
    // TODO: implement initState
    super.initState();

    String delivery_note =
        Provider.of<UserData>(context, listen: false).delivery_note;
    if (delivery_note.isNotEmpty) {
      _noteController.text = delivery_note;
    }

    var user = Provider.of<UserData>(context, listen: false).user;
    if (user == null) {
      Provider.of<UserData>(context, listen: false).getUserData().then((value) {
        setState(() {
          String delivery_note =
              Provider.of<UserData>(context, listen: false).delivery_note;
          if (delivery_note.isNotEmpty) {
            _noteController.text = delivery_note;
          }
        });
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (ctx) => AdaptiveDiaglog(
                ctx: ctx,
                title: 'An Error Occurred',
                content: error.toString(),
                btnYes: 'Okay',
                yesPressed: () {
                  Navigator.of(ctx).pop();
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
    UserData userData = Provider.of<UserData>(context);
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    if (currentOrientation == Orientation.landscape) {
      height = 600 / 100;
    }

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
                      padding:
                          EdgeInsets.only(top: height * 8, left: 30, right: 30),
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
                          textInputAction: TextInputAction.done,
                          onFieldSubmitted: (_) {
                            FocusScope.of(context).unfocus();
                          },
                          maxLines: 6,
                          decoration: const InputDecoration(
                            enabledBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.white,
                                width: 2,
                                style: BorderStyle.solid,
                              ),
                            ),
                            hintText: 'Click Here to add order note',
                            hintStyle: TextStyle(color: Colors.white),
                            errorStyle: TextStyle(fontSize: 10),
                            focusedBorder: OutlineInputBorder(
                              borderRadius:
                                  BorderRadius.all(Radius.circular(10)),
                              borderSide: BorderSide(
                                color: Colors.white,
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
              Center(
                child: Container(
                  margin: const EdgeInsets.only(top: 30),
                  child: Text(
                    'Next Delivery: ${userData.next_delivery}',
                    style: Theme.of(context).textTheme.bodyText2,
                  ),
                ),
              ),
              isLoading
                  ? Container(
                      margin: const EdgeInsets.only(top: 20),
                      child: AdaptiveIndecator())
                  : Center(
                      child: GestureDetector(
                        onTap: () async {
                          if (_formKey.currentState!.validate()) {
                            int? user_id =
                                Provider.of<Auth>(context, listen: false).id;
                            Map<String, dynamic> data = {
                              'note': _noteController.text,
                              'user_id': user_id.toString(),
                            };
                            setState(() {
                              isLoading = true;
                            });
                            final response = await Provider.of<Subscriptions>(
                                    context,
                                    listen: false)
                                .addNote(data)
                                .then((value) async {
                              setState(() {
                                isLoading = false;
                              });
                              await showDialog(
                                  context: context,
                                  builder: (ctx) => AdaptiveDiaglog(
                                      ctx: ctx,
                                      title: 'Note',
                                      content: 'Your note has been updated',
                                      btnYes: 'Okay',
                                      yesPressed: () {
                                        Navigator.of(ctx).pop();
                                      }));
                              Provider.of<UserData>(context, listen: false)
                                  .setNote(_noteController.text);
                             // Navigator.of(context).pop();
                            }).catchError((error) {
                              setState(() {
                                isLoading = false;
                              });
                            });
                            // print(response);

                            _formKey.currentState!.save();
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
    );
  }
}
