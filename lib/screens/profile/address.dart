import 'package:flutter/material.dart';
import 'package:mealprep/Models/address.dart';
import 'package:mealprep/constant.dart';
import 'package:provider/provider.dart';

class AddressTab extends StatelessWidget {
   AddressTab({Key? key}) : super(key: key);

  

  @override
  Widget build(BuildContext context) {
    Map<String,Address> add=Provider.of<Addreses>(context).address;
   print(add);


  
    return  Center(
          child: Column(
            children: [
               SizedBox(height: 20,),
              AddressContainer(title: '🚘 Delivery Address',address:add['Delivery'] as Address),
              SizedBox(height: 30,),
              AddressContainer(title: '🚩 Billing Address',address:add['Billing'] as Address),
            ],
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
    print(address.state);
     print(address.street);
      print(address.suit);
    return Container(
      padding: EdgeInsets.all(40),
      height: 235,
      width: 340,
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
            address.street,
            style: TextStyle(
              fontFamily: 'IBM',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              letterSpacing: 1.6,
            ),
          ),
          SizedBox(height: 5,),
          Text(address.suit,style: TextStyle(
            fontFamily: 'IBM',
              fontWeight: FontWeight.w400,
              fontStyle: FontStyle.normal,
              fontSize: 18,
              letterSpacing: 1.6,
            ),),
            SizedBox(height: 5,),
          Text(address.state,style: TextStyle(
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
