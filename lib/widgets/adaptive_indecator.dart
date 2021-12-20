import 'dart:io';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class AdaptiveIndecator extends StatelessWidget {
  const AdaptiveIndecator({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Platform.isIOS
          ? CupertinoActivityIndicator(radius: 20)
          : CircularProgressIndicator(
              color: Colors.white,
            ),
    );
  }
}
