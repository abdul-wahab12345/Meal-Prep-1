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
               SizedBox(height: 20,),
              TasteContainer(
                controller: _Alergcontroller,
                title: '⛔ Allergens',
              ),
              SizedBox(
                height: 30,
              ),
              TasteContainer(
                controller: _disLikeController,
                title: '🤢 Dislikes',
              ),
            ],
          )
    );
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
    return Container(
      padding: EdgeInsets.all(30),
      height: 250,
      width: 340,
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
