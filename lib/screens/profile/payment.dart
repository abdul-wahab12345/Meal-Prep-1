import 'package:flutter/material.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class PaymentTab extends StatelessWidget {
  double height;
  PaymentTab({required this.height});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context).user;

    return Column(
      children: user!.paymentMethod.map((card) {
        return Container(
          width: double.infinity,
          margin: EdgeInsets.only(
            left: 40,
            right: 40,
            top: 20,
          ),
          padding: EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 20),
          decoration: BoxDecoration(
              color: aPrimary, borderRadius: BorderRadius.circular(20)),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              ListTile(
                title: Text(card.name),
                subtitle: InkWell(
                  child: Text(
                    card.isDefault ? "Default Card" : "Make Default",
                    style: TextStyle(
                        color: card.isDefault ? labelBlue : labelPurple,fontWeight: FontWeight.w600),
                  ),
                  splashColor: Colors.blue,
                  focusColor: Colors.red,
                  onTap: () {
                    if (!card.isDefault) {
                      print(1234);
                    }
                  },
                ),
                trailing: Container(
                  child: Image.asset(
                    "assets/images/card.png",
                    fit: BoxFit.cover,
                  ),
                ),
              ),
              SizedBox(
                height: 30,
              ),
              Container(
                margin: EdgeInsets.only(left: 15, right: 20),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Text("**** **** **** ${card.cardNumber}"),
                    Text(card.date),
                    Text("***"),
                  ],
                ),
              )
            ],
          ),
        );
      }).toList(),
    );
  }
}
