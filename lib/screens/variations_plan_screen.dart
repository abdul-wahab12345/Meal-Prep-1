import 'dart:io';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealprep/Models/products.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/check_out.dart';
import 'package:mealprep/screens/profile_screen.dart';
import 'package:provider/provider.dart';

class VariationsScreen extends StatelessWidget {
  static const routeName = '/variations';
  const VariationsScreen({Key? key}) : super(key: key);
  

  @override
  Widget build(BuildContext context) {
    var currentOrientation = Orientation.landscape;
    var height = MediaQuery.of(context).size.height / 100;
    var width = MediaQuery.of(context).size.width / 100;
    final prodId = ModalRoute.of(context)!.settings.arguments;
    var product =
        Provider.of<Products>(context, listen: false).findById(prodId as int);
    var variation = product.variations;
    var _appBar = AppBar(
      backgroundColor: Colors.black,
      title: const Text("Variations"),
      actions: [
        GestureDetector(
          onTap: () {
            Navigator.pushNamed(context, ProfileScreen.routeName);
          },
          child: Container(
            padding: EdgeInsets.all(8),
            child: CircleAvatar(
              child: Image.asset('assets/images/person.png'),
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
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Container(
                  height: currentOrientation == Orientation.landscape
                      ? height * 70
                      : height * 78,
                  child: ListView.builder(
                    itemCount: variation.length,
                    itemBuilder: (ctx, index) => GestureDetector(
                      onTap: () {
                        showDialog(
                          context: ctx,
                          builder: (ctx) => Platform.isIOS
                              ? CupertinoAlertDialog(
                                  content: Text("Do wana take this deal",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  actions: [
                                    CupertinoDialogAction(
                                      child: TextButton(
                                        child: Text('Yes'),
                                      
                                        onPressed: (){
                                          Navigator.of(context).pushNamed(CheckOut.routeName,arguments:variation[index].id,);
                                        },
                                       
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    CupertinoDialogAction(
                                      child: Text(
                                        'No',
                                      
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                )
                              : AlertDialog(
                                  //title: Text("An error has occured"),
                                  content: Text("Do wana take this deal",
                                      style: TextStyle(
                                        color: Colors.black,
                                      )),
                                  actions: [
                                    TextButton(
                                      child: Text(
                                        'Yes!',
                                        style: TextStyle(color: btnColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                    TextButton(
                                      child: Text(
                                        'No!',
                                        style: TextStyle(color: btnColor),
                                      ),
                                      onPressed: () {
                                        Navigator.of(context).pop();
                                      },
                                    ),
                                  ],
                                ),
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
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  Text(variation[index].title,
                                      style: Theme.of(context)
                                          .textTheme
                                          .headline6),
                                  SizedBox(
                                    height: 20,
                                  ),
                                  Text(
                                    'Delivery Date',
                                    style:
                                        Theme.of(context).textTheme.bodyText2,
                                  ),
                                  SizedBox(
                                    height: 1.5,
                                  ),
                                  Text(variation[index].deliverDate,
                                      style: Theme.of(context)
                                          .textTheme
                                          .bodyText2!),
                                  SizedBox(
                                    height: 25,
                                  ),
                                  Text(
                                    variation[index].price,
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
                              padding: const EdgeInsets.symmetric(vertical: 20),
                              child: Image.network(product.imageUrl,
                                  fit: BoxFit.cover),
                            ), //imageContainer
                          ],
                        ),
                      ),
                    ),
                  ),
                ), //Listview end
              ],
            ),
          ),
        ),
      ),
    );
  }
}
