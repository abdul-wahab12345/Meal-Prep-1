import 'dart:async';
import 'dart:io' as plateform;

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile/profile_screen.dart';
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
    _controller.future.then((value) => print(value.currentUrl()));

    webUrl = Provider.of<Auth>(context, listen: false).websiteUrl;

    var userId = Provider.of<Auth>(context, listen: false).id;
    var aw_hash = Provider.of<Auth>(context, listen: false).aw_hash;

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Add Plan"),
      actions: [
        GestureDetector(
          onTap: () async {
            Navigator.of(context).pushReplacementNamed(ProfileScreen.routeName);
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
              }, //aw_user_id=7&aw_secure_hash=a1572204518cdff08453a7ab6026885f7
              initialUrl: webUrl +
                  "?add-to-cart=1000&aw_user_id=${userId}&aw_secure_hash=${aw_hash}",
              javascriptMode: JavascriptMode.unrestricted,
            ),
            if(isLoading)
            Center(
              child: CupertinoActivityIndicator(radius: 15,),
            )
          ],
        ));
  }
}
