import 'package:flutter/material.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/check_out.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';

import 'package:mealprep/widgets/adaptivedialog.dart';
import 'package:provider/provider.dart';

class VariationsScreen extends StatelessWidget {
  static const routeName = '/variations';
  const VariationsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    var currentOrientation = Orientation.landscape;
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    Map<String, int> argsData =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int prodId = 0;
    if (argsData['prodID'] != 0) {
      prodId = argsData['prodId'] as int;
    }
    int subId = 0;
    if (argsData['subId'] != 0) {
      subId = argsData['subId'] as int;
    }var user = Provider.of<UserData>(context).user;
    print(subId);
    var product =
        Provider.of<Products>(context, listen: false).findById(prodId);
    var variation = product.variations;
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text("Variations"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, PlanScreen.routeName, arguments: 2);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              child: user != null
                        ? ClipRRect(
                            borderRadius: BorderRadius.circular(100),
                            child: Image.network(
                              user.imageUrl,
                              height: 40,
                              fit: BoxFit.cover,
                            ))
                        : Image.asset('assets/images/person.png'),
            ),
          ),
        )
      ],
    );
    return Scaffold(
      backgroundColor: Colors.black,
      appBar: _appBar,
      //bottomNavigationBar: bottomBar,

      body: Center(
        heightFactor: 1,
        child: Container(
          width: currentOrientation == Orientation.landscape
              ? 550
              : double.infinity,
          margin: const EdgeInsets.symmetric(
            horizontal: 15,
          ),
          child: ListView.builder(
            physics: BouncingScrollPhysics(),
            itemCount: variation.length,
            itemBuilder: (ctx, index) => GestureDetector(
              onTap: () {
                Navigator.of(context).pushNamed(
                  CheckOut.routeName,
                  arguments: <String, int>{
                    'varId': variation[index].id,
                    'subId': subId,
                    'productId': prodId
                  },
                );
              },
              child: Container(
                margin: const EdgeInsets.only(
                  top: 17,
                ),
                decoration: BoxDecoration(
                  color: aPrimary,
                  borderRadius: BorderRadius.circular(15),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Container(
                      margin: EdgeInsets.only(
                        left: width * 5,
                      ),
                      padding: const EdgeInsets.symmetric(
                        vertical: 19,
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(variation[index].title,
                              style: Theme.of(context).textTheme.headline6),
                          const SizedBox(
                            height: 20,
                          ),
                          Text(
                            'Delivery Date',
                            style: Theme.of(context).textTheme.bodyText2,
                          ),
                          const SizedBox(
                            height: 1.5,
                          ),
                          Text(variation[index].deliverDate,
                              style: Theme.of(context).textTheme.bodyText2!),
                          const SizedBox(
                            height: 25,
                          ),
                          Text(
                            'Starting \$${variation[index].price}',
                            style: Theme.of(context)
                                .textTheme
                                .bodyText2!
                                .copyWith(color: Colors.green),
                          ),
                        ],
                      ),
                    ), //ContentConatiner
                    Container(
                      width: 100,
                      margin: EdgeInsets.only(right: 15),
                      padding: const EdgeInsets.symmetric(vertical: 20),
                      child: Image.network(product.imageUrl, fit: BoxFit.cover),
                    ), //imageContainer
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
