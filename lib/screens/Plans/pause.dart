import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:intl/intl.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';

import '../../constant.dart';

class Pause extends StatefulWidget {
  const Pause({Key? key}) : super(key: key);
  static const routeName = '/pause';

  @override
  State<Pause> createState() => _PauseState();
}

class _PauseState extends State<Pause> {
  var _controller = TextEditingController();
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
                      inputController: _controller,
                      hinntText: 'Choose a Date',
                      validatior: (value) {
                        return null;
                      },
                    ),
                  ),
                  Flexible(
                    flex: 1,
                    child: TextButton(
                      child: Text('Choose Date',style: TextStyle(color: btnColor),),
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
                          if(value == null){
                            return;
                          }
                          setState(() {
                            _dateTime = value;

                            _controller.text = DateFormat("M/d/y").format(value);
                            print(_dateTime.toString());
                          });
                        });
                      },
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.only(top:15,left: 10,right: 10),
              child: TextFormField(
                validator: (value) {
                  return null;
                },
                maxLines: 6,
                style: const TextStyle(color: Colors.white),
                decoration: InputDecoration(
                    fillColor: Colors.white,
                    contentPadding: EdgeInsets.all(18),
                    hintStyle: const TextStyle(color: Colors.white, fontSize: 14),
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
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    focusedErrorBorder: OutlineInputBorder(
                      borderRadius: BorderRadius.circular(20),
                      borderSide: const BorderSide(color: Colors.red, width: 2.0),
                    ),
                    errorStyle: Theme.of(context)
                        .textTheme
                        .caption!
                        .copyWith(color: Colors.red, fontSize: 12)),
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: Flex(
                direction: Axis.horizontal,
                children: [
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: CustomButton(text: "Save Changes", callback: () {})),
                  SizedBox(width: 15),
                  Flexible(
                      flex: 1,
                      fit: FlexFit.tight,
                      child: CustomButton(text: "Pause Indefinitely", callback: () {})),
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
