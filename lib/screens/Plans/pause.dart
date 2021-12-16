import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:mealprep/widgets/auth_button.dart';

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

    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      body: Column(
        children: [
          Container(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                Container(
                  width: 250,
                  child: TextField(
                    controller: _controller,
                    decoration: InputDecoration(
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.white,
                          width: 2,
                          style: BorderStyle.solid,
                        ),
                        borderRadius: BorderRadius.circular(20),
                      ),
                      hintText: 'Choose a Date',
                      hintStyle: TextStyle(color: Colors.white),
                    ),
                  ),
                ),
                TextButton(
                  child: Text('Choose Date'),
                  onPressed: () {
                    var now = DateTime.now();

                    var today = DateTime.now();

                    showDatePicker(
                      builder: (ctx, widget) {
                        return Theme(
                          child: widget as Widget,
                          data: ThemeData.dark().copyWith(
                            colorScheme: ColorScheme.dark(
                              primary: Colors.purple,
                              onPrimary:Colors.red,
                              surface: Colors.blue,
                              onSurface: Colors.black
                            ),
                            dialogBackgroundColor: Colors.yellowAccent,
                          ),
                          
                        );
                      },
                      context: context,
                      initialEntryMode: DatePickerEntryMode.calendarOnly,
                      initialDate: today.next(DateTime.sunday),
                      firstDate: now,
                      lastDate: DateTime(now.year + 2),
                      selectableDayPredicate: (DateTime val) =>
                          val.weekday != 7 ? false : true,
                    ).then((value) {
                      setState(() {
                        _dateTime = value!;

                        _controller.text = value.toString();
                        print(_dateTime.toString());
                      });
                    });
                  },
                )
              ],
            ),
          ),
        ],
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
