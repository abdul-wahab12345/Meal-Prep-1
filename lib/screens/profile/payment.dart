import 'package:flutter/material.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile/add-payment.dart';
import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:mealprep/widgets/auth_button.dart';
import 'package:provider/provider.dart';

class PaymentTab extends StatefulWidget {
  double height;
  Function refresh;
  PaymentTab({required this.height, required this.refresh});

  @override
  State<PaymentTab> createState() => _PaymentTabState();
}

class _PaymentTabState extends State<PaymentTab> {
  var paymentId = null;
  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context).user;

    void setDefaultPayment() {
      Provider.of<UserData>(context, listen: false)
          .setDefaultPayment(paymentId)
          .then((value) {
        setState(() {
          paymentId = 0;
          widget.refresh();
        });
      }).catchError((error) {
        showDialog(
            context: context,
            builder: (ctx) {
              return AdaptiveDiaglog(
                  ctx: ctx,
                  title: "An error occured",
                  btnYes: 'Okay',
                  yesPressed: () {
                    setState(() {
                      paymentId = 0;
                    });
                    Navigator.of(ctx).pop();
                  });
            });
      });
    }

    return Column(children: [
      if (user!.paymentMethod.isEmpty)
        const Padding(
          padding: EdgeInsets.only(top: 28.0),
          child: Center(
            child: Text('No Payment Method Found'),
            heightFactor: 1,
          ),
        ),
      if (user.paymentMethod.isNotEmpty)
        ...user.paymentMethod.map((card) {
          return Container(
            width: double.infinity,
            margin: const EdgeInsets.only(
              left: 40,
              right: 40,
              top: 20,
            ),
            padding:
                const EdgeInsets.only(top: 20, bottom: 30, left: 10, right: 20),
            decoration: BoxDecoration(
                color: aPrimary, borderRadius: BorderRadius.circular(20)),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                ListTile(
                  title: Text(card.name),
                  subtitle: paymentId == card.id
                      ? AdaptiveIndecator()
                      : InkWell(
                          child: Text(
                            card.isDefault ? "Default Card" : "Make Default",
                            style: TextStyle(
                                color: card.isDefault ? labelBlue : labelPurple,
                                fontWeight: FontWeight.w600),
                          ),
                          splashColor: Colors.blue,
                          focusColor: Colors.red,
                          onTap: () {
                            if (!card.isDefault) {
                              setState(() {
                                paymentId = card.id;
                              });
                              setDefaultPayment();
                            }
                          },
                        ),
                  trailing: Image.asset(
                    "assets/images/card.png",
                    fit: BoxFit.cover,
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Container(
                  margin: const EdgeInsets.only(left: 15, right: 20),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text("**** **** **** ${card.cardNumber}"),
                      Text(card.date),
                      const Text("***"),
                    ],
                  ),
                )
              ],
            ),
          );
        }).toList(),
      SizedBox(
        height: 15,
      ),
      CustomButton(
          text: "Add Payment Method",
          callback: () async {
            final isLoad = await Navigator.of(context).push<bool>(
              MaterialPageRoute(
                fullscreenDialog: true,
                builder: (ctx) => AddPayment(),
              ),
            );
            if (isLoad != null && isLoad) {
              widget.refresh();
            }
          }),
      const SizedBox(
        height: 10,
      ),
    ]);
  }
}
