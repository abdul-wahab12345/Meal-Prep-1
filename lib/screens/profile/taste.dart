import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/widgets/input_feild.dart';

class TasteTab extends StatelessWidget {
  TasteTab({Key? key}) : super(key: key);

  var _Alergcontroller = TextEditingController();
  var _disLikeController = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return Center(
        child: Column(
      children: [
        SizedBox(
          height: 20,
        ),
        TasteContainer(
          controller: _Alergcontroller,
          title: '⛔ Allergens',
        ),
        SizedBox(
          height: 18,
        ),
        TasteContainer(
          controller: _disLikeController,
          title: '🤢 Dislikes',
        ),
      ],
    ));
  }
}

class TasteContainer extends StatelessWidget {
  TasteContainer({
    required this.controller,
    required this.title,
  });

  final TextEditingController controller;

  String title;

  @override
  Widget build(BuildContext context) {
   Orientation currentOrientation = MediaQuery.of(context).orientation;
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;

   

    return Container(
      padding: EdgeInsets.all(30),
      height:currentOrientation==Orientation.landscape?height*60: height * 23,
      width:currentOrientation==Orientation.landscape?width*50: width * 80,
      decoration: BoxDecoration(
        color: aPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        children: [
          Container(
            child: Row(
              children: [
                Text(
                  title,
                  style: TextStyle(
                    fontFamily: 'IBM',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 25,
                  ),
                )
              ],
            ),
          ), //titleContainer
          InputFeild(
            hinntText: 'List Your Allergens',
            validatior: () {},
            inputController: controller,
          ),
        ],
      ),
    );
  }
}
