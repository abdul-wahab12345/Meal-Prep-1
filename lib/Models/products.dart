class Variation {
  int id;
  String title;
  double price;
  Variation({
    required this.id,
    required this.price,
    required this.title,
  });
}

class Product {
  int id;
  String title;
  List<Variation> variations;
  Product({
    required this.id,
    required this.title,
    required this.variations,
  });
}

class Products {
  List<Product> _products = [
    Product(
      id: 1,
      title: 'Balanced',
      variations: [
        Variation(
          id: 11,
          title: 'One Week Only',
          price: 76.25,
        ),
        Variation(
          id: 12,
          title: 'Five Meals',
          price: 86.25,
        ),
        Variation(
          id: 13,
          title: '10 Meals',
          price: 96.25,
        ),
      ],
    ),
    //2

    Product(
      id: 2,
      title: 'Lean',
      variations: [
        Variation(
          id: 21,
          title: 'One Week Only',
          price: 176.25,
        ),
        Variation(
          id: 22,
          title: 'Five Meals',
          price: 86.25,
        ),
        Variation(
          id: 23,
          title: '10 Meals',
          price: 196.25,
        ),
      ],
    ),

    //3
    Product(
      id: 3,
      title: 'Protien + Plan',
      variations: [
        Variation(
          id: 31,
          title: 'One Week Only',
          price: 6.25,
        ),
        Variation(
          id: 32,
          title: 'Five Meals',
          price: 36.25,
        ),
        Variation(
          id: 33,
          title: '10 Meals',
          price: 186.25,
        ),
      ],
    ),


  ];
}
