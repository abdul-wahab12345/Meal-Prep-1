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
  List<Subscription> _subscriptions = [
    Subscription(
      id: 1,
      title: 'Protein + Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/04/15meals-100x100.jpg',
          nextDelivery: '26/11/2021',
          status: 'active',
          isCutOf: true,
          productId: 3,
          variationId:32, 
    ),
    //2
     Subscription(
      id: 2,
      title: 'Lean + Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/04/15meals-100x100.jpg',
          nextDelivery: '27/11/2021',
          status: 'active',
          isCutOf: true,
          productId: 3,
          variationId:32, 
    ),
    //3
     Subscription(
      id: 3,
      title: 'Balanced Plan',
      imageUrl:
          'https://u1s.ee6.myftpupload.com/wp-content/uploads/2021/04/15meals-100x100.jpg',
          nextDelivery: '26/11/2021',
          status: 'active',
          isCutOf: true,
          productId: 3,
          variationId:32, 
    ),
  ];
}
