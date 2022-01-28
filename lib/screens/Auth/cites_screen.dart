import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';

import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Auth/login_screen.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';

import 'package:mealprep/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class CityScreen extends StatefulWidget {
  static const routeName = '/city-screen';
  const CityScreen({Key? key}) : super(key: key);

  @override
  State<CityScreen> createState() => _CityScreenState();
}

class _CityScreenState extends State<CityScreen> {
  String dropdownValue = 'Select a City';

  List<Map<String, String>> cities = <Map<String, String>>[
    {
      'text': 'Select a City',
      'value': 'Select a City',
    },
    {
      'text': 'Austin Demo',
      'value': 'https://u1s.ee6.myftpupload.com/',
    },
    {
      'text': 'Austin',
      'value': 'https://austinmealprep.com/',
    },
    {
      'text': 'Houston',
      'value': 'https://houstonmealprep.com/',
    },
  ];

  List<String> cityNames = [
    'Select a City',
    'Austin Demo',
    'Austin',
    'Houston'
  ];

  @override
  Widget build(BuildContext context) {
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    return Scaffold(
      backgroundColor: abackground,
      body: Container(
        width: double.infinity,
        margin: const EdgeInsets.symmetric(horizontal: 20),
        child: Column(
          children: [
            Container(
              margin: EdgeInsets.only(top: height * 12),
              height: height * 16,
              width: height * 16,
              child: Image.asset('assets/images/login_screen_image.png'),
            ), //Image Container
            SizedBox(
              height: height * 35,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              height: height * 6,
              width: double.infinity,
              alignment: Alignment.center,
              margin: EdgeInsets.only(bottom: height * 3, top: height * 5),
              decoration: BoxDecoration(
                border: Border.all(color: Colors.white, width: 1.5),
                borderRadius: BorderRadius.circular(20),
              ),
              child: DropdownButton<String>(
                isExpanded: true,
                value: dropdownValue,
                dropdownColor: aPrimary,
                icon: const Icon(Icons.arrow_downward, color: Colors.white),
                iconSize: 24,
                elevation: 16,
                style: const TextStyle(color: Colors.white),
                underline: Container(
                  height: 1,
                  color: Colors.transparent,
                ),
                onChanged: (String? newValue) {
                  setState(() {
                    dropdownValue = newValue!;
                  });
                },
                items: cityNames.map<DropdownMenuItem<String>>((String value) {
                  return DropdownMenuItem<String>(
                    value: value,
                    child: Text(
                      value,
                    ),
                  );
                }).toList(),
              ),
            ),
            //Dropdown Container

            CustomButton(
              text: 'Next',
              callback: () async {
                if (dropdownValue == "Select a City") {
                  await showDialog(
                    context: context,
                    builder: (ctx) {
                      return AdaptiveDiaglog(
                        ctx: ctx,
                        title: 'An error has occured!',
                        content: 'Please select a city!',
                        btnYes: 'Okay',
                        yesPressed: () {
                          Navigator.of(ctx).pop(true);
                        },
                      );
                    },
                  );
                } else {
                  var city = cities.firstWhere(
                      (element) => element['text'] == dropdownValue);
                  //print(city['value']);
                  Provider.of<Auth>(context, listen: false)
                      .setWebUrl(city['value'] as String);
                  Navigator.of(context).pushNamed(LoginScreen.routeName);
                }
              },
            ),

            //Text button Container
          ],
        ),
      ),
    );
  }
}
