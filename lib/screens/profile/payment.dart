import 'package:flutter/material.dart';
import 'package:mealprep/constant.dart';

class PaymentTab extends StatelessWidget {
  const PaymentTab({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      margin: EdgeInsets.only(left: 40, right: 40, top: 40,bottom: 20),
      padding: EdgeInsets.only(top: 20,bottom:30,left: 10,right: 20),
      decoration: BoxDecoration(
          color: aPrimary, borderRadius: BorderRadius.circular(20)),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          ListTile(
            title: Text("FName LName"),
            subtitle:  InkWell(child: Text("Default Card",),splashColor: Colors.blue,focusColor: Colors.red ,onTap: (){
              print(1234);
            },),
            trailing: Container(
              child: Image.asset(
                "assets/images/card.png",
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 30,),
          Container(
            margin: EdgeInsets.only(left: 15,right: 20),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
              
              Text("**** **** **** 4242"),
              Text("MM/YY"),
              Text("***"),
            ],),
          )
        ],
      ),
    );
  }
}
