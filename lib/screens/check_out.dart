import 'dart:async';
import 'dart:io' as plateform;

import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/profile_screen.dart';
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

    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Add Plan"),
      actions: [
        GestureDetector(
          onTap: () async {
            FutureBuilder<WebViewController>(
                future: _controller.future,
                builder: (BuildContext context,
                    AsyncSnapshot<WebViewController> controller) {
                  if (controller.hasData) {
                    controller.data!.currentUrl().then((value) => print(value));
                  }
                  if (controller.hasError) {
                    print('g error ha');
                  }
                  return Container();
                });
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
        body: WebView(
          onWebViewCreated: (value) {
            value.currentUrl().then((value) => print(value));
          },
          onPageStarted: (value) {
            print(value);
          },
          onPageFinished: (value) {
            print(value);
          },
          initialUrl: webUrl + "?add-to-cart=1000",
          javascriptMode: JavascriptMode.unrestricted,
        ));
  }
}
