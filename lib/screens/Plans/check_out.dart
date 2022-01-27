import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/subscriptions.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';

import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class CheckOut extends StatefulWidget {
  static const routeName = '/checkOut';
  const CheckOut({Key? key}) : super(key: key);

  @override
  State<CheckOut> createState() => _CheckOutState();
}

class _CheckOutState extends State<CheckOut> {
  final Completer<WebViewController> _controller =
      Completer<WebViewController>();

  bool isLoading = false;

  var webUrl;
  @override
  void initState() {
    // TODO: implement initState
    //if (plateform.Platform.isAndroid) WebView.platform = AndroidWebView();

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    Map<String, int> argsData =
        ModalRoute.of(context)!.settings.arguments as Map<String, int>;
    int varId = 0;
    if (argsData['varId'] != 0) {
      varId = argsData['varId'] as int;
    }
    int subId = 0;
    int productId = 0;
    if (argsData['subId'] != 0) {
      subId = argsData['subId'] as int;
    }
    if (argsData['productId'] != 0) {
      productId = argsData['productId'] as int;
    }
  
    _controller.future.then((value) => print(value.currentUrl()));

    webUrl = Provider.of<Auth>(context, listen: false).websiteUrl;

    var userId = Provider.of<Auth>(context, listen: false).id;
    var aw_hash = Provider.of<Auth>(context, listen: false).aw_hash;
var user = Provider.of<UserData>(context).user;
    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Checkout"),
      actions: [
        GestureDetector(
          onTap: () async {
            Navigator.of(context)
                .pushReplacementNamed(PlanScreen.routeName, arguments: 2);
          },
          child: Container(
            padding: const EdgeInsets.all(8),
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
        appBar: _appBar,
        body: Stack(
          children: [
            WebView(
              onWebViewCreated: (value) {
                value.currentUrl().then((value) => print(value));
              },
              onPageStarted: (value) {
                setState(() {
                  isLoading = true;
                });
                print(value);
              },
              onPageFinished: (value) {
                setState(() {
                  isLoading = false;
                });
                print(value);

                if (value.contains("thank-you")) {
                  Provider.of<Subscriptions>(context, listen: false)
                      .emptySubscriptions();
                  Navigator.of(context)
                      .pushReplacementNamed(PlanScreen.routeName);
                }
              }, //aw_user_id=7&aw_secure_hash=a1572204518cdff08453a7ab6026885f7
              initialUrl: webUrl +
                  "cart?aw_add_to_cart1=$productId&aw_variation_id=$varId&aw_user_id=${userId}&aw_secure_hash=${aw_hash}&planId=${subId}",
              javascriptMode: JavascriptMode.unrestricted,
            ),
            if (isLoading)
              Center(
                child: AdaptiveIndecator(
                  color: Colors.black,
                ),
              )
          ],
        ));
  }
}
