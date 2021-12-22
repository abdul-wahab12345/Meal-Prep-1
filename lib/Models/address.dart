import 'package:flutter/material.dart';

class Address {
  String street;
  String suit;
  String state;

  Address({
    required this.street,
    required this.suit,
    required this.state,
  });

 

}

class Addreses with ChangeNotifier{
   Map<String, Address> _address = {
    'Billing': Address(
      street: '123 Main St.',
      suit: 'suit 45',
      state: 'Houton,TX,77077',
    ),
    'Delivery': Address(
      street: '123 Main St.',
      suit: 'suit 45',
      state: 'Houton,TX,77077',
    ),
    
  };

  Map<String,Address> get address
  {
   return _address;
  }
}