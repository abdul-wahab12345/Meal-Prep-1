

class Card {
  String name;
  String btnText;
  String cardNumber;
  String date;

  Card({
    required this.name,
    required this.btnText,
    required this.cardNumber,
    required this.date,
  });
}

class Address {
  String ad1;
  String ad2;
  String city;
  String state;
  int postalCode;

  Address({
    required this.ad1,
    required this.ad2,
    required this.city,
    required this.state,
    required this.postalCode,
  });
}

class User {
  String name;
  String imageUrl;
  String email;
  List<Card> paymentMethod;
  Address billingAddress;
  Address shippingAddress;

  User({
    required this.name,
    required this.imageUrl,
    required this.email,
    required this.paymentMethod,
    required this.billingAddress,
    required this.shippingAddress,
  });
}
