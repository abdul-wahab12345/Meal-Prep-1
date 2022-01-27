import 'package:flutter/material.dart';

import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile/edit-billing-address.dart';
import 'package:mealprep/screens/profile/edit-shipping.dart';
import 'package:provider/provider.dart';

class AddressTab extends StatelessWidget {
  Function refresh;
  AddressTab({required this.refresh});

  @override
  Widget build(BuildContext context) {
    var user = Provider.of<UserData>(context).user;
    print(user);

    return Center(
        child: SingleChildScrollView(
      child: Column(
        children: [
          const SizedBox(
            height: 20,
          ),
          if (user!.billingAddress.ad1.isEmpty)
            Center(
              child: Text(
                "No billing address found",
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
          GestureDetector(
            onTap: () async {
              final isLoad = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => EditShipping(),
                ),
              );
              if (isLoad != null && isLoad) {
                refresh(1);
              }
            },
            child: AddressContainer(
                title: '🚘 Delivery Address', address: user.shippingAddress),
          ),
          const SizedBox(
            height: 20,
          ),
          GestureDetector(
            onTap: () async {
              final isLoad = await Navigator.of(context).push<bool>(
                MaterialPageRoute(
                  fullscreenDialog: true,
                  builder: (ctx) => EditBilling(),
                ),
              );
              if (isLoad != null && isLoad) {
                refresh(1);
              }
            },
            child: AddressContainer(
              title: '🚩 Billing Address',
              address: user.billingAddress,
            ),
          ),
          const SizedBox(
            height: 10,
          ),
        ],
      ),
    ));
  }
}

class AddressContainer extends StatelessWidget {
  AddressContainer({required this.title, required this.address});

  String title;
  Address address;

  @override
  Widget build(BuildContext context) {
    final height = MediaQuery.of(context).size.height / 100;
    final width = MediaQuery.of(context).size.width / 100;

    return address.state.isNotEmpty
        ? Container(
            padding:
                const EdgeInsets.only(top: 33, right: 30, left: 30, bottom: 33),
            //height: height*23,
            width: width * 80,
            decoration: BoxDecoration(
              color: aPrimary,
              borderRadius: BorderRadius.circular(20),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  title,
                  style: const TextStyle(
                    fontFamily: 'IBM',
                    fontWeight: FontWeight.w600,
                    fontStyle: FontStyle.normal,
                    fontSize: 20,
                  ),
                ),
                SizedBox(
                  height: 20,
                ),
                //Spacer(),

                Text(
                  address.ad1,
                  style: const TextStyle(
                    fontFamily: 'IBM',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 16,
                    letterSpacing: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  address.city,
                  style: const TextStyle(
                    fontFamily: 'IBM',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    letterSpacing: 1.6,
                  ),
                ),
                const SizedBox(
                  height: 5,
                ),
                Text(
                  '${address.state}, ${address.postalCode}',
                  style: const TextStyle(
                    fontFamily: 'IBM',
                    fontWeight: FontWeight.w400,
                    fontStyle: FontStyle.normal,
                    fontSize: 18,
                    letterSpacing: 1.6,
                  ),
                ),
              ],
            ),
          )
        : Container();
  }
}
