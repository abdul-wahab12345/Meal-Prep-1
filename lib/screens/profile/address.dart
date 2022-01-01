import 'package:flutter/material.dart';

import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class AddressTab extends StatelessWidget {
   AddressTab({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    var user=Provider.of<UserData>(context).user;
    
 

  
    return  Center(
          child: SingleChildScrollView(
            child: Column(
              children: [
                 SizedBox(height: 20,),
                AddressContainer(title: '🚘 Delivery Address',address:user!.shippingAddress),
                SizedBox(height: 20,),
                AddressContainer(title: '🚩 Billing Address',address: user.billingAddress,),
              ],
            ),
          )
    );
  }
}

class AddressContainer extends StatelessWidget {
  AddressContainer({required this.title,required this.address});

  String title;
   Address address;

  @override
  Widget build(BuildContext context) {

    
    
    final height=MediaQuery.of(context).size.height/100;
    final width=MediaQuery.of(context).size.width/100;
    // print(address.state);
    //  print(address.street);
    //   print(address.suit);
    return Container(
      padding: EdgeInsets.all(40),
      height: height*23,
      width: width*80,
      decoration: BoxDecoration(
        color: aPrimary,
        borderRadius: BorderRadius.circular(20),
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children:  [
           Text(
            title,
            style: TextStyle(
              fontFamily: 'IBM',
              fontWeight: FontWeight.w600,
              fontStyle: FontStyle.normal,
              fontSize: 25,
            ),
          ),
          // SizedBox(height: 40,),
          Spacer(),
          
          Text(
            address.ad1,
            style: TextStyle(
              fontFamily: 'IBM',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              letterSpacing: 1.6,
            ),
          ),
          SizedBox(height: 5,),
          Text(address.city,style: TextStyle(
            fontFamily: 'IBM',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              letterSpacing: 1.6,
            ),),
            SizedBox(height: 5,),
          Text('${address.state}, ${address.postalCode}',style: TextStyle(
            fontFamily: 'IBM',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              letterSpacing: 1.6,
            ),),
        ],
      ),
    );
  }
}
