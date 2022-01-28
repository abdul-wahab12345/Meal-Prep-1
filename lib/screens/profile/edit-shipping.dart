import 'dart:async';

import 'package:flutter/material.dart';
import 'package:mealprep/Models/auth.dart';
import 'package:mealprep/Models/user.dart';
import 'package:mealprep/constant.dart';
import 'package:mealprep/screens/Plans/plans_screen.dart';

import 'package:mealprep/widgets/adaptive_indecator.dart';
import 'package:provider/provider.dart';
import 'package:webview_flutter/webview_flutter.dart';

class EditShipping extends StatefulWidget {
  static const routeName = '/edit-billing';
  const EditShipping({Key? key}) : super(key: key);

  @override
  State<EditShipping> createState() => _EditShippingState();
}

class _EditShippingState extends State<EditShipping> {
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
    var user = Provider.of<UserData>(context).user;
    var _appBar = AppBar(
      backgroundColor: aPrimary,
      title: const Text("Edit Shipping"),
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
                              user.imageUrl,  width: double.infinity,
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

                if (!value.contains("shipping")) {
                  Navigator.of(context).pop(true);
                }
              }, //aw_user_id=7&aw_secure_hash=a1572204518cdff08453a7ab6026885f7
              initialUrl: webUrl +
                  "my-account/edit-address/shipping/?aw_user_id=${userId}&aw_secure_hash=${aw_hash}",
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
