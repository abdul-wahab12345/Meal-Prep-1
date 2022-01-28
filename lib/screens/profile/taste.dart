import 'package:flutter/material.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:mealprep/widgets/input_feild.dart';
import 'package:provider/provider.dart';

class TasteTab extends StatefulWidget {
  TasteTab({Key? key}) : super(key: key);

  @override
  State<TasteTab> createState() => _TasteTabState();
}

class _TasteTabState extends State<TasteTab> {
  var _Alergcontroller = TextEditingController();

  var _disLikeController = TextEditingController();

  bool isLoading = false;

  @override
  Widget build(BuildContext context) {
    MediaQueryData queryData;
    queryData = MediaQuery.of(context);
    var height = queryData.size.height / 100;
    var width = queryData.size.width / 100;

    UserData user = Provider.of<UserData>(context);

    _Alergcontroller.text = user.allergies;
    _disLikeController.text = user.dislikes;

    void addAllergies() {
      {
        setState(() {
          isLoading = true;
        });

        Provider.of<UserData>(context, listen: false)
            .addAllergies(_Alergcontroller.text, _disLikeController.text)
            .then((value) {
          showDialog(
              context: context,
              builder: (ctx) {
                return AdaptiveDiaglog(
                    ctx: ctx,
                    title: "Response",
                    btnYes: "Okay",
                    content: "Data updated!",
                    yesPressed: () {
                      setState(() {
                        isLoading = false;
                      });
                      Navigator.of(context).pop();
                    });
              });
        }).onError((error, stackTrace) {
          setState(() {
            isLoading = false;
          });
        });
        print(_disLikeController.text);
        print(_Alergcontroller.text);
      }
    }

    return Center(
        child: Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const SizedBox(
          height: 20,
        ),
        TasteContainer(
          controller: _Alergcontroller,
          title: '⛔ Allergens',
          labelText: 'Allergens',
        ),
        const SizedBox(
          height: 18,
        ),
        TasteContainer(
          controller: _disLikeController,
          title: '🤢 Dislikes',
          labelText: 'Dislikes',
        ),
        Container(
          padding: EdgeInsets.only(top: 18),
          width: width * 50,
          height: height * 8,
          child: isLoading
              ? AdaptiveIndecator()
              : CustomButton(
                  text: 'Save Changes',
                  callback: addAllergies,
                ),
        ),
        const SizedBox(
          height: 10,
        ),
      ],
    ));
  }
}

class TasteContainer extends StatefulWidget {
  TasteContainer({
    required this.controller,
    required this.title,
    required this.labelText,
  });

  final TextEditingController controller;

  String title;
  String labelText;

  @override
  State<TasteContainer> createState() => _TasteContainerState();
}

class _TasteContainerState extends State<TasteContainer> {
  List<String> labels = [];

  @override
  Widget build(BuildContext context) {
    Orientation currentOrientation = MediaQuery.of(context).orientation;
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

    return Container(
      padding: const EdgeInsets.only(top: 30, left: 30, right: 30, bottom: 50),
      width:
          currentOrientation == Orientation.landscape ? width * 50 : width * 80,
      decoration: BoxDecoration(
        color: aPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            alignment: Alignment.centerLeft,
            child: Text(
              widget.title,
              style: const TextStyle(
                fontFamily: 'IBM',
                fontWeight: FontWeight.w600,
                fontStyle: FontStyle.normal,
                fontSize: 20,
              ),
            ),
          ), //titleContainer
          Padding(
            padding: const EdgeInsets.only(top: 16.0),
            child: TextField(
              controller: widget.controller,
              decoration: InputDecoration(
                labelStyle: Theme.of(context).textTheme.bodyText2,
                label: Text('Enter comma seprated ${widget.labelText} '),
                enabledBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(20),
                  borderSide: const BorderSide(
                    width: 2,
                    color: Colors.white,
                  ),
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
