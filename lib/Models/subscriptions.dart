class Subscription {
  int id;
  String title;
  String imageUrl;
  String nextDelivery;
  String status;
  bool isCutOf;
  int productId;
  int variationId;

  Subscription({
    required this.id,
    required this.title,
    required this.imageUrl,
    required this.nextDelivery,
    required this.status,
    required this.isCutOf,
    required this.productId,
    required this.variationId,
  });
}

class Subscriptions {
  final List<Subscription> _subscriptions = [
    Subscription(
      id: 1,
      title: 'Protein + Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      nextDelivery: '26/11/2021',
      status: 'Active',
      isCutOf: true,
      productId: 3,
      variationId: 32,
    ),
    //2
    Subscription(
      id: 2,
      title: 'Lean + Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      nextDelivery: '27/11/2021',
      status: 'Paused',
      isCutOf: true,
      productId: 3,
      variationId: 32,
    ),
    //3
    Subscription(
      id: 3,
      title: 'Balanced Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      nextDelivery: '26/11/2021',
      status: 'Inactive',
      isCutOf: true,
      productId: 3,
      variationId: 32,
    ),
    //4
    Subscription(
      id: 4,
      title: 'Deit + Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      nextDelivery: '2/11/2021',
      status: 'Paused',
      isCutOf: true,
      productId: 3,
      variationId: 32,
    ),
    //5
    Subscription(
      id: 5,
      title: 'Fatty + Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/11/Dish-8-1-300x300.png',
      nextDelivery: '2/11/2021',
      status: 'Active',
      isCutOf: true,
      productId: 3,
      variationId: 32,
    ),
  ];

  List<Subscription> get subscriptions {
    return [..._subscriptions];
  }
}
