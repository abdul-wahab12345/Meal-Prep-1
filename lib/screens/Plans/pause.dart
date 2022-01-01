import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/adaptiveDialog.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:provider/provider.dart';

import '../../constant.dart';

class Pause extends StatefulWidget {
  const Pause({Key? key}) : super(key: key);
  static const routeName = '/pause';

  @override
  State<Pause> createState() => _PauseState();
}

class _PauseState extends State<Pause> {
  //var _controller = TextEditingController();
  var _dateController = TextEditingController();
  var _reasonController = TextEditingController();
  String _chk = "No";
  String errorText = '';
  bool indefinitltLoader = false;
  bool saveLoader = false;
  String deliveryDate = '';
  @override
  Widget build(BuildContext context) {
    DateTime _dateTime;

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: Text("Pause"),
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

    SystemChrome.setPreferredOrientations([
      DeviceOrientation.portraitUp,
      DeviceOrientation.portraitDown,
    ]);
    var data = ModalRoute.of(context)!.settings.arguments as int;
    Subscription? subscription =
        Provider.of<Subscriptions>(context, listen: false)
            .getSubscriptionById(data);

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      body: Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Text(
              "Pick your next delivery date:",
              style:
                  Theme.of(context).textTheme.bodyText2!.copyWith(fontSize: 17),
            ),
            Container(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  Flexible(
                    flex: 2,
                    child: InputFeild(
                      inputController: _dateController,
                      hinntText: 'Choose a Date',
                      validatior: (value) {
                        return null;
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      child: Text(
                        'Choose Date',
                        style: TextStyle(color: btnColor),
                      ),
                      onPressed: () {
                        var now = DateTime.now();

                        var today = DateTime.now();

                        showDatePicker(
                          context: context,
                          initialEntryMode: DatePickerEntryMode.calendarOnly,
                          initialDate: today.next(DateTime.sunday),
                          firstDate: now,
                          lastDate: DateTime(now.year + 2),
                          selectableDayPredicate: (DateTime val) =>
                              val.weekday != 7 ? false : true,
                        ).then((value) {
                          if (value == null) {
                            return;
                          }
                          setState(() {
                            _dateTime = value;

                            _dateController.text =
                                DateFormat("M/d/y").format(value);
                            deliveryDate = DateFormat("y-M-d").format(value);
                            print(deliveryDate);
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            if (subscription != null && subscription.isCutOf)
              Container(
                // color: Colors.white,
                margin: EdgeInsets.only(
                  top: 20,
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const Padding(
                      padding: EdgeInsets.only(left: 16.0),
                      child: Text(
                        'Do you want meals this Sunday ?',
                        style: TextStyle(
                          fontSize: 14,
                          fontFamily: 'IBM',
                          // fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    Row(
                      children: [
                        Row(
                          children: [
                            Radio(
                                overlayColor:
                                    MaterialStateProperty.all(btnColor),
                                hoverColor: btnColor,
                                fillColor: MaterialStateProperty.all(btnColor),
                                activeColor: btnColor,
                                focusColor: btnColor,
                                value: "Yes",
                                groupValue: _chk,
                                onChanged: (String? value) {
                                  setState(() {
                                    print(value);
                                    _chk = value!;
                                  });
                                }),
                            Text(
                              'Yes',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                        Row(
                          children: [
                            Radio(
                                overlayColor:
                                    MaterialStateProperty.all(btnColor),
                                hoverColor: btnColor,
                                fillColor: MaterialStateProperty.all(btnColor),
                                activeColor: btnColor,
                                focusColor: btnColor,
                                value: "No",
                                groupValue: _chk,
                                onChanged: (String? value) {
                                  setState(() {
                                    _chk = value!;
                                    print(value);
                                  });
                                }),
                            Text(
                              'No',
                              style: Theme.of(context).textTheme.bodyText2,
                            ),
                          ],
                        ),
                      ],
                    )
                  ],
                ),
              ), //radio button
            Container(
              margin: EdgeInsets.only(top: 15, left: 10, right: 10),
              child: TextFormField(
                controller: _reasonController,
                validator: (value) {
                  return null;
                },
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(18),
                    hintStyle:
                        const TextStyle(color: Colors.white, fontSize: 14),
                    hintText: "Reason!",
                    focusedBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    enabledBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.white, width: 2.0),
                    ),
                    errorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide:
                          const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    errorStyle: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.red, fontSize: 12)),
              ),
            ),
            if (errorText != '')
              Container(
                  margin: EdgeInsets.only(top: 20),
                  child: Text(
                    errorText,
                    style: TextStyle(color: Colors.red),
                  )),

            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: saveLoader
                          ? AdaptiveIndecator()
                          : CustomButton(
                              text: "Save Changes",
                              callback: indefinitltLoader
                                  ? () {
                                      setState(() {
                                        errorText =
                                            "You already pressed Pause Indefinitely button";
                                      });
                                    }
                                  : () {
                                      if (_reasonController.text.isEmpty ||
                                          _dateController.text.isEmpty) {
                                        setState(() {
                                          errorText =
                                              'Please enter the date and reason';
                                        });
                                      } else {
                                        setState(() {
                                          errorText = '';
                                          saveLoader = true;
                                        });
                                      }
                                    })),
                  SizedBox(width: 15),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: indefinitltLoader
                          ? AdaptiveIndecator()
                          : CustomButton(
                              text: "Pause Indefinitely",
                              callback: saveLoader
                                  ? () {
                                      setState(() {
                                        errorText =
                                            "You already pressed Save changes button";
                                      });
                                    }
                                  : () async{
                                      if (_reasonController.text.isEmpty) {
                                        setState(() {
                                          errorText = 'Please enter a reason';
                                        });
                                      } else {
                                        setState(() {
                                          errorText = '';
                                          indefinitltLoader = true;
                                        });
                                        int? user_id = Provider.of<Auth>(
                                                context,
                                                listen: false)
                                            .id;
                                        Map<String, dynamic> data = {
                                          'user_id': user_id.toString(),
                                          'type': 'indf',
                                          'id': subscription!.id.toString(),
                                          'aw_charged': subscription.isCharged
                                              ? 'true'
                                              : 'false',
                                          'reason': _reasonController.text,
                                        };
                                        if (subscription.isCutOf) {
                                          data.putIfAbsent('want_meal',
                                              () => _chk.toString());
                                        }
                                       String response = await Provider.of<Subscriptions>(context,
                                                listen: false)
                                            .pauseSubscription(data);
                                            print(response);
                                           showDialog(context: context, builder: (ctx){
                                             return AdaptiveDiaglog(
                                              ctx: context,
                                              title: 'Response',
                                              content: response,
                                              btnYes: "Okay",
                                              yesPressed: () {
                                                 Provider.of<Subscriptions>(context, listen: false).emptySubscriptions();
                                                Navigator.of(context)
                                                    .pushReplacementNamed(
                                                        PlanScreen.routeName,arguments: true);
                                              });
                                           });
                                            setState(() {
                                            indefinitltLoader = false;
                                            
                                          });
                                      }
                                    })),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

extension DateTimeExtension on DateTime {
  DateTime next(int day) {
    if (day == this.weekday)
      return this.add(Duration(days: 7));
    else {
      return this.add(
        Duration(
          days: (day - this.weekday) % DateTime.daysPerWeek,
        ),
      );
    }
  }

  DateTime previous(int day) {
    if (day == this.weekday)
      return this.subtract(Duration(days: 7));
    else {
      return this.subtract(
        Duration(
          days: (this.weekday - day) % DateTime.daysPerWeek,
        ),
      );
    }
  }
}
