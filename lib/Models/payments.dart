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

class Payments {
  List<Card> cards = [
    Card(
      name: 'Sufyan Sajid',
      btnText: 'Click here',
      cardNumber: '456879555254545',
      date: '12/12/2021',
    ),
    Card(
      name: 'Abdul Wahab',
      btnText: 'Click ME',
      cardNumber: '456879555254545',
      date: '12/12/2021',
    ),
  ];
}
